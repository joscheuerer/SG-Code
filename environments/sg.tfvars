region               = "eu-central-1"
name                 = "sage-agent"
image_tag_mutability = "MUTABLE"
encryption_type      = "AES256"
scan_on_push         = true
tags = {
  Warning       = "Do-Not-Modify-Or-Delete"
  Resource-Type = "non-prod"
  ManagedBy     = "StackGuardian-Infra-Team"
}