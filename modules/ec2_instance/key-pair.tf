
// creating key-pair for ssh
resource "aws_key_pair" "test-key" {
  key_name   = var.key_name
  public_key = var.key

}
