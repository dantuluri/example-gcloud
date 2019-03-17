workflow "Build and Deploy" {
  on = "push"
  resolves = [
    "Verify GKE deployment",
  ]
}

# Build

action "Build Docker image" {
  uses = "actions/docker/cli@master"
  args = ["build", "-t", "gcloud-example-app", "."]
  secrets = [
    "GITHUB_TOKEN",
    "GCLOUD_AUTH",
  ]

  # Build
}

# Deploy Filter
action "Deploy branch filter" {
  needs = ["Set Credential Helper for Docker"]
  uses = "actions/bin/filter@master"
  args = "branch master"
  secrets = ["GITHUB_TOKEN", "GCLOUD_AUTH"]

  # Build

  # Build
}

# GKE

action "Setup Google Cloud" {
  uses = "actions/gcloud/auth@master"
  secrets = [
    "GITHUB_TOKEN",
    "GCLOUD_AUTH",
  ]

  # Build

  # GKE
}

action "Tag image for GCR" {
  needs = ["Setup Google Cloud", "Build Docker image"]
  uses = "actions/docker/tag@master"
  env = {
    PROJECT_ID = "suryad"
    APPLICATION_NAME = "gcloud-example2"
  }
  args = ["gcloud-example-app", "gcr.io/$PROJECT_ID/$APPLICATION_NAME"]
  secrets = ["GITHUB_TOKEN", "GCLOUD_AUTH"]

  # Build

  # Build

  # GKE

  # Build

  # GKE
}

action "Set Credential Helper for Docker" {
  needs = ["Setup Google Cloud", "Tag image for GCR"]
  uses = "actions/gcloud/cli@master"
  args = ["auth", "configure-docker", "--quiet"]
  secrets = [
    "GITHUB_TOKEN",
    "GCLOUD_AUTH",
  ]

  # Build

  # GKE

  # Build

  # GKE
}

action "Push image to GCR" {
  needs = ["Setup Google Cloud", "Deploy branch filter"]
  uses = "actions/gcloud/cli@master"
  runs = "sh -c"
  env = {
    PROJECT_ID = "suryad"
    APPLICATION_NAME = "gcloud-example2"
  }
  args = ["docker push gcr.io/$PROJECT_ID/$APPLICATION_NAME"]
  secrets = [
    "GITHUB_TOKEN",
    "GCLOUD_AUTH",
  ]

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE
}

action "Load GKE kube credentials" {
  needs = ["Setup Google Cloud", "Push image to GCR"]
  uses = "actions/gcloud/cli@master"
  env = {
    APPLICATION_NAME = "gcloud-example2"
    PROJECT_ID = "suryad"
    CLUSTER_NAME = "sd1"

    # Build

    # Build

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE
  }
  args = "container clusters get-credentials $CLUSTER_NAME --zone us-west1-a --project $PROJECT_ID"
  secrets = [
    "GITHUB_TOKEN",
    "GCLOUD_AUTH",
  ]

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE
}

# TODO Add Action to start GitHub Deploy
action "Deploy to GKE" {
  needs = ["Push image to GCR", "Load GKE kube credentials"]
  uses = "docker://gcr.io/cloud-builders/kubectl"
  env = {
    PROJECT_ID = "env"
    APPLICATION_NAME = "gcloud-example2"
    DEPLOYMENT_NAME = "deploy-app"

    # Build

    # Build

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE

    # Build

    # GKE
  }
  runs = "sh -l -c"
  args = ["SHORT_REF=$(echo ${GITHUB_SHA} | head -c7) && cat $GITHUB_WORKSPACE/config.yml | sed 's/PROJECT_ID/'\"$PROJECT_ID\"'/' | sed 's/APPLICATION_NAME/'\"$APPLICATION_NAME\"'/' | sed 's/TAG/'\"$SHORT_REF\"'/' | kubectl apply -f - "]
  secrets = ["GITHUB_TOKEN", "GCLOUD_AUTH"]

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE
}

action "Verify GKE deployment" {
  needs = ["Deploy to GKE"]
  uses = "docker://gcr.io/cloud-builders/kubectl"
  args = "rollout status deployment/$DEPLOYMENT_NAME"
  secrets = ["GITHUB_TOKEN", "GCLOUD_AUTH"]
  env = {
    DEPLOYMENT_NAME = "deploy-app"
  }

  # Build

  # Build

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE

  # Build

  # GKE
}
