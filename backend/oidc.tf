# 1. Crear el Proveedor OIDC (Solo se hace una vez por cuenta de AWS)
resource "aws_iam_openid_connect_provider" "github" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # Thumbprint oficial de GitHub
}

# 2. Crear el Rol que asumirá GitHub Actions
resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-terraform-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
          StringLike = {
            # SUSTITUYE: "auribem84/infra-terraform-template:*" por los tuyos
            "token.actions.githubusercontent.com:sub" = "repo:auribem84/infra-terraform-template:*"
          }
        }
      }
    ]
  })
}

# 3. Darle permisos al Rol para gestionar S3 y DynamoDB (y el resto de AWS)
resource "aws_iam_role_policy_attachment" "terraform_permissions" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" # Para pruebas; en prod usa algo más restrictivo
}

output "role_arn" {
  value = aws_iam_role.github_actions_role.arn
}