#! /bin/sh

IMG="$(cat ~/.cache/wal/wal)"
TMP_CONFIG="$HOME/.config/hypr/hyprpaper.conf"
cat > "$TMP_CONFIG" <<EOF
preload= $IMG
wallpaper = , $IMG
splash= true
EOF

# Run hyprpaper with the generated config
hyprpaper -c "$TMP_CONFIG"
