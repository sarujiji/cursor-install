# cursor-install
# Cursor AI Ubuntu Install Script

This script automates the installation of **Cursor AI** on Ubuntu. It provides two installation methods:

1. **Standard Installation (Requires FUSE)** - Uses AppImage directly.
2. **Alternative Installation (Without FUSE)** - Extracts AppImage manually.

## Installation Steps

### 1. Download the Script
```bash
wget https://sarujiji/cursor-install/install_cursor.sh
```

### 2. Make the Script Executable
```bash
chmod +x install_cursor.sh
```

### 3. Run the Script
```bash
sudo ./install_cursor.sh
```

### 4. Choose Installation Method
- Press `1` for **Standard Installation (FUSE Required)**.
- Press `2` for **Alternative Installation (No FUSE Required)**.

## Features
- 🛠 **Downloads the latest Cursor AI AppImage**
- 🔧 **Checks and installs missing dependencies**
- 🖥 **Creates a desktop shortcut for easy access**
- 🛑 **Fixes sandboxing issues if using the extracted version**

## Alternative Installation Without FUSE
If FUSE causes issues, the script can extract the AppImage manually and run it from an extracted folder.

```bash
cd /opt/cursor-extracted/squashfs-root
./AppRun --no-sandbox
```

## Uninstall Cursor AI
To remove Cursor AI, run:
```bash
sudo rm -rf /opt/cursor* /usr/share/applications/cursor.desktop
```

## Troubleshooting
If you encounter sandboxing issues, try:
```bash
sudo chown root:root /opt/cursor-extracted/squashfs-root/chrome-sandbox
sudo chmod 4755 /opt/cursor-extracted/squashfs-root/chrome-sandbox
```

---

**Enjoy Cursor AI on Ubuntu! 🚀**

