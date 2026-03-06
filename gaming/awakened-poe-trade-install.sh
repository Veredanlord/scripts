#!/bin/bash

BASE=$HOME/Software/gaming
REPO=$BASE/awakened-poe-trade

cd "$BASE"

if [ ! -d awakened-poe-trade ]; then
	git clone https://github.com/SnosMe/awakened-poe-trade.git
else
	cd awakened-poe-trade && git pull && cd "$BASE"
fi

cd "$REPO/renderer"
npm install && npm run make-index-files && npm run build

cd "$REPO/main"
npm install && npm run build && npm run package

# Create .desktop entry
APPIMAGE=$(find "$REPO/main/dist" -name "*.AppImage" | head -1)
ICON=$REPO/main/build/icons/256x256.png
DESKTOP=$HOME/.local/share/applications/awakened-poe-trade.desktop

cat > "$DESKTOP" <<EOF
[Desktop Entry]
Name=Awakened PoE Trade
Exec=$APPIMAGE --ozone-platform=x11
Icon=$ICON
Type=Application
Categories=Game;
EOF

update-desktop-database "$HOME/.local/share/applications/"

echo "Done, happy farming !"

