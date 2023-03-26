# EKS Cluster 
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "18.31.2"

  cluster_name = var.cluster_name
  cluster_version = var.cluster_version
  
  vpc_id = var.vpc_id
  subnet_ids = var.subnet_ids
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access = var.cluster_endpoint_public_access
  

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    capacity_type = "ON_DEMAND"
    disk_size = 10
    instance_types = ["t3.small"]
  }
  
  eks_managed_node_groups = {
    ("${var.cluster_name}_node_group") = {
      min_size     = var.scaling_min_size
      max_size     = var.scaling_max_size
      desired_size = var.scaling_desired_size

      tags = {
        "k8s.io/cluster-autoscaler/enabled" : "true"
        "k8s.io/cluster-autoscaler/${var.cluster_name}" : "true"
      }
    }
  }

  node_security_group_additional_rules = {
    ingress_allow_access_from_control_plane = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 9443
      to_port                       = 9443
      source_cluster_security_group = true
      description                   = "Allow access from control plane to webhook port of AWS load balancer controller"
    }
    ingress_cluster_metricserver = {
      type                          = "ingress"
      protocol                      = "tcp"
      from_port                     = 4443
      to_port                       = 4443
      source_cluster_security_group = true
      description                   = "Cluster to node 4443 (Metrics Server)"
    }
    egress_all = {
      type                          = "egress"
      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      source_cluster_security_group = true
      description                   = "Node all egress"
    }
  }
}


# Auto Scaling group policy
resource "aws_autoscaling_policy" "this" {
  count = length(module.eks.eks_managed_node_groups)

  name                   = "${module.eks.eks_managed_node_groups_autoscaling_group_names[count.index]}-autoscaling-policy"
  autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[count.index]
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.autoscaling_average_cpu
  }
}

