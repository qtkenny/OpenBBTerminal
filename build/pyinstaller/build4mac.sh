#!/bin/bash

DISK_IMAGE_NAME="OpenBB Terminal"

# exit when any command fails
set -e

# Clean Up artifacts from previous builds
rm -rf build/terminal_mac && rm -rf dist && rm -rf DMG

pyinstaller build/pyinstaller/terminal_mac.spec

# Create the folder that is used for packaging
mkdir DMG

# Copy relevant artifacts to the packaging folder
cp -r build/pyinstaller/macOS_package_assets/* DMG/
mv dist/OpenBBTerminal DMG/"$DISK_IMAGE_NAME"/OpenBB

# Copy launcher and other artifacts to the DMG
hdiutil create \
        -volname "$DISK_IMAGE_NAME" \
        -srcfolder DMG \
        -ov \
        -format UDZO \
        "$DISK_IMAGE_NAME".dmg

# Clean Up artifacts from this build
rm -rf build/terminal_mac && rm -rf dist && rm -rf DMG
