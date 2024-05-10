module "tls_private_key" {
  source      = "github.com/serhii-cherkez/tf-hashicorp-tls-keys"
  algorithm   = "RSA"
  ecdsa_curve = "P521"
}

module "github_repository" {
  source                   = "github.com/serhii-cherkez/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  repository_visibility    = "public"
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux0"
}

module "flux_bootstrup" {
  source            = "github.com/serhii-cherkez/tf-fluxcd-flux-bootstrap?ref=gke_auth"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_host       = module.gke_cluster.config_host
  config_token      = module.gke_cluster.config_token
  config_ca         = module.gke_cluster.config_ca
  github_token      = var.GITHUB_TOKEN
}

module "gke_cluster" {
  source           = "github.com/serhii-cherkez/tf-google-gke-cluster?ref=gke_auth"
  GOOGLE_REGION    = var.GOOGLE_REGION
  GOOGLE_PROJECT   = var.GOOGLE_PROJECT
  GKE_NUM_NODES    = var.GKE_NUM_NODES
  GKE_CLUSTER_NAME = var.GKE_CLUSTER_NAME
  GKE_POOL_NAME    = var.GKE_POOL_NAME
}

module "gke_workload_identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  use_existing_k8s_sa = true
  name                = "kustomize-controller"
  namespace           = "flux-system"
  project_id          = var.GOOGLE_PROJECT
  cluster_name        = "main"
  location            = var.GOOGLE_REGION
  annotate_k8s_sa     = true
  roles               = ["roles/secretmanager.secretVersionAdder", "roles/cloudkms.cryptoKeyEncrypterDecrypter"]
}

 module "kms" {
   source = "github.com/serhii-cherkez/terraform-google-kms"
   project_id = var.GOOGLE_PROJECT
   keyring = "sops-flux"
   location = "global"
   keys = ["sops-key-flux"]
   prevent_destroy = false
 }