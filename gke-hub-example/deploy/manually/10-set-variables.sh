#!/bin/bash
# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# This files is generally sources from other files.
# Usage: source 10-set-variables.sh

alias k=kubectl

WORKING_DIR=$(pwd)

export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
echo "--------------------------------"
echo "Using project ${PROJECT_ID}"
echo "--------------------------------"

export CLUSTER_NAME="kupyterhub"
export ZONE="us-west1-b"

export FOLDER_MANIFESTS="../manifests/overlays"
export FOLDER_MANIFESTS_GKE="${FOLDER_MANIFESTS}/gke"
export FOLDER_MANIFESTS_LOCAL="${FOLDER_MANIFESTS}/local"

export DOCKER_FOLDER="../../docker"
export DOCKER_FOLDER_HUB="${DOCKER_FOLDER}/hub"
export DOCKER_FOLDER_AGENT="${DOCKER_FOLDER}/agent"

# Docker images for local deployment.
export IMAGE_HUB_NAME="gkehub-hub"
export IMAGE_HUB_TAG="latest"
export IMAGE_AGENT_NAME="gkehub-agent"
export IMAGE_AGENT_TAG="latest"

# Docker images for GKE deployment. Reuses local names
export DOCKER_HUB_GKE="gcr.io/${PROJECT_ID}/${IMAGE_HUB_NAME}:${IMAGE_HUB_TAG}"
export DOCKER_AGENT_GKE="gcr.io/${PROJECT_ID}/${IMAGE_AGENT_NAME}:${IMAGE_AGENT_TAG}"

# Docker images for Jupyter. 
# Can hardcode in jupyterhub_config.py profiles 
# but easier to test locally if using env variables.
# export IMAGES_JUPYTER=(jupyter-mine-basic jupyter-ain-pytorch jupyter-ain-tensorflow)
export IMAGES_JUPYTER=(jupyter-mine-basic)
export DOCKERS_JUPYTER_LOCAL=$(printf %s, ${IMAGES_JUPYTER[@]} | sed s/.$//)
export DOCKERS_JUPYTER_GKE=$(printf gcr.io/${PROJECT_ID}/%s, ${IMAGES_JUPYTER[@]} | sed s/.$//)