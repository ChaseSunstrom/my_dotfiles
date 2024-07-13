#!/bin/bash

# Generate colors using Pywal
wal -i /path/to/your/image.jpg

# Extract colors from Pywal and export them
bg_color=$(sed -n '1p' ~/.cache/wal/colors)
text_color=$(sed -n '5p' ~/.cache/wal/colors)

# Write colors to a temporary file
cat <<EOF > ~/.config/i3/wal_colors
set \$bg_color $bg_color
set \$text_color $text_color
client.focused $bg_color $text_color $bg_color $text_color
client.unfocused $bg_color $text_color $bg_color $text_color
EOF

