locals {
  tags = {
    "cdo-gov:CiscoMailAlias"                  = var.cisco_mail_alias
    "cdo-gov:opstack:ApplicationName"         = var.application_name
    "cdo-gov:opstack:DataClassificationCisco" = var.data_classification_cisco
    "cdo-gov:opstack:DataClassificationFed"   = var.data_classification_fed
    "cdo-gov:opstack:Environment"             = var.environment
    "cdo-gov:opstack:ResourceOwner"           = var.resource_owner
    "deployed_fromdir"                        = var.deployed_fromdir
  }

  tags_all = {
    "cdo-gov:CiscoMailAlias"                  = var.cisco_mail_alias
    "cdo-gov:opstack:ApplicationName"         = var.application_name
    "cdo-gov:opstack:DataClassificationCisco" = var.data_classification_cisco
    "cdo-gov:opstack:DataClassificationFed"   = var.data_classification_fed
    "cdo-gov:opstack:Environment"             = var.environment
    "cdo-gov:opstack:ResourceOwner"           = var.resource_owner
    "deployed_fromdir"                        = var.deployed_fromdir
  }
}
