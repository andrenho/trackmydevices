resource "null_resource" "create_keypair" {
  provisioner "local-exec" {
    command = "./create_key.sh"
  }
}

resource "aws_security_group" "bastion" {
  name = "bastion_sg"
  vpc_id = "${aws_vpc.main.id}"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  depends_on = ["null_resource.create_keypair"]

  ami                         = "ami-0b69ea66ff7391e80"  # amazon linux
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "bastion"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  subnet_id                   = "${aws_subnet.public_a.id}"

  user_data = <<EOF
#!/bin/sh
yum install postgresql -y
EOF
  
  # TODO - user data
  # TODO - ephemeral block device

  tags = {
    Name    = "bastion"
    Creator = "backend"
  }
}

resource "aws_eip" "bastion_ip" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}

resource "aws_route53_record" "bastion" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "bastion.tmd.gamesmith.co.uk."
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.bastion_ip.public_ip}"]
}
