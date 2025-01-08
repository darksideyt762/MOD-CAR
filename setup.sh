#!/bin/bash

# Remove old installation if it exists
if [ -d "MOD-CAR" ]; then
  echo "Removing old MOD-CAR directory..."
  rm -rf "MOD-CAR"
fi

if [ -f "/data/data/com.termux/files/usr/bin/CAR" ]; then
  echo "Removing old symbolic link for CAR..."
  rm -f "/data/data/com.termux/files/usr/bin/CAR"
fi

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/darksideyt762/MOD-CAR.git
if [ $? -ne 0 ]; then
  echo "Error: Failed to clone the repository. Check your internet connection or repository URL."
  exit 1
fi

# Change to the repository directory
cd "MOD-CAR" || { echo "Error: MOD-CAR directory not found."; exit 1; }

# Make the main script executable
if [ -f "car" ]; then
  chmod +x car
else
  echo "Error: 'car' script not found in the repository."
  exit 1
fi

# Ensure cars.txt and default.txt exist
if [ ! -f "cars.txt" ] || [ ! -f "default.txt" ]; then
  echo "Error: cars.txt or default.txt are missing in the repository."
  exit 1
fi

# Create a symbolic link for the script to be accessible globally as "CAR"
ln -sf "$(pwd)/car" "/data/data/com.termux/files/usr/bin/CAR"

echo "Setup completed successfully! You can now run the script by typing 'CAR'."
