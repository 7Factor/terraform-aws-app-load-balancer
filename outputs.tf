output "hostname" {
  description = "The DNS name of the LB."
  value       = aws_lb.app_lb.dns_name
}

output "name" {
  description = "The name of the LB."
  value       = aws_lb.app_lb.name
}

output "arn" {
  description = "The ARN of the LB."
  value       = aws_lb.app_lb.arn
}

output "arn_suffix" {
  description = "The ARN suffix of the LB."
  value       = aws_lb.app_lb.arn_suffix
}

output "zone_id" {
  description = "The zone ID of the LB."
  value       = aws_lb.app_lb.zone_id
}

output "secure_listener_arn" {
  description = "The ARN of the LB's secure listener."
  value       = aws_lb_listener.secure_listener.arn
}
