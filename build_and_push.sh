#!/bin/bash

# Configuration
REGISTRY="ghcr.io"
# Get repository name from git or set manually
REPO="${1:-$(git config --get remote.origin.url | sed 's|.*github.com/||' | sed 's|\.git||')}"

if [[ -z "$REPO" ]]; then
  echo "Error: Cannot determine repository name. Usage: $0 <owner/repo>"
  exit 1
fi

REGISTRY_USER=$(echo "$REPO" | tr '[:upper:]' '[:lower:]')
FULL_REGISTRY="${REGISTRY}/${REGISTRY_USER}"

echo "Building and pushing to: $FULL_REGISTRY"
echo "---"

# Get filtered Dockerfiles: exclude trt, dgx, and cudnn9_ubuntu24
files=$(printf '%s\n' Dockerfile* | grep -E '^Dockerfile' | grep -v -E 'trt.*|dgx.*|cudnn9_ubuntu24' || true)

if [[ -z "$files" ]]; then
  echo "No Dockerfiles matched the filter."
  exit 0
fi

# Build and push each Dockerfile
while IFS= read -r dockerfile; do
  if [[ -z "$dockerfile" ]]; then
    continue
  fi

  # Extract suffix (everything after "Dockerfile_")
  suffix="${dockerfile#Dockerfile_}"
  
  if [[ -z "$suffix" ]]; then
    echo "Skipping $dockerfile: No valid suffix for Docker image tag."
    continue
  fi

  imagename="${FULL_REGISTRY}:${suffix}"

  echo "Building $dockerfile as $imagename"
  docker build -f "$dockerfile" -t "$imagename" . || {
    echo "Error building $dockerfile"
    continue
  }

  echo "Pushing $imagename"
  docker push "$imagename" || {
    echo "Error pushing $imagename"
    continue
  }

  echo "✓ Successfully built and pushed $imagename"
  echo ""
done <<< "$files"

echo "Done!"
