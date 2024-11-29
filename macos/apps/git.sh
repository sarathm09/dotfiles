#!/bin/bash

add_ssh_configs() {
    printf "%s\n" \
        "Host github.com" \
        "  IdentityFile $1" \
        "  LogLevel ERROR" >> ~/.ssh/config

    print_result $? "Add SSH configs"
}

copy_public_ssh_key_to_clipboard () {
    if cmd_exists "pbcopy"; then
        pbcopy < "$1"
        print_result $? "Copy public SSH key to clipboard"
    elif cmd_exists "xclip"; then
        xclip -selection clip < "$1"
        print_result $? "Copy public SSH key to clipboard"
    else
        print_warning "Please copy the public SSH key ($1) to clipboard"
    fi
}

generate_ssh_keys() {
    ask "Please provide an email address: " && printf "\n"
    ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$1"
    print_result $? "Generate SSH keys"
}

open_github_ssh_page() {
    declare -r GITHUB_SSH_URL="https://github.com/settings/ssh"

    if cmd_exists "xdg-open"; then
        xdg-open "$GITHUB_SSH_URL"
    elif cmd_exists "open"; then
        open "$GITHUB_SSH_URL"
    else
        print_warning "Please add the public SSH key to GitHub ($GITHUB_SSH_URL)"
    fi
}

set_github_ssh_key() {
    local sshKeyFileName="$HOME/.ssh/github"

    if [ -f "$sshKeyFileName" ]; then
        sshKeyFileName="$(mktemp -u "$HOME/.ssh/github_XXXXX")"
    fi
    generate_ssh_keys "$sshKeyFileName"
    add_ssh_configs "$sshKeyFileName"
    copy_public_ssh_key_to_clipboard "${sshKeyFileName}.pub"
    open_github_ssh_page
    test_ssh_connection && rm "${sshKeyFileName}.pub"
}

test_ssh_connection() {
    while true; do
        ssh -T git@github.com &> /dev/null
        [ $? -eq 1 ] && break

        sleep 5
    done
}

generate_and_export_gpg_key() {
    # Prompt for user details
    read -p "Enter your name for GPG key: " NAME
    read -p "Enter your email address for GPG key: " EMAIL

    if [[ -z "$NAME" || -z "$EMAIL" ]]; then
        echo "Error: Name and email are required. Exiting."
        return 1
    fi

    # Step 1: Generate a new GPG key
    echo "Generating a new GPG key for $NAME <$EMAIL>..."
    gpg --batch --gen-key <<EOF
Key-Type: RSA
Key-Length: 4096
Subkey-Type: RSA
Subkey-Length: 4096
Name-Real: $NAME
Name-Email: $EMAIL
Expire-Date: 0
%commit
EOF

    # Step 2: Extract the GPG key ID
    GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep "sec" | awk '{print $2}' | cut -d'/' -f2 | tail -n1)
    if [ -z "$GPG_KEY_ID" ]; then
        echo "Error: Failed to generate GPG key. Exiting."
        return 1
    fi

    echo "GPG Key ID: $GPG_KEY_ID"

    # Step 3: Export the GPG public key
    echo "Exporting the GPG public key..."
    GPG_PUBLIC_KEY=$(gpg --armor --export "$GPG_KEY_ID")
    if [ -z "$GPG_PUBLIC_KEY" ]; then
        echo "Error: Failed to export GPG public key. Exiting."
        return 1
    fi

    # Copy the public key to the clipboard using pbcopy
    echo "$GPG_PUBLIC_KEY" | pbcopy
    echo "GPG public key copied to clipboard."

    # Step 4: Open the GitHub URL to add the key
    GITHUB_GPG_URL="https://github.com/settings/gpg/new"
    echo "Opening the GitHub page to add your GPG key..."
    open "$GITHUB_GPG_URL" || xdg-open "$GITHUB_GPG_URL"

    echo "Done! Paste the key from your clipboard into GitHub."
}

main() {
    print_in_purple "\n • Set up GitHub SSH keys\n\n"

    if ! is_git_repository; then
        print_error "Not a Git repository"
        exit 1
    fi

    ssh -T git@github.com &> /dev/null

    if [ $? -ne 1 ]; then
        set_github_ssh_key
    fi

    print_result $? "Set up GitHub SSH keys"
    generate_and_export_gpg_key
}
