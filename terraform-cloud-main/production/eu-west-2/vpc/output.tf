output "private_subnets" {
  description = "private subnet"
  value       = module.vpc.private_subnets
}

output "vpc_id" {
  description = "vpc id."
  value       = module.vpc.vpc_id
}
