#!/bin/bash

# "Disable backswipe"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
# "Expand print dialog by default"
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
# "Use system-native print preview dialog"
defaults write com.google.Chrome DisablePrintPreview -bool true

killall "Google Chrome" &> /dev/null
