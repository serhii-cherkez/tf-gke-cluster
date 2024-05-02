terraform {
  backend "gcs" {
    bucket = "tf_gke_cluster_backend"
    prefix = "terraform/state"
  }
}

module "tls" {
  source = "github.com/serhii-cherkez/tf-hashicorp-tls-keys"
  algorithm        = "RSA"
  ecdsa_curve      = "P521"
}

module "github" {
  source = "https://github.com/serhii-cherkez/tf-github-repository"
}

module "flux" {
  source = "https://github.com/serhii-cherkez/tf-fluxcd-flux-bootstrap"
}

module "gke_cluster" {
  source           = "github.com/serhii-cherkez/tf-google-gke-cluster"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_NUM_NODES    = var.GKE_NUM_NODES
  GKE_CLUSTER_NAME = var.GKE_CLUSTER_NAME
  GKE_POOL_NAME    = var.GKE_POOL_NAME
}