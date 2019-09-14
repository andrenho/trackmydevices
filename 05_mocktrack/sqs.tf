resource "aws_sqs_queue" "terraform_queue" {
  name             = "trackqueue"
  max_message_size = 1024
}
