#!/bin/bash

# Define installation paths and URLs
CURSOR_URL="https://downloader.cursor.sh/linux/appImage/x64"
ICON_URL="https://raw.githubusercontent.com/rahuljangirwork/copmany-logos/refs/heads/main/cursor.png"

APPIMAGE_PATH="/opt/cursor.appimage"
ICON_PATH="/opt/cursor.png"
DESKTOP_ENTRY_PATH="/usr/share/applications/cursor.desktop"
EXTRACTED_PATH="/opt/cursor-extracted"

# Function to install Cursor using AppImage and FUSE
install_with_fuse() {
    echo "Installing Cursor AI IDE using FUSE..."

    # Install libfuse2 if not installed
    if ! dpkg -s libfuse2 &> /dev/null; then
        echo "libfuse2 is not installed. Installing..."
        sudo apt update
        sudo apt install -y libfuse2
    fi

    # Download Cursor AppImage
    echo "Downloading Cursor AppImage..."
    sudo curl -L $CURSOR_URL -o $APPIMAGE_PATH
    sudo chmod +x $APPIMAGE_PATH

    # Download Cursor icon
    echo "Downloading Cursor icon..."
    sudo curl -L $ICON_URL -o $ICON_PATH

    # Create desktop entry
    echo "Creating desktop entry..."
    echo "[Desktop Entry]
Name=Cursor
Exec=$APPIMAGE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Terminal=false" | sudo tee $DESKTOP_ENTRY_PATH

    echo "Cursor AI IDE installed successfully."
}

# Function to install Cursor without FUSE (Extracting AppImage)
install_without_fuse() {
    echo "Installing Cursor AI IDE without FUSE..."
    
    # Download Cursor AppImage
    echo "Downloading Cursor AppImage..."
    sudo curl -L $CURSOR_URL -o $APPIMAGE_PATH
    sudo chmod +x $APPIMAGE_PATH

    # Extract AppImage
    echo "Extracting AppImage..."
    mkdir -p $EXTRACTED_PATH
    cd $EXTRACTED_PATH
    $APPIMAGE_PATH --appimage-extract

    # Fix sandboxing issue
    echo "Fixing sandboxing issue..."
    sudo chown root:root $EXTRACTED_PATH/squashfs-root/chrome-sandbox
    sudo chmod 4755 $EXTRACTED_PATH/squashfs-root/chrome-sandbox

    # Create desktop entry
    echo "Creating desktop entry..."
    echo "[Desktop Entry]
Name=Cursor
Exec=$EXTRACTED_PATH/squashfs-root/AppRun --no-sandbox
Icon=$ICON_PATH
Type=Application
Terminal=false" | sudo tee $DESKTOP_ENTRY_PATH

    echo "Cursor AI IDE installed successfully (without FUSE)."
}

# Ask the user for their preferred installation method
echo "Select installation method:"
echo "1) Install with FUSE (Recommended)"
echo "2) Install without FUSE (Extract AppImage)"
read -p "Enter choice [1 or 2]: " choice

if [ "$choice" == "1" ]; then
    install_with_fuse
elif [ "$choice" == "2" ]; then
    install_without_fuse
else
    echo "Invalid choice. Exiting."
    exit 1
fi
