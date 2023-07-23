#!/bin/bash

# Create a new folder called "minecraft" in your home directory.
mkdir -p ~/minecraft

# Navigate to the "minecraft" folder and create a new folder called "paper."
cd ~/minecraft
mkdir -p paper

# Check if the Minecraft server has already been downloaded.
if [ -f ~/minecraft/paper/paper-1.17.1-301.jar ]; then
    read -p "Minecraft server already downloaded. Do you want to run it? (y/n) " choice
    case "$choice" in
        y|Y ) tmux new-session -d -s minecraft 'java -jar ~/minecraft/proxy/BungeeCord.jar' \; split-window -h 'java -jar ~/minecraft/paper/paper-1.17.1-301.jar';;
        n|N ) echo "Exiting..."; exit;;
        * ) echo "Invalid choice. Exiting..."; exit;;
    esac
else
    # Prompt the user to choose a version of Minecraft to download.
    echo "Choose a version of Minecraft to download:"
    echo "1. Minecraft 1.5.2"
    echo "2. Minecraft 1.6.4"
    echo "3. Minecraft 1.7.10"
    echo "4. Minecraft 1.8.9"
    echo "5. Minecraft 1.9.4"
    echo "6. Minecraft 1.10.2"
    echo "7. Minecraft 1.11.2"
    echo "8. Minecraft 1.12.2"
    echo "9. Minecraft 1.13.2"
    echo "10. Minecraft 1.14.4"
    echo "11. Minecraft 1.15.2"
    echo "12. Minecraft 1.16.5"
    echo "13. Minecraft 1.17.1"
    echo "14. Minecraft 1.18.1"
    echo "15. Minecraft 1.19.1"
    echo "16. Minecraft 1.20.1"
    read -p "Enter your choice (1-16): " version_choice

    case "$version_choice" in
        1 ) minecraft_version="1.5.2";;
        2 ) minecraft_version="1.6.4";;
        3 ) minecraft_version="1.7.10";;
        4 ) minecraft_version="1.8.9";;
        5 ) minecraft_version="1.9.4";;
        6 ) minecraft_version="1.10.2";;
        7 ) minecraft_version="1.11.2";;
        8 ) minecraft_version="1.12.2";;
        9 ) minecraft_version="1.13.2";;
        10 ) minecraft_version="1.14.4";;
        11 ) minecraft_version="1.15.2";;
        12 ) minecraft_version="1.16.5";;
        13 ) minecraft_version="1.17.1";;
        14 ) minecraft_version="1.18.1";;
        15 ) minecraft_version="1.19.1";;
        16 ) minecraft_version="1.20.1";;
        * ) echo "Invalid choice. Exiting..."; exit;;
    esac

    # Download the chosen version of PaperMC.
    wget "https://papermc.io/api/v2/projects/paper/versions/$minecraft_version/builds/301/downloads/paper-$minecraft_version-301.jar" -P ~/minecraft/paper

    # Check the required Java version for the downloaded Minecraft version.
    # For example, for Minecraft version 1.17.1, the required Java version is Java 16.
    # If the required Java version is not installed, prompt the user to download and install it.

    # Create a file called "VERSION-DOWNLOADED" in the "paper" folder.
    touch ~/minecraft/paper/VERSION-DOWNLOADED

    # Generate a signature for the downloaded file using a secret key called "SIGN."

    # Check if the "VERSION-DOWNLOADED" file exists and if its signature matches your signature.
    # If not, create the file and write your signature to it.

    # Create a new folder called "proxy" in the "minecraft" folder.
    mkdir -p ~/minecraft/proxy

    # Download the latest version of BungeeCord.
    wget "https://ci.md-5.net/job/BungeeCord/lastSuccessfulBuild/artifact/bootstrap/target/BungeeCord.jar" -P ~/minecraft/proxy

    # Check if the "VERSION-DOWNLOADED" file exists.
    # If not, create a folder called "plugins" in the "proxy" folder.
    mkdir -p ~/minecraft/proxy/plugins

    # Download the ProtocolSupport plugin for versions greater than 1.8.
    if (( $(echo "$version_choice > 4" | bc -l) )); then
        wget "https://example.com/protocolsupport-$minecraft_version.jar" -P ~/minecraft/proxy/plugins #I am going to fix this in a second.
    fi

    # Use the following command to run both the BungeeCord and PaperMC servers:
    tmux new-session -d -s minecraft 'java -jar ~/minecraft/proxy/BungeeCord.jar' \; split-window -h "java -jar ~/minecraft/paper/paper-$minecraft_version-301.jar"
fi
