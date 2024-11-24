#!/bin/bash

# "Enable debug menu"
defaults write com.apple.appstore ShowDebugMenu -bool true
# "Turn on auto-update"
defaults write com.apple.commerce AutoUpdate -bool true
# "Enable automatic update check"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# "Download newly available updates in background"
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# "Install System data files and security updates"
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

killall "App Store" &> /dev/null
