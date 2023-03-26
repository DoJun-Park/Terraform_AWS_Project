terraform {
  required_version = "~> 1.3.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


# aws provider의 profile은 AWS Configure를 통해 생성한 profile 사용
provider "aws" {
  profile = "default"
  alias   = "singapore"
  region  = var.aws_region_singapore
}

provider "aws" {
  profile = "default"
  alias   = "canada"
  region  = var.aws_region_canada 
}




### singapore ###
module "vpc_singaore" {
  source = "../../modules/vpc"

  providers = {
    aws = aws.singapore
  }

  vpc_availability_zones = var.vpc_availability_zones_singapore
}

module "eks_singaore" {
  source = "../../modules/eks"
  
  providers = {
    aws = aws.singapore
  }

  vpc_id = module.vpc_singaore.vpc_id
  subnet_ids = module.vpc_singaore.private_subnets
  scaling_min_size = var.scaling_min_size
  scaling_max_size = var.scaling_max_size
  scaling_desired_size = var.scaling_desired_size
  autoscaling_average_cpu = var.autoscaling_average_cpu
}

module "alb_singaore" {
  source = "../../modules/alb"
  
  providers = {
    aws = aws.singapore
  }
  
  provider_arn = module.eks_singaore.oidc_provider_arn
  cluster_id = module.eks_singaore.cluster_id
  image_repository = var.image_repository_singapore
  aws_region = var.aws_region_singapore
  aws_region_name = var.aws_region_name_singapore
}



### canada ###
module "vpc_canada" {
  source = "../../modules/vpc"

  providers = {
    aws = aws.canada
  }

  vpc_availability_zones = var.vpc_availability_zones_canada
}

module "eks_canada" {
  source = "../../modules/eks"
  
  providers = {
    aws = aws.canada
  }

  vpc_id = module.vpc_canada.vpc_id
  subnet_ids = module.vpc_canada.private_subnets
  scaling_min_size = var.scaling_min_size
  scaling_max_size = var.scaling_max_size
  scaling_desired_size = var.scaling_desired_size
  autoscaling_average_cpu = var.autoscaling_average_cpu
  
}

module "alb_canada" {
  source = "../../modules/alb"
  
  providers = {
    aws = aws.canada
  }

  provider_arn = module.eks_canada.oidc_provider_arn
  cluster_id = module.eks_canada.cluster_id
  image_repository = var.image_repository_canada
  aws_region = var.aws_region_canada
  aws_region_name = var.aws_region_name_canada
  
}
