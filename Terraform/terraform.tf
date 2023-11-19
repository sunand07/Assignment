resource "google_cloud_run_v2_service" "default" {
  name = "my-service"
  location = "us-central1"

  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-docker.pkg.dev/my-project/my-image"
    }
  }

  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  depends_on = [
    google_cloud_run_v2_service_iam_policy.default,
  ]
}

resource "google_cloud_run_v2_service" "us-east1" {
  name = "my-service-us-east1"
  location = "us-east1"

  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-docker.pkg.dev/my-project/my-image"
    }
  }

  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  depends_on = [
    google_cloud_run_v2_service_iam_policy.us-east1,
  ]
}

resource "google_cloud_run_v2_service" "europe-west1" {
  name = "my-service-europe-west1"
  location = "europe-west1"

  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-docker.pkg.dev/my-project/my-image"
    }
  }

  traffic {
    type = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  depends_on = [
    google_cloud_run_v2_service_iam_policy.europe-west1,
  ]
}

resource "google_cloud_run_v2_service_iam_policy" "default" {
  location = google_cloud_run_v2_service.default.location
  project = google_cloud_run_v2_service.default.project
  service = google_cloud_run_v2_service.default.name

  policy_data = {
    bindings = [
      {
        role = "roles/run.invoker"
        members = [
          "allUsers",
        ]
      },
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "us-east1" {
  location = google_cloud_run_v2_service.us-east1.location
  project = google_cloud_run_v2_service.us-east1.project
  service = google_cloud_run_v2_service.us-east1.name

  policy_data = {
    bindings = [
      {
        role = "roles/run.invoker"
        members = [
          "allUsers",
        ]
      },
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "europe-west1" {
  location = google_cloud_run_v2_service.europe-west1.location
  project = google_cloud_run_v2_service.europe-west1.project
  service = google_cloud_run_v2_service.europe-west1.name

  policy_data = {
    bindings = [
      {
        role = "roles/run.invoker"
        members = [
          "allUsers",
        ]
      },
    ]
  }
}