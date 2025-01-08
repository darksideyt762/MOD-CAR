#!/bin/bash

# Remove old installation if it exists
if [ -d "$HOME/MOD-CAR" ]; then
  echo "Removing old MOD-CAR directory..."
  rm -rf "$HOME/MOD-CAR"
fi

if [ -f "/data/data/com.termux/files/usr/bin/CAR" ]; then
  echo "Removing old symbolic link for CAR..."
  rm -f "/data/data/com.termux/files/usr/bin/CAR"
fi

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/darksideyt762/MOD-CAR.git "$HOME/MOD-CAR"
if [ $? -ne 0 ]; then
  echo "Error: Failed to clone the repository. Check your internet connection or repository URL."
  exit 1
fi

# Change to the repository directory
cd "$HOME/MOD-CAR" || { echo "Error: MOD-CAR directory not found."; exit 1; }

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
ln -sf "$HOME/MOD-CAR/car" "/data/data/com.termux/files/usr/bin/CAR"

# Add an updater function to fetch the latest cars.txt and default.txt
cat << 'EOF' > /data/data/com.termux/files/usr/bin/update_car_files
#!/bin/bash
if [ -d "$HOME/MOD-CAR" ]; then
  cd "$HOME/MOD-CAR" || { echo "Error: MOD-CAR directory not found."; exit 1; }
  git pull origin main
  echo "Files updated successfully!"
else
  echo "Error: MOD-CAR directory not found. Please run the setup script again."
  exit 1
fi
EOF

# Make the updater executable
chmod +x /data/data/com.termux/files/usr/bin/update_car_files

echo "Setup completed successfully! You can now run the script by typing 'CAR'."
echo "You can update cars.txt and default.txt anytime by typing 'update_car_files'."
