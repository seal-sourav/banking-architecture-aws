resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier              = "${var.project_name}-db"
  engine                  = "postgres"
  instance_class          = var.instance_class
  allocated_storage       = 100

  db_name                 = "banking"
  username                = var.db_username
  password                = var.db_password

  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [var.db_security_group_id]

  multi_az                = true
  storage_encrypted       = true
  backup_retention_period = 7

  skip_final_snapshot     = true

  tags = {
    Name = "${var.project_name}-rds"
  }
}