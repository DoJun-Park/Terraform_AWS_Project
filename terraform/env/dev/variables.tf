### common ###
## eks ##
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


### singapore ###
## vpc ##
variable "aws_region_singapore" {
  description = "Region in which AWS Resources to be created"
  type = string  
}
variable "vpc_availability_zones_singapore" {
  description = "VPC Availability Zones"
  type = list(string)
}

## alb ##
variable "image_repository_singapore" {
  description = "Image of aws-load-balancer-controller"
  type        = string
}
variable "aws_region_name_singapore" {
  description = "Region name to distinguish lb_role"
  type        = string
}





### canada ###
## vpc ##
variable "aws_region_canada" {
  description = "Region in which AWS Resources to be created"
  type = string  
}
variable "vpc_availability_zones_canada" {
  description = "VPC Availability Zones"
  type = list(string)
}

## alb ##
variable "image_repository_canada" {
  description = "Image of aws-load-balancer-controller"
  type        = string
}
variable "aws_region_name_canada" {
  description = "Region name to distinguish lb_role"
  type        = string
}