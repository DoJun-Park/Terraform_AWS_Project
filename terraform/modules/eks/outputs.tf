# alb에서 사용
output "oidc_provider_arn" {
  value       = module.eks.oidc_provider_arn
}

output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}