terraform {
  required_version = "~> 1.3.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  profile = "default"
}



module "ga" {
  source = "../../../modules/globalaccelerator"

  endpoint_id_singapore = var.endpoint_id_singapore
  endpoint_id_canada = var.endpoint_id_canada
  aws_region_singapore = var.aws_region_singapore
  aws_region_canada = var.aws_region_canada
}
