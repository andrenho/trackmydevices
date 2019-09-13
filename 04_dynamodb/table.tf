resource "aws_dynamodb_table" "track" {
  name           = "track"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "device_id"
  range_key      = "event_datetime"

  attribute {
    name = "device_id"
    type = "S"
  }

  attribute {
    name = "event_datetime"
    type = "N"
  }
}
