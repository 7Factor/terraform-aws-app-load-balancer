# AWS Application Load Balancer

This module will allow you to deploy an application load balancer intended for use with an ECS Service. This is intended
to be run as part of your app deployment pipeline. It works well with [Concourse.](https://concourse-ci.org) It is
assumed you already have a solution for deploying the ECS Service. If not, check out
[ours.](https://github.com/7Factor/terraform-aws-ecs-http-task) This particular iteration assumes that you are deploying
applications behind a load balancer with SSL termination and redirection from port 80.

## Prerequisites

First, you need a decent understanding of how to use Terraform.
[Hit the docs](https://www.terraform.io/intro/index.html) for that. Then, you should familiarize yourself with ECS
[concepts](https://aws.amazon.com/ecs/getting-started/), especially if you've never worked with a clustering solution 
before. Once you're good, import this module and pass the appropriate variables. Then, plan your run and deploy.

We also assume that you're deploying an application behind an ALB to port 443 (a really good idea). We will ask for your
certificate ARN and automagically configure an HTTP to HTTPS redirect on the ALB. If you need more interesting features
like opening ports other than 80 and 443 then feel free to use this as a template.

## Example Usage

```hcl-terraform
module "external_alb" {
  source  = "7Factor/app-load-balancer/aws"
  version = "1.0.0"

  cluster_name     = var.cluster_name
  app_name         = var.app_name
  security_groups  = [data.aws_security_group.primary_sg.id]
  subnets          = data.aws_subnet_ids.subnet_ids.ids
  certificate_arn  = data.aws_acm_certificate.lb_cert.arn
  target_group_arn = module.http_task.lb_target_group_arn # From the 7Factor/http-ecs-task/aws module
}
```
