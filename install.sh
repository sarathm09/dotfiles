#!/bin/sh

echo "========================================"
echo "          WELCOME TO THE INSTALL       "
echo "========================================"
echo "   This script will set up your system  "
echo "   by running necessary installation     "
echo "   scripts in the specified directories. "
echo "========================================"

# Prompt for user inputs
read -p "Enter your name: " userName
export userName
read -p "Enter your email: " userEmail
export userEmail
read -p "Enter your GitHub username: " githubUser
export githubUser


read -p "Enter your GitHub username: " computerName
export computerName
read -p "Enter your GitHub username: " hostName
export hostName


if [[ "$OSTYPE" == "darwin"* ]]; then
    ./macos/setup.sh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    ./linux/setup.sh
else
    echo "Unsupported OS"
fi