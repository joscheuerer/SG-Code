# Manages a single EC2 key pair. public_key is write-only; ignored after import.
resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = var.public_key
  tags       = var.tags

  # public_key is write-only: not returned by the API after creation.
  lifecycle {
    ignore_changes = [public_key]
  }
}
