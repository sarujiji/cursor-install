# Cursor AI Ubuntu Install Script

This script automates the installation of **Cursor AI** on Ubuntu. It provides two installation methods:

1. **Standard Installation (Requires FUSE)** - Uses AppImage directly.
2. **Alternative Installation (Without FUSE)** - Extracts AppImage manually.

## Installation Steps

### 1. Download the Script
```bash
wget https://your-repository-url/install_cursor.sh
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

## How to Access Cursor AI

### **1. From the Application Menu (GUI)**
- Open **"Activities"** or **"Show Applications"** (Ubuntu app launcher).
- Search for **"Cursor"** and click on the icon to launch it.

### **2. From the Terminal**
#### **If Installed with FUSE (Option 1)**
Run:
```bash
/opt/cursor.appimage --no-sandbox
```
Or create a shortcut:
```bash
alias cursor='/opt/cursor.appimage --no-sandbox'
```
Then, simply run:
```bash
cursor
```

#### **If Installed Without FUSE (Option 2)**
Navigate to the extracted folder:
```bash
cd /opt/cursor-extracted/squashfs-root
./AppRun --no-sandbox
```
To make it easier, create an alias:
```bash
alias cursor='/opt/cursor-extracted/squashfs-root/AppRun --no-sandbox'
```
Now, just type:
```bash
cursor
```

### **3. Using the Desktop Shortcut**
If the script created a shortcut successfully, you can also launch it by clicking on **Cursor** in your application menu.

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

