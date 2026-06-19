resource "aws_instance" "ec2-instance" {
  ami                         = var.ec2_instance_image
  instance_type               = var.ec2_instance_type
  associate_public_ip_address = true

  key_name               = aws_key_pair.ec2-instance.key_name
  subnet_id              = var.subnet_b
  vpc_security_group_ids = [aws_security_group.ec2_web_sg.id, aws_security_group.ec2_linux_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_app_profile.name   # <-- เพิ่มบรรทัดนี้
  user_data               = file("user-data.sh")

  root_block_device {
    volume_size = "50"
    volume_type = "gp3"
  }

  tags = {
    Name                             = "ec2-tutorial"
    "Automatic stop/start schedule"  = "Enabled"
  }

  volume_tags = {
    Name     = "ec2-tutorial-volume"
    Createby = var.create_by_name
  }

  lifecycle {
    ignore_changes = [ami, volume_tags, user_data]
  }
}