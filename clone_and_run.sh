#!/bin/bash

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

# Check if the "remote" argument is provided
if [[ $1 == "remote" ]]; then
  echo "Remote argument detected. Updating .env file in frontend directory."

  # Change to the frontend directory
  cd frontend
  INSTANCE_PUBLIC_DNS=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
  # Clear the contents of the .env file and write the new line
  > .env  # This truncates the file to zero length
  echo "VITE_API_BASE_URL=http://${INSTANCE_PUBLIC_DNS}:8080" > .env

  echo ".env file updated with VITE_API_BASE_URL."

  # Return to the root directory
  cd ..
fi

# Run Docker Compose to build and start the services
echo "Running docker-compose up --build..."
docker-compose -f docker-compose.yml up --build -d