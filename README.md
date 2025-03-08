# Cursor AI IDE Installation Script

This script allows you to install the Cursor AI IDE on Ubuntu using either of the following methods:

1. **With FUSE** (Recommended) - Runs the AppImage directly.
2. **Without FUSE** - Extracts the AppImage and runs it manually.

## Installation Steps

### 1. Download and Run the Script
```bash
curl -L -o install_cursor.sh https://your-script-url.com/install_cursor.sh
chmod +x install_cursor.sh
./install_cursor.sh
```

### 2. Choose Installation Method
When prompted, choose one of the following options:
- **1) Install with FUSE (Recommended)**
- **2) Install without FUSE (Extract AppImage)**

### 3. Accessing Cursor AI
Once installed, you can access Cursor AI in the following ways:

#### **From the Application Menu**
- Search for 'Cursor' and click the icon.

#### **From the Terminal**
```bash
cursor
```
Depending on the installation method:
- If installed with FUSE: `~/.local/bin/cursor.appimage --no-sandbox`
- If installed without FUSE: `~/.local/share/cursor-extracted/squashfs-root/cursor --no-sandbox`

#### **Using the Alias**
- Restart your terminal or run:
  ```bash
  source ~/.bashrc
  ```
- Now, you can launch Cursor using:
  ```bash
  cursor
  ```

## Uninstallation Steps
If you wish to uninstall Cursor AI, follow these steps:

### 1. Remove Cursor Files
```bash
rm -rf ~/.local/bin/cursor.appimage
rm -rf ~/.local/share/cursor-extracted
rm -rf ~/.local/share/icons/cursor.png
rm -rf ~/.local/share/applications/cursor.desktop
```

### 2. Remove Alias (If Added)
```bash
sed -i '/alias cursor=/d' ~/.bashrc
source ~/.bashrc
```

### 3. Optional: Remove `libfuse2` (If Installed for Cursor)
```bash
sudo apt remove --purge libfuse2 -y
```

## Additional Information
- The script ensures necessary dependencies like `libfuse2` are installed.
- The Cursor icon is downloaded and used for a proper desktop entry.
- A desktop shortcut is created for easy access.

Enjoy coding with Cursor AI! 🚀
