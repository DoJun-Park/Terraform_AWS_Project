resource "aws_globalaccelerator_accelerator" "this" {
  name            = "ga"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "this" {
  accelerator_arn = aws_globalaccelerator_accelerator.this.id
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}


# Active-Active
resource "aws_globalaccelerator_endpoint_group" "singapore" {
  listener_arn                  = aws_globalaccelerator_listener.this.id
  endpoint_group_region         = var.aws_region_singapore
  health_check_interval_seconds = 10
  health_check_path             = "/"
  health_check_port             = 80
  health_check_protocol         = "TCP"
  threshold_count               = 3
  traffic_dial_percentage       = 50    # weight

  endpoint_configuration {
    endpoint_id                    = var.endpoint_id_singapore
    weight                         = 128
    client_ip_preservation_enabled = false
  }

  lifecycle {
    ignore_changes = [
      health_check_path
    ]
  }
}

resource "aws_globalaccelerator_endpoint_group" "canada" {
  listener_arn                  = aws_globalaccelerator_listener.this.id
  endpoint_group_region         = var.aws_region_canada
  health_check_interval_seconds = 10
  health_check_path             = "/"
  health_check_port             = 80
  health_check_protocol         = "TCP"
  threshold_count               = 3
  traffic_dial_percentage       = 50     # weight

  endpoint_configuration {
    endpoint_id                    = var.endpoint_id_canada
    weight                         = 128
    client_ip_preservation_enabled = false
  }

  lifecycle {
    ignore_changes = [
      health_check_path
    ]
  }
}
