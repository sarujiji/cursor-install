#!/bin/bash

# Define installation paths and URLs
CURSOR_URL="https://downloader.cursor.sh/linux/appImage/x64"
ICON_URL="https://raw.githubusercontent.com/rahuljangirwork/copmany-logos/refs/heads/main/cursor.png"

USER_HOME="$HOME"
APPIMAGE_PATH="$USER_HOME/.local/bin/cursor.appimage"
ICON_PATH="$USER_HOME/.local/share/icons/cursor.png"
DESKTOP_ENTRY_PATH="$USER_HOME/.local/share/applications/cursor.desktop"
EXTRACTED_PATH="$USER_HOME/.local/share/cursor-extracted"

# Ensure necessary directories exist
mkdir -p "$USER_HOME/.local/bin"
mkdir -p "$USER_HOME/.local/share/icons"
mkdir -p "$USER_HOME/.local/share/applications"

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
    curl -L $CURSOR_URL -o $APPIMAGE_PATH
    chmod +x $APPIMAGE_PATH

    # Download Cursor icon
    echo "Downloading Cursor icon..."
    curl -L $ICON_URL -o $ICON_PATH

    # Create desktop entry
    echo "Creating desktop entry..."
    echo "[Desktop Entry]
Name=Cursor
Exec=$APPIMAGE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Terminal=false" > $DESKTOP_ENTRY_PATH

    # Create alias for terminal access
    echo "alias cursor='$APPIMAGE_PATH --no-sandbox'" >> "$USER_HOME/.bashrc"

    echo "Cursor AI IDE installed successfully."
}

# Function to install Cursor without FUSE (Extracting AppImage)
install_without_fuse() {
    echo "Installing Cursor AI IDE without FUSE..."
    
    # Download Cursor AppImage
    echo "Downloading Cursor AppImage..."
    curl -L $CURSOR_URL -o $APPIMAGE_PATH
    chmod +x $APPIMAGE_PATH

    # Extract AppImage
    echo "Extracting AppImage..."
    mkdir -p $EXTRACTED_PATH
    cd $EXTRACTED_PATH
    $APPIMAGE_PATH --appimage-extract

    # Fix sandboxing issue
    echo "Fixing sandboxing issue..."
    chown $USER:$USER $EXTRACTED_PATH/squashfs-root/chrome-sandbox
    chmod 4755 $EXTRACTED_PATH/squashfs-root/chrome-sandbox

    # Create desktop entry
    echo "Creating desktop entry..."
    echo "[Desktop Entry]
Name=Cursor
Exec=$EXTRACTED_PATH/squashfs-root/AppRun --no-sandbox
Icon=$ICON_PATH
Type=Application
Terminal=false" > $DESKTOP_ENTRY_PATH

    # Create alias for terminal access
    echo "alias cursor='$EXTRACTED_PATH/squashfs-root/AppRun --no-sandbox'" >> "$USER_HOME/.bashrc"

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

# Display access instructions
echo "\nInstallation complete! You can access Cursor AI using the following methods:\n"
echo "1. **From the Application Menu:** Search for 'Cursor' and click the icon."
echo "2. **From the Terminal:** Type 'cursor' and press Enter."
echo "   - If installed with FUSE: '$APPIMAGE_PATH --no-sandbox'"
echo "   - If installed without FUSE: '$EXTRACTED_PATH/squashfs-root/AppRun --no-sandbox'"
echo "3. **Using the Alias:** Restart your terminal or run 'source ~/.bashrc' to use 'cursor' command."
echo "\nEnjoy Cursor AI! 🚀"
