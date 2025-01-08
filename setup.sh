#!/bin/bash

# Remove old installation
rm -rf ~/MOD-CAR
rm -f /data/data/com.termux/files/usr/bin/CAR

# Clone the repository fresh
git clone https://github.com/darksideyt762/MOD-CAR.git ~/MOD-CAR

# Change to the repository directory
cd ~/MOD-CAR

# Make sure the main script is executable
chmod +x car

# Create a symbolic link for the script to be accessible globally as "CAR"
ln -sf ~/MOD-CAR/car /data/data/com.termux/files/usr/bin/CAR

# Ensure cars.txt and default.txt are in the repository
if [ ! -f "cars.txt" ] || [ ! -f "default.txt" ]; then
  echo "Error: cars.txt or default.txt are missing in the repository."
  exit 1
fi

echo "Setup completed successfully! You can now run the script by typing 'CAR'."

# Add an updater function to fetch the latest cars.txt and default.txt
cat << 'EOF' > /data/data/com.termux/files/usr/bin/update_car_files
#!/bin/bash
cd ~/MOD-CAR || { echo "MOD-CAR directory not found!"; exit 1; }
git pull origin main
echo "Files updated successfully!"
EOF

# Make the updater executable
chmod +x /data/data/com.termux/files/usr/bin/update_car_files

echo "You can update cars.txt and default.txt anytime by typing 'update_car_files'."
