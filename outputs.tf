output "vpc_id" {
  value = module.vpc.vpc_id
}
output "ec2_instance_id" {
  value = module.ec2.instance_id
}
output "rds_endpoint" {
  value = module.rds.db_endpoint
}
output "ecs_cluster_id" {
  value = module.ecs.ecs_cluster_id
}
output "alb_dns" {
  value = module.alb.alb_dns
}
output "s3_bucket_name" {
  value = module.s3.bucket_name
}