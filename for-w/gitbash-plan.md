# Plan: Kitty → Windows Terminal + Git Bash + ble.sh + sixel (Windows 11 Home)

Hand this file to Claude Code on the Windows laptop. It is written for Claude Code.

---

## Start here (for Claude Code)

1. This plan is `dotfiles/for-w/gitbash-plan.md`. Everything you build goes in `dotfiles/gitbash/` (create it).
2. Already there: **`dotfiles/atuin/`**, a top-level app folder like `kitty/` and `fish/` (Mads symlinks these into `~/.config` on Arch). It holds `config.toml` and `themes/catppuccin-macchiato-lavender.toml`. Use them as they are; never copy them into `gitbash/`.
3. Image for the greeting: `dotfiles/for-w/hif.png`.
4. Look-and-feel sources: `dotfiles/kitty/` and `dotfiles/fish/`.
5. Read §0, then run **Phase 0** on the Windows laptop, write `gitbash/PHASE0_RESULTS.md`, and **stop** for Mads to review.

## 0. Rules for Claude Code (read first)

- **Do not commit, push, or touch git history.** Mads handles git himself. No `Co-Authored-By` lines.
- **Phase 0 comes first and is a gate.** Run every check in Phase 0 on the Windows laptop, write the results to `gitbash/PHASE0_RESULTS.md`, and **stop**. Mads reviews before anything gets built.
- Setup: **Windows Terminal (the "Terminal" app) running Git for Windows bash**. Do **not** use mintty (the window `git-bash.exe` opens on its own), PowerShell, WSL or MSYS2. Mads doesn't know PowerShell, so do everything from Git Bash (`winget.exe`, `explorer.exe`, `cygpath`, …).
- Source of truth for the look and feel is in the dotfiles repo: `kitty/kitty.conf`, `kitty/themes/*.conf`, `fish/config.fish`, `fish/user_variables.fish`, `fish/abbreviations.fish`, `fish/functions/*.fish`, `fish/conf.d/fish_frozen_theme.fish`.
- New files go in `dotfiles/gitbash/` (layout in §5). A deploy script installs them. Never hand-edit `$HOME` files or Windows Terminal's `settings.json` directly.

## 1. Target and key facts

| Thing | Value |
|---|---|
| OS | Windows 11 Home |
| Terminal | **Windows Terminal ≥ 1.22** (sixel support arrived in 1.22; 1.24 is current stable). Tabs, **split panes**, `settings.json` actions, OSC 133 shell integration, OSC 9;9 working directory, OSC 8 hyperlinks, `sendInput` |
| Shell | Git for Windows `bash.exe -i -l` (bash 5.x) + **ble.sh** to emulate fish |
| Startup art | **Sixel image of `for-w/hif.png`** (303×302, transparent corners) plus a `mads@hif` title next to it. Replaces fastfetch; no system-info lines |
| Config files | `~/.bashrc`, `~/.bash_profile`, `~/.blerc` (`~` = `C:\Users\<name>`), and WT `settings.json` at `$LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json` (confirm the path in Phase 0) |
| Detect WT from bash | `$WT_SESSION` is set |

**Main risk:** everything (including sixel) passes through Windows' ConPTY layer between bash and Windows Terminal. ConPTY was rewritten in WT 1.22 and passes sixel, but image sizing and the cell-size query (`CSI 16 t`) have had bugs. Phase 0 tests this first. Native `.exe` TUIs (nvim, fzf, lazygit, yazi) work natively in WT; no winpty is needed.

## 2. What your kitty setup actually resolves to

### 2.1 Effective colours
`custom-fastfetch-colors.conf` is included **after** `catppuccin-macchiato.conf` and overrides fg/bg/cursor/selection and all 16 colours. Use these values in a WT scheme named `kitty-hif`:

| kitty | value | WT scheme key |
|---|---|---|
| foreground | `#B4BEFE` | `foreground` |
| background | `#0F0F14` | `background` |
| cursor | `#EBC0EC` | `cursorColor` |
| selection_background | `#CBA6F7` | `selectionBackground` (WT has no selection-foreground; text stays as is) |
| color0 / color8 | `#0F0F14` | `black` / `brightBlack` |
| color1 / color9 | `#FAB387` | `red` / `brightRed` |
| color2 / color10 | `#CBA6F7` | `green` / `brightGreen` |
| color3 / color11 | `#EBC0EC` | `yellow` / `brightYellow` |
| color4 / color12 | `#B4BEFE` | `blue` / `brightBlue` |
| color5 / color13 | `#CBA6F7` | `purple` / `brightPurple` |
| color6 / color14 | `#EBC0EC` | `cyan` / `brightCyan` |
| color7 / color15 | `#FAB387` | `white` / `brightWhite` |

