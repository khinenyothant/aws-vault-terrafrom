#create IAM user
resource "aws_iam_user" "master-user" {
  provider = aws.master-admin
  name     = "master-vault-admin"
}

data "aws_iam_policy_document" "master-policy" {
  provider = aws.master-admin
  statement {
    effect = "Allow"
    actions = [
      "iam:AttachUserPolicy",
      "iam:CreateAccessKey",
      "iam:CreateUser",
      "iam:DeleteAccessKey",
      "iam:DeleteUser",
      "iam:DeleteUserPolicy",
      "iam:DetachUserPolicy",
      "iam:GetUser",
      "iam:ListAccessKeys",
      "iam:ListAttachedUserPolicies",
      "iam:ListGroupsForUser",
      "iam:ListUserPolicies",
      "iam:PutUserPolicy",
      "iam:AddUserToGroup",
      "iam:RemoveUserFromGroup"
    ]
    resources = ["arn:aws:iam::851725459960:user/*"]
  }
}

#create IAM Policy
resource "aws_iam_policy" "master_user_policy" {
  provider    = aws.master-admin
  name        = "vault-user-policy"
  description = "A policy for vault-user"
  policy      = data.aws_iam_policy_document.master-policy.json
}

# Attach Policy
resource "aws_iam_policy_attachment" "master-attach" {
  provider   = aws.master-admin
  name       = "inline-attachment"
  users      = [aws_iam_user.master-user.name]
  policy_arn = aws_iam_policy.master_user_policy.arn
}

# Create Access key
resource "aws_iam_access_key" "master_admin_access_key" {
  provider = aws.master-admin
  user     = aws_iam_user.master-user.name
}

resource "vault_aws_secret_backend" "master-admin" {
  provider   = vault.master-vault
  access_key = aws_iam_access_key.master_admin_access_key.id
  secret_key = aws_iam_access_key.master_admin_access_key.secret
  path       = "knt-aws-master-admin"
}