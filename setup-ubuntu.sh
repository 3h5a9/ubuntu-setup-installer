#!/bin/bash

# Function to display headers in an easy-to-read format
function print_header() {
    echo -e "\n\033[1;34m$1\033[0m"
}

# Function to print a section with a separator and emojis
function print_section() {
    echo -e "\n\033[1;36m=======================================================\033[0m"
    echo -e "\033[1;32m💻 $1\033[0m"
    echo -e "\033[1;36m=======================================================\033[0m"
}

# Function to ask for user input: Y/N
function prompt_yes_no() {
    while true; do
        read -p "$1 [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Ensure the system is updated
function update_system() {
    print_section "Updating System Packages"
    sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
    echo -e "✅ System updated successfully!\n"
}

# Install essential software
function install_essential_software() {
    print_section "Installing Essential Software"
    sudo apt install -y curl wget git build-essential vim htop ufw
    echo -e "✅ Essential software installed!\n"
}

# Install GNOME Tweaks and related tools
function install_gnome_tools() {
    if prompt_yes_no "Do you want to install GNOME Tweaks for system customization?" ; then
        print_section "Installing GNOME Tweaks"
        sudo apt install -y gnome-tweaks gnome-shell-extensions
        echo -e "✅ GNOME Tweaks and Shell Extensions installed!\n"
    fi
}

# Install Flatpak and configure Flathub (Optional)
function install_flatpak() {
    if prompt_yes_no "Do you want to install Flatpak for additional apps?" ; then
        print_section "Installing Flatpak"
        sudo apt install -y flatpak
        sudo apt install -y gnome-software-plugin-flatpak
        echo "Flatpak installed. You can now add Flathub repository to access many more apps."
    fi
}

# Install Docker (Optional)
function install_docker() {
    if prompt_yes_no "Do you want to install Docker?" ; then
        print_section "Installing Docker"
        sudo apt install -y docker.io
        sudo systemctl enable --now docker
        echo -e "✅ Docker installed and started!\n"
    fi
}

# Install Web Browsers (Optional)
function install_browsers() {
    if prompt_yes_no "Do you want to install Chromium browser?" ; then
        print_section "Installing Chromium"
        sudo apt install -y chromium-browser
    fi

    if prompt_yes_no "Do you want to install Google Chrome?" ; then
        print_section "Installing Google Chrome"
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo dpkg -i google-chrome-stable_current_amd64.deb
        sudo apt install -f -y
        rm google-chrome-stable_current_amd64.deb
        echo -e "✅ Google Chrome installed!\n"
    fi
}

# Install Media Players (Optional)
function install_media_players() {
    if prompt_yes_no "Do you want to install VLC media player?" ; then
        print_section "Installing VLC"
        sudo apt install -y vlc
        echo -e "✅ VLC media player installed!\n"
    fi
}

# Install Communication Tools (Optional)
function install_communication_tools() {
    if prompt_yes_no "Do you want to install Slack?" ; then
        print_section "Installing Slack"
        sudo snap install slack --classic
    fi

    if prompt_yes_no "Do you want to install Discord?" ; then
        print_section "Installing Discord"
        sudo snap install discord
    fi

    if prompt_yes_no "Do you want to install Zoom?" ; then
        print_section "Installing Zoom"
        sudo snap install zoom-client
    fi
}

# Install System Cleaner (Optional)
function install_cleaner() {
    if prompt_yes_no "Do you want to install BleachBit (System Cleaner)?" ; then
        print_section "Installing BleachBit"
        sudo apt install -y bleachbit
        echo -e "✅ BleachBit installed! You can now clean your system easily.\n"
    fi
}

# Install Security Tools
function configure_security() {
    print_section "Configuring Security Settings"
    sudo ufw enable
    sudo ufw status
    echo -e "✅ Firewall enabled and configured.\n"
}

# Configure Backup Tools (Optional)
function configure_backups() {
    if prompt_yes_no "Do you want to set up automatic backups using Deja Dup?" ; then
        print_section "Setting up Backups"
        sudo apt install -y deja-dup
        echo -e "✅ Deja Dup backup tool installed. You can configure it via the 'Settings' app.\n"
    fi
}

# Install VirtualBox (Optional)
function install_virtualbox() {
    if prompt_yes_no "Do you want to install VirtualBox?" ; then
        print_section "Installing VirtualBox"
        sudo apt install -y virtualbox
        echo -e "✅ VirtualBox installed!\n"
    fi
}

# Install Themes & Icons (Optional)
function install_themes_and_icons() {
    if prompt_yes_no "Do you want to install new themes and icons for a custom look?" ; then
        print_section "Installing Themes and Icons"
        sudo apt install -y arc-theme papirus-icon-theme
        echo -e "✅ Arc theme and Papirus icons installed! You can change them in GNOME Tweaks.\n"
    fi
}

# Clean up
function clean_up() {
    print_section "Cleaning Up"
    sudo apt autoremove -y
    echo -e "✅ System cleaned up!\n"
}

# Main script execution
clear
print_header "🚀 Welcome to the Ubuntu 24.04 Setup Script! 🚀"

update_system
install_essential_software
install_gnome_tools
install_flatpak
install_docker
install_browsers
install_media_players
install_communication_tools
install_cleaner
configure_security
configure_backups
install_virtualbox
install_themes_and_icons
clean_up

print_header "🎉 Setup Complete! 🎉"
echo -e "Your system is now ready and fully configured! Enjoy your Ubuntu experience! 😎"
