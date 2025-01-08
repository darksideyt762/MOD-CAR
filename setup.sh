#!/bin/bash

# Clone the repository if not already cloned
if [ ! -d "$HOME/MOD-CAR" ]; then
  git clone https://github.com/darksideyt762/MOD-CAR.git $HOME/MOD-CAR
fi

# Change to the repository directory
cd $HOME/MOD-CAR

# Make sure the car script is executable
chmod +x car

# Create a symbolic link for the script to be accessible globally as "car"
if [ ! -L "/data/data/com.termux/files/usr/bin/car" ]; then
  ln -s $HOME/MOD-CAR/car /data/data/com.termux/files/usr/bin/car
fi

# Ensure cars.txt and default.txt are in the same directory as the script
if [ ! -f "$HOME/MOD-CAR/cars.txt" ] || [ ! -f "$HOME/MOD-CAR/default.txt" ]; then
  echo "Error: cars.txt or default.txt are missing in the repository."
  exit 1
fi

# Ensure the symbolic link is executable
chmod +x /data/data/com.termux/files/usr/bin/car

# Adjust permissions for the entire /data/data/com.termux/files/usr/bin directory (if necessary)
chmod 755 /data/data/com.termux/files/usr/bin

echo "Setup completed successfully! You can now run the script by typing 'car'."
