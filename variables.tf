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
  default = "gke-cluster-demo"
}

variable "GKE_POOL_NAME" {
  type    = string
  default = "gke-pool-demo"
}