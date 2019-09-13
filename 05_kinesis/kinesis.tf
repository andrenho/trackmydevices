resource "aws_kinesis_stream" "stream" {
  name             = "stream"
  shard_count      = 1
}
