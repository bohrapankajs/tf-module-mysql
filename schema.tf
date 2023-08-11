# Loads the My-SQL schema
resource "null_resource" "mysql-schema" { 

  # This ensures that schema will load only after the creation of MySQL RDS
  depends_on = [aws_db_instance.mysql]

  provisioner "local-exec" {
    command = <<EOF
    cd /tmp 
    curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
    unzip -o mysql.zip 
    cd mysql-main 
    mysql -h ${aws_db_instance.mysql.address} -uadmin1  -pRoboShop1   <shipping.sql
    EOF 
 
  }
}