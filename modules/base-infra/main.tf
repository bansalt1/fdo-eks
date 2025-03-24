########
# Tags # 
########

variable "tags" {
  description = "(Optional) Any custom tags that should be added to all of the resources."
  type        = map(string)
  default     = {}
}

// get the current user information so that we may tag the resources with the user's email, and utilize the value to the left of @ for using the default dns zone that 
//exists within our sandbox accounts
data "aws_caller_identity" "user" {}

locals {

  // user_email is the users email address as gathered from the aws_caller_identity data source
  // the email is prefixed with a string of text followed by a semicolon, so we want to strip that away
  // we also want to convert an dots found within a user's username to dashes so that it can be used as a name for other resources
  user_name_raw = regex(":(.*?)@", data.aws_caller_identity.user.user_id)
  user_name     = replace(local.user_name_raw[0], ".", "-")
  user_email    = replace(data.aws_caller_identity.user.user_id, "/^.*:/", "")

  tags = merge({
    Name    = local.user_name
    OwnedBy = local.user_email
  }, var.tags)
}

#######
# DNS #
#######

data "aws_route53_zone" "dns_zone" {
  name = var.dns_zone
}

module "acm_wildcard" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"

  domain_name         = var.dns_zone
  zone_id             = data.aws_route53_zone.dns_zone.zone_id
  wait_for_validation = false # until we swing over the main registrar for this zone, this will not pass
  tags                = var.common_tags

  subject_alternative_names = [
    "*.${var.dns_zone}"
  ]

  create_route53_records  = false
  validation_method       = "DNS"
  validation_record_fqdns = module.route53_records_only.validation_route53_record_fqdns
}

module "route53_records_only" {
  source  = "terraform-aws-modules/acm/aws"
  version = "5.1.1"

  create_certificate                        = false
  create_route53_records_only               = true
  validation_method                         = "DNS"
  zone_id                                   = data.aws_route53_zone.dns_zone.zone_id
  distinct_domain_names                     = module.acm_wildcard.distinct_domain_names
  acm_certificate_domain_validation_options = module.acm_wildcard.acm_certificate_domain_validation_options
  tags                                      = var.common_tags
}

#######
# IAM #
#######

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "ssm" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "${var.resource_name}-ssm${var.ssm-role-suffix}"
  tags               = var.common_tags
}

resource "aws_iam_role_policy_attachment" "ssm" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.ssm.name
}

resource "aws_iam_role_policy_attachment" "cloud_watch" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role       = aws_iam_role.ssm.name
}

resource "aws_iam_instance_profile" "ssm" {
  name = "${var.resource_name}-ssm${var.ssm-role-suffix}"
  role = aws_iam_role.ssm.name
}

#######
# RDS #
#######

module "rds" {
  source      = "terraform-aws-modules/rds/aws//modules/db_subnet_group"
  version     = "6.11.0"
  description = "Database subnet group for ${local.user_name}"
  name        = local.user_name
  subnet_ids  = var.existing_database_subnets
  tags        = merge(var.common_tags, tomap({ "Usage" = "rds" }))
}

######
# S3 #
######

# We'll need the curren accound ID to make sure the root user can do things
# to the KMS key
data "aws_caller_identity" "current" {}

resource "aws_kms_key" "main" {
  description = "This key is used to encrypt bucket objects"
  policy      = data.aws_iam_policy_document.kms.json
  tags        = var.common_tags
}

data "aws_iam_policy_document" "kms" {
  policy_id = "AllowDecryptionFromSSMRole"

  statement {
    sid = "EnableIAMUserPermissions"
    actions = [
      "kms:*"
    ]
    resources = [
      "*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.id}:root"]
    }
  }

  statement {
    sid = "AllowDecryptionFromSSMRole"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = [
      "*"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.ssm.arn]
    }
  }
}

#######
# VPC #
#######

# Get existing VPC details
data "aws_vpc" "existing" {
  id = var.existing_vpc_id
}

data "aws_subnet" "private" {
  count = length(var.existing_private_subnets)
  id    = var.existing_private_subnets[count.index]
}

data "aws_subnet" "public" {
  count = length(var.existing_public_subnets)
  id    = var.existing_public_subnets[count.index]
}

data "aws_subnet" "database" {
  count = length(var.existing_database_subnets)
  id    = var.existing_database_subnets[count.index]
}

# Create locals to maintain the same output structure as the VPC module
locals {
  vpc = {
    vpc_id           = data.aws_vpc.existing.id
    private_subnets  = var.existing_private_subnets
    public_subnets   = var.existing_public_subnets
    database_subnets = var.existing_database_subnets
  }
}

data "aws_security_group" "ssm" {
  name   = "${local.user_name}-ssm"
  vpc_id = var.existing_vpc_id
}

# Get remote state data
data "terraform_remote_state" "base-infra" {
  backend = "remote"

  config = {
    organization = "hashicorp-support-eng"
    workspaces = {
      name = var.base_infra_workspace_name
    }
  }
}

locals {
  infra_outputs = data.terraform_remote_state.base-infra.outputs
}
