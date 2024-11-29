#!/bin/bash

# "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true && \
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true && \
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Finder: hide hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool false

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# "Use full POSIX path as window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# "Disable all animations"
defaults write com.apple.finder DisableAllAnimations -bool true

# "Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# "Search the current directory by default"
defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'

# "Disable warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# "Use list view in all Finder windows by default"
# # Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, 'Nlsv'
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"

# "Set 'Home' as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTarget -string "PfHm" && \
    defaults write com.apple.finder NewWindowTargetPath -string 'file://$HOME/'

# "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true && \
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false && \
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true && \
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# "Do not show recent tags"
defaults write com.apple.finder ShowRecentTags -bool false

# "Show all filename extensions"
defaults write -g AppleShowAllExtensions -bool true

# Decrease the size of icons on the desktop
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 100" ~/Library/Preferences/com.apple.finder.plist

# Increase the size of icons other icon views
# /usr/libexec/PlistBuddy -c "Set :FK_DefaultIconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Set icon grid spacing size
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 7' ~/Library/Preferences/com.apple.finder.plist && \
    /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 5' ~/Library/Preferences/com.apple.finder.plist

# "Set icon label text size"
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 12' ~/Library/Preferences/com.apple.finder.plist && \
    /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:textSize 12' ~/Library/Preferences/com.apple.finder.plist

# "Show item info"
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist

# Show item info to the right of the icons on the desktop
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# "Set icon label position"
/usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist


# "Set sort method"
/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy name' ~/Library/Preferences/com.apple.finder.plist && \
    /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy name' ~/Library/Preferences/com.apple.finder.plist

# Keep folders on top when sorting by name
defaults write com.apple.finder "_FXSortFoldersFirstOnDesktop" -bool "true"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Enables snap-to-grid for icons on the desktop
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder.
chflags nohidden ~/Library

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Automatically empty bin after 30 days
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"

killall "Finder" &> /dev/null

# Starting with Mac OS X Mavericks preferences are cached,
# so in order for things to get properly set using `PlistBuddy`,
# the `cfprefsd` process also needs to be killed.
#
# https://github.com/alrra/dotfiles/commit/035dda057ddc6013ba21db3d2c30eeb51ba8f200

killall "cfprefsd" &> /dev/null
