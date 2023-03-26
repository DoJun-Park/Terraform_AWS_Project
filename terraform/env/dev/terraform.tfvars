### common ###
## eks ##
scaling_min_size = 2
scaling_max_size = 3
scaling_desired_size = 2
autoscaling_average_cpu = 3

### singapore ###
## provider ## 
aws_region_singapore = "ap-southeast-1"

## vpc ##
vpc_availability_zones_singapore = ["ap-southeast-1a", "ap-southeast-1b"]

## alb ##
image_repository_singapore = "602401143452.dkr.ecr.ap-southeast-1.amazonaws.com/amazon/aws-load-balancer-controller"
aws_region_name_singapore = "singapore"




### canada ###
## provider ## 
aws_region_canada = "ca-central-1"

## vpc ##
vpc_availability_zones_canada = ["ca-central-1a", "ca-central-1b"]

## alb ##
image_repository_canada = "602401143452.dkr.ecr.ca-central-1.amazonaws.com/amazon/aws-load-balancer-controller"
aws_region_name_canada = "canada"
