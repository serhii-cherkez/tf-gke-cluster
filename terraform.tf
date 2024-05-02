terraform {
  backend "gcs" {
    bucket = "tf_gke_cluster_backend"
    prefix = "terraform/state"
  }
}