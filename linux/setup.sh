#!/bin/sh

if test ! $(which brew)
then
    echo "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
fi

### Run all setup files
directories=("apps" "workspace")
for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        # Loop through all .sh files in the directory
        for script in "$dir"/*.sh; do
            if [ -f "$script" ]; then
                print_in_purple "Running $script \n\n"
                ./"$script"
            fi
        done
    else
        echo "Directory $dir does not exist"
    fi
done