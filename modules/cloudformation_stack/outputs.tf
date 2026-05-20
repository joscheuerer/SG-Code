output "stack_id" {
  description = "The unique identifier of the stack"
  value       = aws_cloudformation_stack.this.id
}

output "stack_outputs" {
  description = "A map of outputs from the stack"
  value       = aws_cloudformation_stack.this.outputs
}