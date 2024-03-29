resource "aws_db_instance" "mysql" {
  identifier            = "roboshop-mysql-${var.ENV}" 
  allocated_storage       = var.RDS_MYSQL_STORAGE
  engine                  = "mysql"
  engine_version          = var.RDS_MYSQL_ENGINE_VERSION
  instance_class          = var.RDS_MYSQL_INSTANCE_CLASS
  username                = "admin1"
  password                = "RoboShop1"
  parameter_group_name    = aws_db_parameter_group.mysql-pg.name
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.mysql-subnet-grp.name
  vpc_security_group_ids  = [aws_security_group.allows_mysql.id] 
}


resource "aws_db_parameter_group" "mysql-pg" {
  name   = "roboshop-mysql-pg-${var.ENV}"
  family = "mysql5.7"
}

# Creates Subnet Group
resource "aws_db_subnet_group" "mysql-subnet-grp" {
  name       =  "mysql-subnet-grp-${var.ENV}"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_ID

  tags = {
    Name = "mysql-subnet-grp-${var.ENV}"
  }
} 