# variables

variable "project_id" {
  type        = string
  description = "Project ID of the GCP project"
}

variable "gcp_region" {
  type        = string
  description = "Specific region where sselected resources should be deployed"
}

variable "network_id" {
  type        = string
  description = "GKE network name"
}

variable "subnetwork_id" {
  type        = string
  description = "GKE subnetwork name"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-services"
}
