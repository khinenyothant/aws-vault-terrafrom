output "master-vault-admin-accesskey" {
  value       = aws_iam_access_key.master_admin_access_key.secret
  sensitive   = true
  description = "The secret access key for master-vault-admin. Store it securely."
}