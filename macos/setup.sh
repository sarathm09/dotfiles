#!/usr/bin/env bash

# ~/.macos — https://mths.be/macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

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


# Creating Workspace entries

# Copying work related config


echo "Done. Note that some of these changes require a logout/restart to take effect."