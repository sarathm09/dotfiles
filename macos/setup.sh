#!/usr/bin/env bash

# ~/.macos — https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

#!/bin/sh

echo "========================================"
echo "          WELCOME TO THE INSTALL       "
echo "========================================"
echo "   This script will set up your system  "
echo "   by running necessary installation     "
echo "   scripts in the specified directories. "
echo "========================================"

# Prompt for user inputs

echo "Enter the following details for setting up the system"
read -p "Enter the name to set for the system: " computerName
export computerName
read -p "Enter the hostname: " hostName
export hostName


echo "Enter the following details for setting up git"
read -p "Enter your name: " userName
export userName
read -p "Enter your email: " userEmail
export userEmail
read -p "Enter your GitHub username: " githubUser
export githubUser


# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Updating OS and XCode tools"
sudo softwareupdate -i -a
xcode-select --install

if test ! $(which brew)
then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -n "$computerName" ]]; then
    sudo scutil --set ComputerName "$computerName"
fi

if [[ -n "$hostName" ]]; then
    sudo scutil --set HostName "$hostName"
    sudo scutil --set LocalHostName "$hostName"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$hostName"
fi

### Install apps using brew
brew bundle

sudo mkdir -p -m 775 /usr/local/bin

### Run all setup files
directories=("apps" "workspace")
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        # Loop through all .sh files in the directory
        for script in "$dir"/*.sh; do
            if [ -f "$script" ]; then
                echo "🚀 Running $script \n\n"
                chmod +x ./"$script"
                ./"$script"
            fi
        done
    else
        echo "[‼️] Directory $dir does not exist"
    fi
done

# Create symlinks
# Loop through all .files in the directory
for script in "config/*"; do
    if [ -f "$script" ]; then
        echo "🚀 Linking config $script \n\n"
        ln -s "$script" "~/$script"
    fi
done

# Creating Workspace entries
chmod +x workspace/setup.sh
./workspace/setup.sh

# Copying work related config


echo "Done. Note that some of these changes require a logout/restart to take effect."