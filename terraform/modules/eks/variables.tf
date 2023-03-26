variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  type        = string
  default     = "eks"
}

variable "cluster_version" {
  description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
  type = string
  default = "1.23"
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnet"
  type        = list(string)
}


variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}


variable "scaling_min_size" {
  description = "Auto Scaling min size"
  type        = number
}

variable "scaling_max_size" {
  description = "Auto Scaling max size"
  type        = number
}

variable "scaling_desired_size" {
  description = "Auto Scaling desired size"
  type        = number
}

variable "autoscaling_average_cpu" {
  description = "Average CPU threshold to autoscale EKS EC2 instances."
  type        = number
}

