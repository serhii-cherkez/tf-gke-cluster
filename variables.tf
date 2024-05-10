variable "GOOGLE_PROJECT" {
  type    = string
  default = "prometheus-devops-course"
}

variable "GOOGLE_REGION" {
  type    = string
  default = "us-central1-c"
}

variable "GKE_NUM_NODES" {
  type    = number
  default = 3
}

variable "GKE_CLUSTER_NAME" {
  type    = string
  default = "kbot-gke-cluster"
}

variable "GKE_POOL_NAME" {
  type    = string
  default = "kbot-gke-pool"
}

variable "GITHUB_OWNER" {
  type = string
}

variable "GITHUB_TOKEN" {
  type = string
}

variable "FLUX_GITHUB_REPO" {
  type    = string
  default = "flux-system"
}

variable "FLUX_GITHUB_TARGET_PATCH" {
  type    = string
  default = "clusters"
}