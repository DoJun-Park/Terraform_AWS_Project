# role
variable "provider_arn" {
  description = "Eks arn"
  type        = string
}

variable "aws_region_name" {
  description = "Region in which AWS Resources to be created"
  type = string  
}


variable "cluster_id" {
  description = "To get datasource(aws_eks_cluster, aws_eks_cluster_auth)"
  type        = string
}


# alb controller install
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string  
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = "eks"
}

variable "image_repository" {
  description = "Image of aws-load-balancer-controller"
  type = string  
}


