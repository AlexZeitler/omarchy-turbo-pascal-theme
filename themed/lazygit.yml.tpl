# Omarchy generates this file from the current theme's colors.toml. lazygit
# reads it as a second config file, on top of the user's own, through
# LG_CONFIG_FILE.
#
# lazygit keeps each line's own foreground on the selected row. Its default
# bar is the ANSI blue slot, which a dark theme keeps light for directory
# names, so the row ends up light text on a light bar. The lifted background
# stays dark enough for any foreground a dark theme draws there.
gui:
  theme:
    selectedLineBgColor:
      - "{{ lighter_background }}"
