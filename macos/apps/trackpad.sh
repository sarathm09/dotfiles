#!/bin/bash

# Enable 'Tap to click'
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true && \
     defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1 && \
     defaults write -g com.apple.mouse.tapBehavior -int 1 && \
     defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

# Map 'click or tap with two fingers' to the secondary click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true && \
     defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -int 1 && \
     defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true && \
     defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0 && \
     defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0 && \
     defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 0

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Dragging with three finger drag
defaults write com.apple.AppleMultitouchTrackpad "TrackpadThreeFingerDrag" -bool "true"