Tab bar colours (from Macchiato, for a WT `theme`): tab row `#181926`, active tab `#B7BDF8`, inactive tab `#1E2030`. Set `COLORTERM=truecolor`.

### 2.2 Prompt (from `config.fish`; starship is initialised but `fish_prompt` overrides it)
`mads ➜ <prompt_pwd> `: `mads ` in `#EBC0EC`, `➜ ` in magenta (color5, `#CBA6F7`), path in `#EBC0EC`, no newline, a single trailing space. `prompt_pwd` works like fish: `~` for home, each parent directory shortened to 1 character (`~/d/kitty`). Write it in pure bash with no subshells or external commands, because forks are slow on Windows.

### 2.3 Fish syntax colours → ble.sh faces (from `fish_frozen_theme.fish`)
| fish | colour | ble.sh target (check face names in `ble-face` output) |
|---|---|---|
| autosuggestion | `#6e738d` | `auto_complete` |
| command | `#8aadf4` | `command_builtin`, `command_file`, `command_function`, `command_alias` |
| error / status / cancel | `#ed8796` | `syntax_error`, `command_error`/`filename_warning` |
| keyword | `#ed8796` | `command_keyword` |
| quote / option | `#a6da95` | `syntax_quoted`, `syntax_quotation`, `argument_option` |
| param | `#f0c6c6` | `argument_default` |
| comment | `#8087a2` | `syntax_comment` |
| operator / redirection | `#f5bde6` | `syntax_expr`, redirection/pipe faces |
| escape | `#ee99a0` | `syntax_escape` |
| end (`;` `&`) | `#f5a97f` | `syntax_delimiter` |
| valid_path | underline | `filename_*` + underline |
| selection / search match | bg `#363a4f` | `region`, `region_match`, `region_target` |
| normal | `#cad3f5` | default |
| pager completion / description / prefix | `#cad3f5` / `#6e738d` / `#f5bde6` | `menu_*` faces if present |

### 2.4 Key bindings in fish
**Decided: normal (emacs-style) line editing, no vi mode.** Mads never uses vi mode, even though `fish_user_key_bindings` turns it on. Keep the bindings he does use: `fzf_configure_bindings` (Ctrl+Alt+F for directories, Ctrl+H for history, Ctrl+Alt+V for variables) and Alt+Z → `zi`.

**↑ opens atuin.** `atuin init fish` binds the up arrow (and Ctrl+R) to atuin's full-screen history search: a list of past commands with duration and "Nd ago", newest at the bottom, a `[ GLOBAL ]` filter box, Enter runs the highlighted command, and → puts the highlighted command on the prompt for editing. Mads uses this every day, so it must work the same on Windows.

**Atuin config is already in the repo** at `dotfiles/atuin/`, Mads's real `~/.config/atuin/` (symlinked from the repo on Arch with `scripts/link-atuin.sh`):
- `config.toml`: `search_mode = "fuzzy"`, `style = "full"`, `inline_height = 40`, `enter_accept = true`, `keymap_mode = "vim-insert"` (atuin's own search box only; Esc first switches the box to atuin's normal mode, a second Esc closes it, same as on Arch), `auto_sync = true`, `sync_frequency = "10m"`, `[sync] records = true`, theme `catppuccin-macchiato-lavender`.
- `themes/catppuccin-macchiato-lavender.toml`: the colour theme in Mads's screenshot.
- Also in that folder: `.github/` (README and screenshots) and `atuin-receipt.json` (Linux install receipt, gitignored). Neither is needed on Windows.
- On Windows, `deploy.sh` makes `~/.config/atuin` (= `$XDG_CONFIG_HOME/atuin`; confirm with `atuin info`) point at `dotfiles/atuin/`: a real link if C14 shows symlinks work, otherwise a copy of `config.toml` + `themes/`. Don't change any values; if Windows needs something different, put it in a separate override, not in `dotfiles/atuin/config.toml` (Arch uses the same file).

