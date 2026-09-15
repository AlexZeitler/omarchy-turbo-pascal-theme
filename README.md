# omarchy-turbo-pascal-theme

![Preview](assets/preview.png)

A dark Omarchy theme built from Borland's Turbo Pascal: the blue editor
field, the grey menu bar, the cyan frame.

Turbo Pascal was my first language on the PC, after assembler and BASIC on a
C64 and CP/M on a CPC 464. I loved Turbo Pascal, and I still know exactly
what that screen looked like. Hence this theme.

## Installation

```bash
omarchy theme install https://github.com/AlexZeitler/omarchy-turbo-pascal-theme
```

## Screenshots

Click a thumbnail to open the wallpaper in full resolution.

### Hejlsberg and Wirth

[![Anders Hejlsberg and Niklaus Wirth](assets/01-hejlsberg-and-wirth-thumb.jpg)](backgrounds/01-hejlsberg-and-wirth.png)

### Anders Hejlsberg

[![Anders Hejlsberg](assets/02-hejlsberg-thumb.jpg)](backgrounds/02-hejlsberg.png)

### Niklaus Wirth

[![Niklaus Wirth](assets/03-wirth-thumb.jpg)](backgrounds/03-wirth.png)

## What Hejlsberg and Wirth built

Anders Hejlsberg wrote Turbo Pascal in assembly, and version 3.0 shipped as a
single 39 KB executable: editor, single-pass compiler and runtime, all inside
those 39 kilobytes. No linker, no object files, nothing written to disk. It
compiled straight into memory and ran, and an error put the cursor on the
line. It cost $49.95 when a compiler cost several hundred. Then Delphi. Then
C#. Then TypeScript. Four times he built the thing a generation wrote its
code in, and the thread from that one floppy runs straight into what most of
us typed this morning.

Niklaus Wirth designed the language, and then kept building: Modula-2,
Oberon, and with Oberon a complete operating system with its compiler and
window system, small enough to read end to end. He designed the workstation
it ran on as well. Turing Award in 1984. He died in January 2024.

## Palette

| Role       | Colour    | Source in the IDE          |
|------------|-----------|----------------------------|
| Background | `#010378` | the editor field           |
| Surfaces   | `#152B92` | selection, cursor line     |
| Foreground | `#FFFF55` | the editor text            |
| Emphasis   | `#FFFFFF` | reserved words             |
| Muted      | `#AAAAAA` | comments, the menu bar     |
| Accent     | `#0BDFEA` | window frames, scrollbars  |
| Highlight  | `#F7EE0B` | the selection bar          |

The active window border is a gradient from the frame cyan to its lighter
step, set through `hyprland_active_border` in `colors.toml`.

## GTK

Omarchy copies `gtk.css` into `~/.local/state/omarchy/current/theme` but never
deploys it. GTK reads `~/.config/gtk-3.0/gtk.css` and
`~/.config/gtk-4.0/gtk.css` and nothing else, so out of the box the GTK
colours never reach Nautilus or the GTK file dialogs. Those windows keep
whatever background they had under an earlier theme.

Link the hook once:

```bash
mkdir -p ~/.config/omarchy/hooks/theme-set.d
ln -s ~/.config/omarchy/themes/turbo-pascal/hooks/gtk \
  ~/.config/omarchy/hooks/theme-set.d/gtk
```

From then on every theme switch writes the GTK colours of whichever theme you
picked, not just this one. The hook only touches the section between its own
markers, so anything you wrote into those files yourself survives. Switching
to a theme without a `gtk.css` removes the section again.

Only one hook can be linked under the name `gtk`. If a link is already there,
check where it points before replacing it:

```bash
readlink ~/.config/omarchy/hooks/theme-set.d/gtk
```

### Removing the hook

No theme shipped with Omarchy carries a `gtk.css`. Switching to one of them
therefore removes the section on its own, and GTK falls back to whatever was
in the file before.

To drop the hook entirely, remove the symlink and run it once by hand:

```bash
rm ~/.config/omarchy/hooks/theme-set.d/gtk
~/.config/omarchy/themes/turbo-pascal/hooks/gtk --remove
```

## cliamp

`cliamp` reads its own directory, `~/.config/cliamp/themes/*.toml`, where a
user theme overrides a built-in one of the same name. Nothing carries a file
from an Omarchy theme to there, so this repository ships a hook that does.

```bash
ln -s ~/.config/omarchy/themes/turbo-pascal/hooks/cliamp \
  ~/.config/omarchy/hooks/theme-set.d/cliamp
```

It copies `cliamp.toml` under the name of the current Omarchy theme and
selects it. A running `cliamp` writes its own configuration back when it
exits and would undo that, so the hook tells the running instance directly.

### Removing the hook

Before its first write the hook backs up `~/.config/cliamp/config.toml`. A
theme without a `cliamp.toml` restores that backup, so switching to any other
theme undoes the selection on its own.

To drop the hook entirely, remove the symlink and run it once by hand:

```bash
rm ~/.config/omarchy/hooks/theme-set.d/cliamp
~/.config/omarchy/themes/turbo-pascal/hooks/cliamp --remove
```

The palette file stays behind under `~/.config/cliamp/themes/`, as one inert
entry in `cliamp theme list`.

## fastfetch

`fastfetch.json` names the colour of the logo. Omarchy has no fastfetch
target, so this repository ships a hook that carries it over.

`fastfetch` falls back to `/etc/fastfetch/config.jsonc` when no user file
exists, and that file belongs to the package. A hook must not write there, so
a user configuration has to be in place first:

```bash
mkdir -p ~/.config/fastfetch
cp /etc/fastfetch/config.jsonc ~/.config/fastfetch/
ln -s ~/.config/omarchy/themes/turbo-pascal/hooks/fastfetch \
  ~/.config/omarchy/hooks/theme-set.d/fastfetch
```

The hook writes `logo.color` and nothing else. The `keyColor` fields of the
individual modules stay untouched, those are your layout. It needs `jq`.

Only one hook can be linked under the name `fastfetch`, and it then applies
to every theme, not only to this one. If a link is already there, check where
it points before replacing it:

```bash
readlink ~/.config/omarchy/hooks/theme-set.d/fastfetch
```

Left on its default the logo is painted in green, a slot that has to stay
readable against red in `git diff` and is therefore bright and saturated. As
the largest block of colour in the window it drowns everything else out.

### Removing the hook

Before its first write the hook backs up `~/.config/fastfetch/config.jsonc`.
A theme without a `fastfetch.json` restores that backup, so switching to any
other theme undoes the colour on its own.

To drop the hook entirely, remove the symlink and run it once by hand:

```bash
rm ~/.config/omarchy/hooks/theme-set.d/fastfetch
~/.config/omarchy/themes/turbo-pascal/hooks/fastfetch --remove
```

## License

MIT
