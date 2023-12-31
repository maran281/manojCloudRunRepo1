provider "google" {
  #credentials = file(var.saKeyLoc)
  #as we will be running terraform initialize and apply via cloud build
  #we will the json key file in google cloud secret manager as a secret
  project     = var.project_id
  region      = var.resource_region
}

resource "google_cloud_run_service" "my-first-cloudrun-service" {
  name     = var.service_name
  location = var.service_location

  template {
    spec {
      containers {
        image = "us-east1-docker.pkg.dev/manojproject1-396309/my-docker-images-repo/svchelloworld3"
      }
      service_account_name = "manoj-gcp-poc-sa@manojproject1-396309.iam.gserviceaccount.com"
    }

  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.my-first-cloudrun-service.location
  project     = var.project_id
  service     = google_cloud_run_service.my-first-cloudrun-service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
