# /**
#  * Purpose : IAM Role สำหรับ EC2 - ใช้ pull image จาก ECR และดึง deployment artifact จาก S3
#  */
resource "aws_iam_role" "ec2_app_role" {
  name = "ec2-app-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Createby = var.create_by_name
  }
}

# /**
#  * Purpose : Policy ให้ EC2 ดึง deployment artifact จาก S3 bucket
#  */
resource "aws_iam_role_policy" "ec2_s3_artifact_access" {
  name = "ec2-s3-artifact-access"
  role = aws_iam_role.ec2_app_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "arn:aws:s3:::YOUR-ARTIFACT-BUCKET/*"
      }
    ]
  })
}

# /**
#  * Purpose : Policy ให้ EC2 pull image จาก ECR
#  */
resource "aws_iam_role_policy" "ec2_ecr_pull_access" {
  name = "ec2-ecr-pull-access"
  role = aws_iam_role.ec2_app_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ]
        Resource = "*"
      }
    ]
  })
}

# /**
#  * Purpose : Instance Profile - ตัวกลางที่ EC2 ใช้ "สวม" IAM Role
#  */
resource "aws_iam_instance_profile" "ec2_app_profile" {
  name = "ec2-app-instance-profile"
  role = aws_iam_role.ec2_app_role.name
}