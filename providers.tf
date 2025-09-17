terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.13"
      configuration_aliases = [aws.primary, aws.secondary]
    }
}
}