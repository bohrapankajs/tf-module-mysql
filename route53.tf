resource "aws_route53_record" "mysql-r53" {
  zone_id = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONEID
  name    = "mysql-${var.ENV}.${data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONENAME}"
  type    = "CNAME"
  ttl     = 10
  records = [aws_db_instance.mysql.address]
}