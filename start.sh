#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo "Creating virtual environment..."
python3 -m venv venv
# Activate the virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Update Python, pip, setuptools, and gplayproxy
echo "Updating Python, pip, setuptools, and gplayproxy..."
pip install --upgrade pip setuptools wheel
pip install --upgrade gplayproxy

# Check if required tools are installed
if ! command_exists pip; then
    echo "pip is not installed. Please install pip."
    exit 1
fi

if ! command_exists python; then
    echo "Python is not installed. Please install Python."
    exit 1
fi

# Install required dependencies
echo "Installing required dependencies..."
pip install gplayproxy

# Set up the proxy server
echo "Setting up the proxy server..."
pserve gplayproxy.ini &

# Start the worker process
echo "Starting the worker process..."
rqworker &

# Provide instructions on how to use the proxy
echo "The Google Play Store proxy is now running."
echo "To download an APK, visit http://localhost:6543/package/<package_name>"
echo "For example: http://localhost:6543/package/org.thoughtcrime.securesms"
echo "APKs will be downloaded to the location specified in the configuration file."
