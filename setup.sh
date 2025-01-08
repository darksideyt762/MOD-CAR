#!/bin/bash

# Remove any old symbolic links or files from /bin
if [ -f "/data/data/com.termux/files/usr/bin/cars.txt" ]; then
  rm -f "/data/data/com.termux/files/usr/bin/cars.txt"
fi

if [ -f "/data/data/com.termux/files/usr/bin/default.txt" ]; then
  rm -f "/data/data/com.termux/files/usr/bin/default.txt"
fi

# Ensure the repository directory exists
if [ ! -d "$HOME/MOD-CAR" ]; then
  echo "Cloning the MOD-CAR repository..."
  git clone https://github.com/darksideyt762/MOD-CAR.git "$HOME/MOD-CAR"
else
  echo "Updating the MOD-CAR repository..."
  cd "$HOME/MOD-CAR" || { echo "Failed to navigate to MOD-CAR directory."; exit 1; }
  git reset --hard HEAD  # Reset any local changes
  git pull origin main   # Pull the latest updates
fi

# Ensure cars.txt and default.txt are in the repository
cd "$HOME/MOD-CAR" || { echo "Failed to navigate to MOD-CAR directory."; exit 1; }
if [ ! -f "cars.txt" ] || [ ! -f "default.txt" ]; then
  echo "Error: cars.txt or default.txt are missing in the repository."
  exit 1
fi

# Make the main script executable
chmod +x car

# Create a symbolic link for the script to be accessible globally as "CAR"
ln -sf "$HOME/MOD-CAR/car" /data/data/com.termux/files/usr/bin/CAR

echo "Setup completed successfully! You can now run the script by typing 'CAR'."
