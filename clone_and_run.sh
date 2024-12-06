#!/bin/bash

ENV_FILE=".env.local"
if [[ $1 == "remote" ]]; then
  ENV_FILE=".env.production"
fi

echo "Using environment file: $ENV_FILE"

# Define repositories and directories
FRONTEND_REPO="https://github.com/Integrator-group-5/frontend.git"
BACKEND_REPO="https://github.com/Integrator-group-5/backend.git"
FRONTEND_DIR="frontend"
BACKEND_DIR="backend"

# Clone repositories
clone_repo() {
  local repo_url=$1
  local target_dir=$2
  
  # Check if the directory already exists
  if [ -d "$target_dir" ]; then
    echo "Directory $target_dir already exists. Pulling latest changes."
    cd "$target_dir"
    git pull || { echo "Failed to pull $repo_url"; exit 1; }
    cd ..
  else
    echo "Cloning $repo_url into $target_dir"
    git clone "$repo_url" "$target_dir" || { echo "Failed to clone $repo_url"; exit 1; }
  fi
}

# Start cloning
echo "Cloning repositories..."
clone_repo "$FRONTEND_REPO" "$FRONTEND_DIR"
clone_repo "$BACKEND_REPO" "$BACKEND_DIR"

# Output success message
echo "Repositories cloned successfully."

# Check if repositories were cloned
if [ ! -d "frontend" ] || [ ! -d "backend" ]; then
  echo "Error: One or more repositories were not cloned. Exiting."
  exit 1
fi

# Run Docker Compose to build and start the services
echo "Running docker-compose up --build..."
docker-compose --env-file $ENV_FILE -f docker-compose.yml up --build -d