---

## 3. Parity matrix

✅ = same behaviour, 🟡 = close but different, ❌ = not possible in Windows Terminal

### Terminal (kitty.conf → WT `settings.json`)
| kitty | Plan | Status |
|---|---|---|
| `font_family JetBrainsMono Nerd Font` | `profiles.defaults.font.face` (install the font with winget) | ✅ |
| `font_size 11.5` | `font.size: 11.5` | ✅ |
| `modify_font cell_height 122%` | `font.cellHeight`: WT's default is `"1.2"` (× font size); kitty's 122 % of natural height works out to about `"1.6"`. Tune by eye against kitty | 🟡 |
| `window_padding_width 12` (pt) | `padding: "16"` (WT uses DIPs; 12 pt ≈ 16) | ✅ |
| theme | `schemes` + `colorScheme: "kitty-hif"` | ✅ |
| `copy_on_select yes` | `copyOnSelect: true` | ✅ |
| `paste_strict_mode no` | turn off the multi-line/large paste warnings | ✅ |
| `allow_hyperlinks yes` | OSC 8 supported; clicks open in the Windows default app | 🟡 |
| `shell_integration` + Ctrl+Shift+Z `scroll_to_prompt` | OSC 133 A/B/C/D in the prompt, `autoMarkPrompts`, `showMarksOnScrollbar`, action `scrollToMark` `previous` | ✅ |
| `confirm_os_window_close 0` | `confirmCloseAllTabs: false` | ✅ |
| `load_config_file` | WT reloads `settings.json` automatically when it's saved | ✅ |
| `enabled_layouts *` + splits | WT panes (`splitPane`), `split: "auto"` | ✅ |
| `next_layout` (Ctrl+Shift+L) | `togglePaneZoom` (like kitty's stack layout) or `toggleSplitOrientation`. WT has no layout cycling | 🟡 |
| `window_border_width 1pt`, active/inactive border colours | WT draws its own pane border (accent colour). Check whether a theme can recolour it | 🟡 |
| tabs: `tab_bar_edge bottom`, powerline slanted, `tab_fade`, separator | WT `theme` with Macchiato tab colours, `showCloseButton: never`. The tab row is **top only**, with rounded WT tabs | 🟡 |
| `tab_bar_min_tabs 2` | `alwaysShowTabs: false` (only takes effect with `showTabsInTitlebar: false`; check this) | 🟡 |
| `tab_title_template` (30-char truncation) | bash sets the title via OSC 0 with the same truncation; `tabWidthMode: "titleLength"` | ✅ |
| `active_tab_font_style bold-italic` | n/a | ❌ |
| `tab_switch_strategy previous` | n/a; set `tabSwitcherMode: "disabled"` so Ctrl+Tab switches directly like kitty | 🟡 |
| `cursor_trail` | WT pixel shaders get no cursor position | ❌ |
| `allow_remote_control`, `listen_on` | n/a (`wt.exe` can open tabs and panes from the CLI, which is the only partial equivalent) | ❌ |
| `kitty_scrollback_nvim` (Ctrl+Shift+H / G) | H → `exportBuffer` to `%TEMP%\wt-scrollback.txt`, then a shell command `sb` opens it in nvim. G → WT `selectOutput` (previous command output) + copy, then `sb -c` opens the clipboard in nvim. Two steps instead of one | 🟡 |
| `open-actions.conf` | links open with the Windows default app | 🟡 |
| `alt+diaeresis → ~` (X11 Swedish fix) | probably not needed on Windows (AltGr + ¨). Check in Phase 0 | ✅? |
| `editor nvim`, cursor block | `EDITOR=nvim`; `cursorShape: "filledBox"`; `bellStyle: "none"` | ✅ |

### Key map (kitty_mod = Ctrl+Shift; the macOS-only `cmd+`/`opt+` bindings are dropped)
Use the current WT format (`actions` with `id`s plus a separate `keybindings` list). **Unbind conflicting WT defaults**: Ctrl+Shift+F (find), Ctrl+Shift+, (open settings.json), Ctrl+Shift+W, Ctrl+Shift+D, and any other Ctrl+Shift chord that collides.

| Keys | kitty action | WT action |
|---|---|---|
| C+S+Up / Down | scroll line | `scrollUp` / `scrollDown` |
| C+S+K / J | scroll page | `scrollUpPage` / `scrollDownPage` |
| C+S+Home / End | top / bottom | `scrollToTop` / `scrollToBottom` |
| C+S+Z | previous prompt | `scrollToMark` `{direction: previous}` |
| C+S+Enter | new window (split) | `splitPane {split: auto}` (profile start dir) |
| C+Alt+Enter | new window, same cwd | `splitPane {split: auto, splitMode: duplicate}` (needs OSC 9;9) |
| C+S+] / [ | next / prev window | `moveFocus {direction: nextInOrder / previousInOrder}` |
| C+S+F / B | move window | `swapPane {direction: nextInOrder / previousInOrder}` (check that these directions are valid) |
| C+S+L | next layout | `togglePaneZoom` |
| C+S+T | new tab | `newTab` |
| C+S+Right, Ctrl+Tab / C+S+Left, C+S+Tab | next / prev tab | `nextTab` / `prevTab` |
| C+S+. / , | move tab | `moveTab {direction: forward / backward}` |
| C+S+Q | close tab | `closeTab` |
| C+S+N | set tab title | `openTabRenamer` |
| C+S+= / + / numpad+ , C+S+- / numpad- , C+S+Backspace | font ±1 / reset | `adjustFontSize {delta: 1 / -1}`, `resetFontSize` |
| C+S+E | open cwd in file manager | `sendInput "\u001b[91~"` → ble.sh widget runs `explorer.exe .` |
| C+S+U | open cwd in VSCodium | `sendInput "\u001b[92~"` → `codium .` |
| C+S+Y | yazi overlay | `sendInput "\u001b[93~"` → runs `y` full-screen in the pane |
| C+S+H / G | scrollback in nvim | see matrix |
| C+S+C / V | copy / paste | `copy` / `paste` |

The ble.sh widgets must keep whatever is already typed on the command line.

### Shell (fish → bash + ble.sh)
| fish feature | Plan | Status |
|---|---|---|
| Autosuggestions | ble.sh auto-complete; accept with → / End / C-f | ✅ |
| Syntax highlighting | ble.sh faces from §2.3 | ✅ |
| `abbr g=git`, `d=docker` | `ble-sabbrev g=git d=docker` | ✅ |
| Line editing | ble.sh default (emacs-style) keymap: arrows, Home/End, Ctrl+A/E/W/U/K, Alt+B/F. **No vi mode** | ✅ |
| ↑ / Ctrl+R → atuin full-screen search | atuin (`winget install -e --id Atuinsh.Atuin`), `eval "$(atuin init bash)"` **after** sourcing ble.sh (atuin detects ble.sh). ↓ stays normal | ✅ if C12 passes |
| fzf.fish (C-A-F, C-H, C-A-V) | ble.sh widgets around fzf | ✅ (check that Ctrl+H is distinct from Backspace) |
| zoxide + `c` + Alt+Z `zi` | `eval "$(zoxide init bash)"` | ✅ |
| atuin config/theme | **already in `dotfiles/atuin/`** (shared with Arch); `deploy.sh` links or copies it to the Windows atuin config dir | ✅ |
| atuin history | Mads has `auto_sync = true`, so his Arch history can sync over. Mads runs `atuin key` on Arch, then on Windows runs `atuin login -u <username>` (pastes the key when asked) and `atuin sync`. **Never store the key or password in the dotfiles** | ✅ |
| puffer-fish (`...`, `!!`, `!$`) | bash history expansion + `...` → `../..` hook | 🟡 |
| autopair | ble.sh widget/contrib if one exists, otherwise skip | 🟡 |
| done (long-command notify) | optional | 🟡 |
| abbreviation-tips, sudope | skip | ❌ |
| `fish_greeting` → fastfetch with Huey + system specs | **Sixel `hif.png` + `mads@hif` only**, no spec lines (Phase 6) | ✅ (by choice) |
| Env vars (XDG, EDITOR/VISUAL, PAGER=bat, BAT_THEME, FZF_DEFAULT_OPTS, LANG, GPG_TTY) | port; in FZF opts swap `wl-copy` for `> /dev/clipboard` | ✅ |
| `LS_COLORS` via vivid | vivid for Windows if winget has it, otherwise generate on Arch and commit | ✅ |
| gnome-keyring, Linux PATH entries | drop | — |
| `local.fish` secrets | `~/.bashrc.local` (gitignored) | ✅ |

### Fish functions → bash
| Function | Port |
|---|---|
| `ls l lh lm lt lth ldh lsh` (eza, `--hyperlink`) | same flags; fall back to `missing_package` |
| `cat` / `catp` (bat, Catppuccin-Macchiato, only when stdout is a TTY) | same; install the theme into `$(bat --config-dir)/themes` and run `bat cache --build` |
| `v`, `vc`, `lg`, `lzd`, `y` (yazi cd-on-exit), `rga-fzf`, `rules` | same logic |
| `backup`, `restore`, `copy`, `cl`, `c` | same |
| `clone-cd`, `clean-unzip` | depend on helpers that are **missing from the dotfiles** (`default`, `repo-from-url`, `file-exists`, `is-clean-zip`, `trim-right`); rewrite them self-contained |
| `i` / `u` / `up` / `upall` | `winget install -e --id` / `winget uninstall` / `winget upgrade --all` / topgrade |
| `missing_package` | ask, then `winget install` |
| `bin` | copy into `~/.local/bin` |
| `svn`, `yarn`, `wget` XDG wrappers | only if the tool exists |
| `wts`, `??`, `gh?`, `git?` (github-copilot-cli) | that CLI is deprecated; port only if Mads asks |
| AWS EC2 aliases | port as aliases. Note: `config.fish` defines `basic_linux`/`stopbl` twice with different hosts (the later alias wins) |
| `clean`, `dots`, `love`, `mail`, `notes` | drop (Linux-only) |

---

## 4. Phases

### Phase 0: Feasibility checks (GATE: write `gitbash/PHASE0_RESULTS.md` and stop)

Record PASS/FAIL, versions and notes for each check. Use throwaway files only. Back up `settings.json` before any temporary change and restore it afterwards.

| # | Check | How | Must pass? |
|---|---|---|---|
| C0 | **Which host** | In the Git Bash tab Mads normally uses: `echo "WT_SESSION=$WT_SESSION TERM=$TERM TERM_PROGRAM=$TERM_PROGRAM"`. `WT_SESSION` must be set. Record the Git Bash profile's commandline (`bin\bash.exe -i -l`, not `git-bash.exe`) | **YES** |
| C1 | Versions | WT version (Settings → About, or `winget.exe list Microsoft.WindowsTerminal`) ≥ 1.22; `git --version`; `$BASH_VERSION`; `winget.exe --version`; confirm the `settings.json` path | **YES** (WT ≥ 1.22) |
| C2 | **Sixel through ConPTY** | No-deps test: `printf '\ePq#0;2;100;0;0#0~~~~~~~~~~-~~~~~~~~~~\e\\'` → a red block. Then install ImageMagick via winget (confirm the ID with `winget search`) and run `magick "$HOME/dotfiles/for-w/hif.png" -background '#0F0F14' -flatten sixel:-`. Check that the image appears, that the cursor ends up below it, and that it survives scrolling, a new tab and a window resize | **YES** |
| C3 | Image sizing | `printf '\e[16t'; IFS=';' read -rs -t1 -d t _ ch cw; echo "${cw}x${ch}"`. WT is expected to use a fixed virtual cell of about 10×20 px for sixel no matter the font size. Confirm by drawing a 320×320 image and counting the cells it covers (~32×16), at two font sizes | yes |
| C4 | Font | Install JetBrainsMono Nerd Font (winget, or the nerd-fonts zip → right-click → Install). Check that `➜`, ``, eza icons, bold and italic render. Check that `size: 11.5` is accepted and that `cellHeight: "1.6"` looks right next to kitty | yes |
| C5 | **ble.sh** | Check for `make` and `xz`. Download `ble-nightly.tar.xz` from the GitHub releases and do a trial run with `source …/ble.sh`. Measure `time bash -ic exit` with and without it. Test autosuggestions, highlighting, pasting a long line and typing latency **in WT** (ConPTY adds latency) | **YES** |
| C6 | Native TUIs | Install nvim, fzf, fd, ripgrep, bat, eza, zoxide, yazi and lazygit via winget. For each, check launch, arrows, Esc, colours, resize and quit. Check that yazi image previews work (sixel) | **YES** for nvim + fzf |
| C7 | fzf preview through bash | `fzf --preview 'bat --color=always {}'`. If the preview runs through cmd.exe, test `--with-shell 'bash -c'` | yes |
| C8 | WT actions | In a temporary settings copy: `splitPane` duplicate keeps the cwd (with OSC 9;9 emitted, see Phase 4), `swapPane` nextInOrder, `moveTab`, `openTabRenamer`, `scrollToMark` with OSC 133 marks, `exportBuffer`, `selectOutput`, and a `sendInput "\u001b[91~"` that reaches bash (`cat -v` shows `^[[91~`). Check that every Ctrl+Shift chord in the key map can be rebound | yes |
| C9 | ble.sh + OSC 133 | Check that ble.sh keeps the OSC 133 / OSC 9;9 sequences intact (PS0/PS1/PROMPT_COMMAND) and that marks land on the right lines | yes |
| C10 | Clipboard + keyboard | `echo hi > /dev/clipboard; cat /dev/clipboard`. On the Swedish layout, check `~ | @ { } [ ] \` with AltGr; check Ctrl+H vs Backspace with `cat -v` | yes |
| C11 | Tab bar | Do `alwaysShowTabs: false` + `showTabsInTitlebar: false` hide the tab row when only one tab is open? Can a theme recolour the pane border? | no |
| C12 | **atuin** | Install with winget. With ble.sh loaded first, then `eval "$(atuin init bash)"`: ↑ opens the full-screen list, ↓ moves, typing filters, Enter runs, → puts the command on the prompt, Esc behaves like on Arch (vim-insert), new commands show up in the list with duration and time. Atuin's Windows support is community-maintained, so test it properly. **If it fails**, build a fallback: ↑ opens a full-screen `fzf` over history (newest at the bottom, same colours), Enter runs, → inserts | **YES** (atuin or fallback) |
| C12b | Optional tools | vivid, topgrade, VSCodium (`codium`), mise, jq | no |
| C14 | Symlinks | Can Git Bash make real links into the repo? Test `MSYS=winsymlinks:nativestrict ln -s` (needs Windows Developer Mode, available on Home). Otherwise `deploy.sh` copies. Mads uses symlinks on Arch, so prefer them | no |
| C13 | Startup cost | `time` for: plain bash, + ble.sh, + zoxide init, + cached sixel greeting. Count the forks in the prompt (OSC 9;9 needs Windows paths; `cygpath` is a fork per prompt) | report |

**Go/No-Go:** C0, C1, C2, C5, C6 and C12 (atuin or its fallback) must pass. If C5 is too slow, report the numbers and propose tuning (`bleopt complete_auto_delay`, fewer features) before continuing.

### Phase 1: Layout + install script
- Create `dotfiles/gitbash/` (§5).
- `install.sh`: idempotent `winget.exe install -e --id …` for: JetBrainsMono Nerd Font, ImageMagick, neovim, fzf, fd, ripgrep, bat, eza, zoxide, yazi, lazygit, jq, atuin, plus the optional tools that passed C12b. Download ble.sh nightly into `~/.local/share/blesh`. Print a summary.
- `deploy.sh`: copies the bash files into `$HOME` (with `*.bak.<date>` backups) and **merges** `wt/settings.patch.json` into WT `settings.json` with `jq` (backup first, keep WT's generated profiles). Safe to re-run.

### Phase 2: Windows Terminal (`gitbash/wt/settings.patch.json`)
- Git Bash profile with a fixed GUID: commandline `%PROGRAMFILES%\Git\bin\bash.exe -i -l` (use the path found in C0), `startingDirectory: %USERPROFILE%`, set as `defaultProfile`.
- Profile/defaults: font (face, 11.5, cellHeight), `padding`, `colorScheme`, `cursorShape: filledBox`, `bellStyle: none`, `autoMarkPrompts`, `showMarksOnScrollbar`, no background opacity.
- Globals: `copyOnSelect`, `confirmCloseAllTabs: false`, paste warnings off, `tabWidthMode: titleLength`, `tabSwitcherMode: disabled`, `alwaysShowTabs`/`showTabsInTitlebar` per C11, `theme: "kitty-hif"`.
- `schemes` (§2.1), `themes` (tab colours), `actions` + `keybindings` (§3 key map, conflicting defaults unbound).
- Comment the kitty origin of each block in a sidecar `wt/README.md`, since JSON has no comments.

### Phase 3: bash core (`bashrc` + `bash/*.sh`)
Order matters:
1. return if non-interactive
2. env
3. PATH (only directories that exist)
4. **greeting** (before ble.sh, Phase 6)
5. `source ble.sh --attach=none`
6. prompt / title / shell integration
7. aliases and functions
8. zoxide, fzf
9. `~/.bashrc.local`
10. `ble-attach` last

`bash_profile` only sources `bashrc`. Keep forks at startup to a minimum.

### Phase 4: Prompt, titles, shell integration
- PS1 per §2.2 with a pure-bash `prompt_pwd`, with escapes wrapped in `\[ \]`.
- OSC 133: `D;$?` + `A` before the prompt, `B` after it, `C` in PS0.
- OSC 9;9 with the Windows path of `$PWD`. **Avoid a `cygpath` fork on every prompt**: convert `/c/...` → `C:\...` in pure bash, and call `cygpath -w` only for other paths and only when `$PWD` has changed.
- Tab title (OSC 0) = cwd or the running command, truncated to 30 chars + `…`.

### Phase 5: ble.sh (`blerc`)
- Faces from §2.3; auto-complete delay tuned from C5.
- Default emacs-style keymap (no vi mode).
- `ble-sabbrev g=git d=docker`, `...` expansion.
- fzf widgets: C-A-F, C-H, C-A-V, M-z → `zi`.
- Widgets for `CSI 91~` / `92~` / `93~` (explorer / codium / yazi).
- atuin: `eval "$(atuin init bash)"` after `source ble.sh --attach=none` and before `ble-attach`; ↑ and Ctrl+R → atuin, ↓ normal. `deploy.sh` links (or copies) `dotfiles/atuin/` → `~/.config/atuin` (with a backup of anything already there).

### Phase 6: Sixel greeting (replaces fastfetch)
Shown at the start of every new interactive shell (tab or pane). Layout follows the top of `fastfetch/config_kitty.jsonc`, but **only the title line**:

```
┌──────────────┐
│              │    mads@hif
│   hif.png    │
│   (sixel)    │
│              │
└──────────────┘
mads ➜ ~ 
```

1. **Image:** `dotfiles/for-w/hif.png` (303×302 RGBA, transparent corners). Quote the path in scripts. Show it at native size (no upscaling). With WT's ~10×20 px sixel cell that is about 31×16 cells, close to kitty's 32×16 box. If C3 shows a different cell size, fit inside 32×16 cells and keep the aspect ratio.
2. **Title:** `mads@hif` to the right of the image on its top line, after 4 cells of padding (fastfetch `padding.right: 4`). Colours: `mads` `#EBC0EC`, `@` white, `hif` `#CBA6F7`. `hif` is a **fixed string**, not the Windows hostname. Nothing else: no separator line, OS, kernel, uptime, packages, shell, terminal, CPU, GPU, memory or disk.
3. Run only when `$WT_SESSION` is set and the shell is interactive.
4. Work out the pixel size from C3. If `CSI 16 t` works, query it **before ble.sh attaches** (1 s timeout); otherwise use the value found in C3, which `~/.bashrc.local` can override.
5. Cache file `~/.cache/hif/hif-<W>x<H>.six`. If it's missing, render once: `magick "<dotfiles>/for-w/hif.png" -background '#0F0F14' -flatten [-resize <W>x<H>] sixel:<file>`. Flattening the transparent corners onto the terminal background makes the badge look like it floats on the terminal, like Huey did in kitty.
6. Print order: save the cursor position, `cat` the cached sixel, then go back to the image's top row, move right by image width + 4 cells, and print the title. Finally put the cursor on the line below the image (count the rows from the image height ÷ cell height). Use bash builtins only.
7. Fallback if ImageMagick is missing: a pre-rendered `.six` in `gitbash/assets/` (made on Arch with `img2sixel` or `chafa -f sixel`).

### Phase 7: Functions
Port everything in the "Fish functions → bash" table into `bash/functions.sh`, plus `sb` (open the exported scrollback or the clipboard in nvim).

### Phase 8: Acceptance test (side by side with kitty) → `gitbash/ACCEPTANCE.md`
- [ ] New tab: `hif.png` sixel at the right size with `mads@hif` to its right (no other text), transparent corners blend into the background, prompt below, colours match kitty
- [ ] Prompt text and colours match; the path is shortened like fish
- [ ] `git sta` shows a grey autosuggestion; → accepts it
- [ ] Highlighting: valid command blue, unknown command red, strings and options green
- [ ] `g␠` expands to `git `
- [ ] ↑ opens atuin's full-screen history with the lavender Catppuccin colours, like on Arch; fuzzy search, Enter runs, → puts the command on the prompt
- [ ] After `atuin login` + `atuin sync`, commands from Arch show up in the list
- [ ] Ctrl+A/E, Ctrl+W, Alt+B/F work; Esc does nothing odd (no vi mode)
- [ ] Ctrl+Alt+F, Ctrl+H, Ctrl+Alt+V and Alt+Z open fzf pickers
- [ ] Ctrl+Shift+Enter splits; Ctrl+Alt+Enter splits in the same folder; Ctrl+Shift+] / [ move focus; Ctrl+Shift+F / B swap panes
- [ ] Ctrl+Shift+T new tab; Ctrl+Tab / Ctrl+Shift+←→ switch; Ctrl+Shift+, / . move; Ctrl+Shift+Q close; Ctrl+Shift+N rename
- [ ] Ctrl+Shift+Z jumps to the previous prompt; marks show on the scrollbar
- [ ] Ctrl+Shift+= / - / Backspace change the font size
- [ ] Ctrl+Shift+E / U / Y open Explorer / VSCodium / yazi in the cwd without losing the typed line
- [ ] Selecting text copies it; Ctrl+Shift+C/V work
- [ ] `l`, `lt`, `cat file`, `v`, `lg`, `y`, `c <dir>` work
- [ ] Startup time recorded (target: under about 1 s; report the actual time)

## 5. File layout

```
dotfiles/gitbash/
├─ README.md            # what this is, install/deploy, known gaps
├─ PHASE0_RESULTS.md    # Phase 0
├─ ACCEPTANCE.md        # Phase 8
├─ install.sh           # winget installs + ble.sh download
├─ deploy.sh            # copies bash files, merges WT settings with jq, makes backups
├─ wt/
│  ├─ settings.patch.json   # profile, scheme, theme, actions, keybindings
│  └─ README.md             # kitty → WT mapping notes
├─ bash_profile         # → ~/.bash_profile
├─ bashrc               # → ~/.bashrc (loader)
├─ blerc                # → ~/.blerc
├─ bash/
│  ├─ env.sh  path.sh  greeting.sh  prompt.sh  keys.sh  fzf.sh  aliases.sh  functions.sh
├─ local.sh.example     # → ~/.bashrc.local (real file gitignored)
└─ assets/              # fallback .six files (hif.png is read from ../for-w/)
```
Shared app folders stay top-level, as on Arch (`dotfiles/atuin/`, `dotfiles/kitty/`, …); only Windows-specific files go in `gitbash/`. Add `gitbash/local.sh` to `.gitignore`; Mads commits it himself.

## 6. Decisions (all made)

- **Keys:** normal emacs-style editing, no vi mode.
- **History:** atuin on ↑ / Ctrl+R, the same as on Arch (fzf fallback only if atuin fails in C12).
- **Greeting:** `hif.png` + `mads@hif` only.

**Already prepared in the repo:** `dotfiles/atuin/` (atuin config + theme, a top-level app folder shared with Arch) and this plan as `for-w/gitbash-plan.md`. **Mads does by hand:** `atuin key` on Arch, then `atuin login` + `atuin sync` on Windows after install (secrets stay out of the repo).

## 7. Known gaps (Windows Terminal cannot match these)
Cursor trail · tab bar at the bottom with powerline slanted tabs, fade and a bold-italic active tab (WT tabs are top-only and rounded, recoloured to match) · kitty's layout cycling (only zoom/orientation toggles) · kitty remote control · one-key kitty-scrollback.nvim (becomes two steps) · custom open-actions.
