#!/bin/bash

echo "Setting up the Modding Tool..."

# Check if the 'car' executable exists
if [ ! -f "car" ]; then
    echo "Error: The 'car' executable is missing. Please ensure it is in the same directory as this setup file."
    exit 1
fi

# Make the 'car' executable
chmod +x car

# Check for required data files
if [ ! -f "cars.txt" ]; then
    echo "Error: 'cars.txt' is missing. Please ensure it is in the same directory as this setup file."
    exit 1
fi

if [ ! -f "default.txt" ]; then
    echo "Error: 'default.txt' is missing. Please ensure it is in the same directory as this setup file."
    exit 1
fi

echo "Setup completed successfully!"
echo "Launching the Modding Tool..."

# Execute the main script
./car
