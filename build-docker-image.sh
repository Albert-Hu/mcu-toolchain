#!/usr/bin/env bash

# Check if a parameter is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <dockerfile-name|all|list>"
  echo "dockerfile-name is the name of the file in the dockerfiles/ directory"
  echo "'all' will build all Docker images from the dockerfiles/ directory"
  echo "'list' will list all available dockerfiles"
  exit 1
fi

# Handle "list" parameter to list all dockerfiles
if [ "$1" = "list" ]; then
  echo "Available dockerfiles:"
  
  # Check if dockerfiles directory exists
  if [ ! -d "dockerfiles" ]; then
    echo "Error: 'dockerfiles/' directory not found"
    exit 1
  fi
  
  # List all files in dockerfiles/ directory
  DOCKERFILES=$(find dockerfiles -type f -name "*" 2>/dev/null)
  
  if [ -z "$DOCKERFILES" ]; then
    echo "No dockerfiles found in dockerfiles/ directory"
    exit 1
  fi
  
  echo "-------------------------------------"
  for FILE in $DOCKERFILES; do
    # Get just the filename
    FILENAME=$(basename "$FILE")
    echo "- $FILENAME"
  done
  echo "-------------------------------------"
  echo "To build a specific dockerfile: $0 <dockerfile-name>"
  echo "To build all dockerfiles: $0 all"
  exit 0
fi

# Handle "all" parameter to build all dockerfiles
if [ "$1" = "all" ]; then
  echo "Building all Docker images from dockerfiles/ directory"
  
  # Check if dockerfiles directory exists
  if [ ! -d "dockerfiles" ]; then
    echo "Error: 'dockerfiles/' directory not found"
    exit 1
  fi
  
  # Get list of all files in dockerfiles/
  DOCKERFILES=$(find dockerfiles -type f -name "*" 2>/dev/null)
  
  if [ -z "$DOCKERFILES" ]; then
    echo "No Dockerfiles found in dockerfiles/ directory"
    exit 1
  fi
    
  BUILD_FAILED=0
  
  # Loop through each file and build the image
  for FILE in $DOCKERFILES; do
    # Extract the filename without the path
    FILENAME=$(basename "$FILE")
    
    # Check if the Docker image already exists
    if docker image inspect "$FILENAME" &> /dev/null; then
      echo "Docker image '$FILENAME' already exists, skipping build"
      echo "-------------------------------------"
      continue
    fi
    
    echo "Building Docker image: $FILENAME"
    echo "Using Dockerfile: $FILE"
    
    # Build Docker image
    docker build -t "$FILENAME" -f "$FILE" .
      
      if [ $? -ne 0 ]; then
        echo "Docker image '$FILENAME' build failed"
        BUILD_FAILED=1
      else
        echo "Docker image '$FILENAME' successfully built"
      fi
    
    echo "-------------------------------------"
  done
    
  if [ $BUILD_FAILED -eq 1 ]; then
    echo "One or more Docker image builds failed"
    exit 1
  else
    echo "All Docker images successfully built"
    exit 0
  fi
else
  # Set variables for single dockerfile build
  DOCKERFILE_NAME=$1
  DOCKERFILE_PATH="dockerfiles/$DOCKERFILE_NAME"
  IMAGE_NAME=$DOCKERFILE_NAME
  
  # Check if dockerfile exists
  if [ ! -f "$DOCKERFILE_PATH" ]; then
    echo "Error: '$DOCKERFILE_NAME' not found in 'dockerfiles/' directory"
    echo "Available dockerfiles:"
    ls -1 dockerfiles/
    exit 1
  fi
  
  echo "Building Docker image: $IMAGE_NAME"
  echo "Using Dockerfile: $DOCKERFILE_PATH"
  
  # Build Docker image
  docker build -t "$IMAGE_NAME" -f "$DOCKERFILE_PATH" .

# Check build result
if [ $? -eq 0 ]; then
  echo "Docker image '$IMAGE_NAME' successfully built"
else
  echo "Docker image build failed"
  exit 1
fi
fi
