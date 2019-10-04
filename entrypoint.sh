#!/bin/bash

echo "Configuring git"
git config --global url."https://${INPUT_GITUSERNAME}:${INPUT_GITACCESSTOKEN}@github.com".insteadOf "https://github.com"

echo "Installing docker"
apk add --update docker
service docker start

echo "Installing gcloud and kubectl"
curl -sSL https://sdk.cloud.google.com | bash
PATH=$PATH:/root/google-cloud-sdk/bin
source /github/home/google-cloud-sdk/path.bash.inc
gcloud components install kubectl
kubectl version

echo "Cloning ${GITHUB_REPOSITORY}"
git clone "https://github.com/${GITHUB_REPOSITORY}.git"
IFS='/'
read -ra ADDR <<< "${GITHUB_REPOSITORY}"
IDX=${#ADDR[@]}-1
cd "${ADDR[${IDX}]}"

echo "Getting kubeconfig file from GKE"
echo "${INPUT_GKEAPPLICATIONCREDENTIALS}" | base64 -d > /tmp/account.json
gcloud auth configure-docker
gcloud auth activate-service-account --key-file=/tmp/account.json
gcloud config set project "${INPUT_GKEPROJECTID}"
gcloud container clusters get-credentials "${INPUT_GKECLUSTERNAME}" --zone "${INPUT_GKELOCATIONZONE}" --project "${INPUT_GKEPROJECTID}"
export KUBECONFIG="$HOME/.kube/config"

echo "Building image from Dockerfile"
docker build \
    --build-arg "USERNAME=${INPUT_GITUSERNAME}" \
    --build-arg "ACCESSTOKEN=${INPUT_GITACCESSTOKEN}" \
    -t "${INPUT_GCRHOSTNAME}"/${{ secrets.GKE_PROJECT_ID }}/feed-analyzer:$GITHUB_SHA .

echo "Pushing to Docker registry"
docker tag "${INPUT_GCRHOSTNAME}"/"${INPUT_GKEPROJECTID}"/feed-analyzer:$GITHUB_SHA "${INPUT_GCRHOSTNAME}"/"${INPUT_GKEPROJECTID}"/feed-analyzer:latest
docker push "${INPUT_GCRHOSTNAME}"/"${INPUT_GKEPROJECTID}"/feed-analyzer

echo "Deploy to GKE"
kubectl set image deployment/feed-analyzer feed-analyzer-sha256="${INPUT_GKEHOSTNAME}"/"${INPUT_GKEPROJECTID}"/feed-analyzer -n "${INPUT_GKENAMESPACE}"
