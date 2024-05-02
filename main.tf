module "tls_private_key" {
  source = "github.com/serhii-cherkez/tf-hashicorp-tls-keys"
  algorithm        = "RSA"
  ecdsa_curve      = "P521"
}

module "github_repository" {
  source = "github.com/serhii-cherkez/tf-github-repository"
  github_owner = var.GITHUB_OWNER
  github_token = var.GITHUB_TOKEN
  repository_name = var.FLUX_GITHUB_REPO
  repository_visibility = "public"
  public_key_openssh = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "flux_bootstrup" {
  source = "github.com/serhii-cherkez/tf-fluxcd-flux-bootstrap"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key = module.tls_private_key.private_key_pem
  config_path = module.gke_cluster.kubeconfig
}

module "gke_cluster" {
  source           = "github.com/serhii-cherkez/tf-google-gke-cluster"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_NUM_NODES    = var.GKE_NUM_NODES
  GKE_CLUSTER_NAME = var.GKE_CLUSTER_NAME
  GKE_POOL_NAME    = var.GKE_POOL_NAME
}