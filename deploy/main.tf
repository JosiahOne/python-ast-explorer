terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "python-ast-explorer" {
  name                 = "python-ast-explorer"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecs_task_definition" "python-ast-explorer-service" {
  family = "python-ast-explorer"
  container_definitions = jsonencode([
    {
      name      = "python-ast-explorer"
      image     = "${data.aws_caller_identity.current.account_id}.dkr.ecr.us-west-2.amazonaws.com/python-ast-explorer:latest"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-east-2a]"
  }
}
