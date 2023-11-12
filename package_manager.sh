#!/usr/bin/env bash
# shellcheck shell=bash
packages=()
services=()

# Define OS
# Some dumb changes for the sake of the changes in feature-2
linux_type=$(head /etc/os-release \
| grep '^NAME=' \
| sed '1q' \
| tr -d 'NAME="' \
#Trimming redundant ' ' from the OS name
| cut -d ' ' -f 1)
packages_list_source=$linux_type"_packages.txt"
services_list_source=$linux_type"_services.txt"

# Verify configuration file existance
[[ ! -f "$packages_list_source" ]] && echo "The file $packages_list_source does not exist. Create $packages_list_source with the list of packages you want to manage by this script to continue." && exit 1
[[ ! -f "$services_list_source" ]] && echo "The file $services_list_source does not exist. Create $services_list_source with the list of services you want to manage by this script to continue." && exit 1

# Read the file and split each element separated by ' ' into an array
mapfile -t -d ' ' packages < "$packages_list_source"
mapfile -t -d ' ' services < "$services_list_source"

# Initiate Docker repository & update packages (copied https://docs.docker.com/engine/install/)
docker_init(){
    case "$linux_type" in
    "CentOS")
    sudo yum -y update
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    ;;
    "Fedora")
    sudo dnf -y update
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    ;;
    "Ubuntu")
    sudo apt-get -y update
    # Add Docker's official GPG key:
        sudo apt-get update
        sudo apt-get -y install ca-certificates curl gnupg 
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    ;;
    *)
    echo "Unknown OS, leave me alone"
    ;;
    esac   
}

# OS-dependent package manager function
package_manager(){
    operation_type=$1
    case "$linux_type" in
    "CentOS")
    for package in "${packages[@]}"; do
        sudo yum -y "$operation_type" "$package"
    done
    ;;
    "Fedora")
    for package in "${packages[@]}"; do
        sudo dnf -y "$operation_type" "$package"
    done
    ;;
    "Ubuntu")
    for package in "${packages[@]}"; do
        sudo apt -y "$operation_type" "$package"
    done
    ;;
    *)
    echo "Unknown OS, don't know how to $operation_type package for it. Use another Linux distributive, e.g. Fedora, CentOS or Ubuntu"
    ;;
    esac   
}

# Function to enable and start services
service_launcher(){
    case "$linux_type" in
    "CentOS")
    for service in "${services[@]}"; do
    sudo systemctl start "$service"
    sudo systemctl enable "$service"
    done
    ;;
    "Fedora")
    for service in "${services[@]}"; do
    sudo systemctl start "$service"
    sudo systemctl enable "$service"
    done
    ;;
    "Ubuntu")
    for service in "${services[@]}"; do
    sudo systemctl start "$service"
    sudo systemctl enable "$service"
    done
    ;;
    *)
    echo "Unknown OS, don't know how to launch service for it. Use another Linux distributive, e.g. Fedora, CentOS or Ubuntu"
    ;;
    esac       
}
#Script key manager
case $1 in
    "init")
    docker_init
    ;;
    "install")
    package_manager "$@"
    ;;
    "upgrade")
    package_manager "$@"
    ;;
    "remove")
    package_manager "$@"
    ;;
    "enable")
    service_launcher
    ;;
    *)
    "Key is required. Use one of the list: init install upgrade remove enable"
    ;;
esac
