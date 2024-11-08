module "gke_auth" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  # version = "24.1.0"
  depends_on   = [module.gke]
  project_id   = var.project_id
  location     = module.gke.location
  cluster_name = module.gke.name
}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-gke"
}

module "gcp-network" {
  source       = "terraform-google-modules/network/google"
  # version      = "6.0.0"
  project_id   = var.project_id
  network_name = var.network_id

  subnets = [
    {
      subnet_name   = var.subnetwork_id
      subnet_ip     = "10.10.0.0/16"
      subnet_region = var.gcp_region
    },
  ]

  secondary_ranges = {
    "${var.subnetwork_id}" = [
      {
        range_name    = var.ip_range_pods_name
        ip_cidr_range = "10.20.0.0/16"
      },
      {
        range_name    = var.ip_range_services_name
        ip_cidr_range = "10.30.0.0/16"
      },
    ]
  }
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                 = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  # version                = "24.1.0"
  project_id             = var.project_id
  name                   = "gke-hello-world-cluster"
  regional               = true
  region                 = var.gcp_region
  network                = module.gcp-network.network_name
  subnetwork             = module.gcp-network.subnets_names[0]
  ip_range_pods          = var.ip_range_pods_name
  ip_range_services      = var.ip_range_services_name
  deletion_protection    = false # ONLY FOR TESTING PURPOSES ! ! !
  
  node_pools = [
    {
      name                      = "node-pool"
      machine_type              = "e2-medium"
      node_locations            = "europe-west3-a,europe-west3-b,europe-west3-c"
      min_count                 = 1
      max_count                 = 2
      disk_size_gb              = 30
    },
  ]
}
