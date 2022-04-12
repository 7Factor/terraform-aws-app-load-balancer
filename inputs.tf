variable "cluster_name" {
  description = "The name of the cluster containing the app using the LB."
  type        = string
}

variable "app_name" {
  description = "The name of the app using the LB."
  type        = string
}

variable "security_groups" {
  description = "A list of security group IDs to assigned to the LB."
  type        = list(any)
}

variable "subnets" {
  description = "A list of subnet IDs to attach to the LB."
  type        = list(any)
}

variable "internal" {
  description = "If true, the LB will be internal."
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The time in seconds that a connection to the LB is allowed to be idle."
  type        = number
  default     = 60
}

variable "access_logs_enabled" {
  description = "If true, LB access logs will be stored in the S3 bucket defined in access_logs_bucket."
  type        = bool
  default     = false
}

variable "access_logs_bucket" {
  description = "The S3 bucket to store LB access logs in."
  type        = string
  default     = ""
}

variable "ssl_policy" {
  description = "Name of the SSL Policy for the LB's HTTPS listener."
  type        = string
  default     = "ELBSecurityPolicy-FS-2018-06"
}

variable "certificate_arn" {
  description = "ARN of the default SSL server certificate for the LB's HTTPS listener."
  type        = string
}

variable "secure_listener_redirect" {
  description = "Switch the secure redirect from 80 to 443 on or off. On by default because this is a good idea, but you can turn it off if you have a weird edge case."
  type        = bool
  default     = true
}

variable "target_group_arn" {
  description = "ARN of the target group that the LB will forward traffic to."
  type        = string
}
