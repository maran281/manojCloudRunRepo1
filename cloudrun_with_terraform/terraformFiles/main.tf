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
        image = "us-east1-docker.pkg.dev/manojproject1-396309/my-docker-images-repo/svchelloworld2"
      }
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
