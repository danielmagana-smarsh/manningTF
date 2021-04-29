provider "aws" {
  # version = "2.65.0"
  region  = var.region
  profile = "manning"
}

module "network" {
  source = "./network"
}

module "security" {
  source = "./security"
  vpc_id = module.network.vpc_id
}

module "compute" {
  source        = "./compute"
  PublicSubnetA = module.network.PublicSubnetA
  PublicSubnetB = module.network.PublicSubnetB
  PublicSubnetC = module.network.PublicSubnetC
  AppA          = module.network.AppA
  AppB          = module.network.AppB
  AppC          = module.network.AppC
  sg_bastion    = module.security.sg_bastion
  sg_appServers = module.security.sg_appServers
}