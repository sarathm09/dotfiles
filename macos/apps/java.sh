#!/bin/bash

brew install -f openjdk@21

echo 'export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"' >> ~/.zshrc
