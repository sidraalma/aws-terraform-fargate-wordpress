resource "aws_db_subnet_group" "subnetgp" {
  //   count      = var.private_subnet_count
  name       = "subnetgp"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = var.default_tags.project
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage = 10
  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  name              = "wordpress"
  username          = "admin"
  password          = "wordpress"
  // parameter_group_name   = "default.mysql5.7"
  port                   = 3306
  db_subnet_group_name   = aws_db_subnet_group.subnetgp.name
  vpc_security_group_ids = [aws_security_group.sg.id]
  //   parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible = true
  skip_final_snapshot = true
}