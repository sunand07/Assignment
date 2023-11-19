provider "google" {
  credentials = file("<path-to-service-account-key-json>")
  project     = "<your-gcp-project>"
  region      = var.region
}

variable "region" {
  description = "The GCP region to deploy the Cloud Run service."
  type        = string
}

variable "project" {
  description = "The GCP project ID."
  type        = string
}

variable "service_name" {
  description = "The name of the Cloud Run service."
  type        = string
}

variable "image" {
  description = "The container image to deploy to Cloud Run."
  type        = string
}

variable "environment" {
  description = "The environment for the Cloud Run service (e.g., dev, prod)."
  type        = string
}

resource "google_cloud_run_service" "cloud_run_service" {
  name     = var.service_name
  location = var.region

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  metadata {
    namespace = var.environment
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Define additional regions as needed
variable "additional_regions" {
  description = "Additional regions to deploy the Cloud Run service."
  type        = list(string)
  default     = []
}

locals {
  all_regions = concat([var.region], var.additional_regions)
}

# Deploy the Cloud Run service in additional regions
resource "google_cloud_run_service" "additional_cloud_run_services" {
  count = length(local.all_regions) > 1 ? length(local.all_regions) - 1 : 0

  name     = "${var.service_name}-${local.all_regions[count.index + 1]}"
  location = local.all_regions[count.index + 1]

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  metadata {
    namespace = var.environment
  }

  traffic {
    percent         = 0
    latest_revision = true
  }
}
