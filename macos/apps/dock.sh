#!/bin/bash

# "Automatically hide/show the Dock"
defaults write com.apple.dock autohide -bool false

# "Disable the hide Dock delay"
defaults write com.apple.dock autohide-delay -float 0

# "Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# "Make all Mission Control related animations faster."
defaults write com.apple.dock expose-animation-duration -float 0.1

# "Do not group windows by application in Mission Control"
# defaults write com.apple.dock expose-group-by-app -bool false

# "Disable the opening of an application from the 
# defaults write com.apple.dock launchanim -bool falseDock animations.

# "Change minimize/maximize window effect"
defaults write com.apple.dock mineffect -string 'scale'

# "Reduce clutter by minimizing windows into their application
defaults write com.apple.dock minimize-to-application -bool true

# "Wipe all app icons"
defaults write com.apple.dock persistent-apps -array && defaults write com.apple.dock persistent-others -array 

# "Show indicator lights for open applications"
defaults write com.apple.dock show-process-indicators -bool true

# "Do not show recent applications in Dock"
defaults write com.apple.dock show-recents -bool false

# "Make icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true

# "Set icon size"
defaults write com.apple.dock tilesize -int 42

# "Move dock to left"
defaults write com.apple.Dock orientation -string left

# Choose whether to rearrange Spaces automatically.
defaults write com.apple.dock "mru-spaces" -bool "false"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

dockutil --no-restart --remove all
dockutil --no-restart --add "/Applications/Microsoft Edge.app"
dockutil --no-restart --add "/Applications/Google Chrome.app"
dockutil --no-restart --add "/Applications/iTerm.app"
dockutil --no-restart --add "/Applications/Warp.app"
dockutil --no-restart --add "/Applications/IntelliJ IDEA CE.app"
dockutil --no-restart --add "/Applications/Visual Studio Code.app"
dockutil --no-restart --add "/Applications/Xcode.app"
dockutil --no-restart --add "/System/Applications/Mail.app"
dockutil --no-restart --add "/Applications/WhatsApp.app"
dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"


killall "Dock" &> /dev/null
