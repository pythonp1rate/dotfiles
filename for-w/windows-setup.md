# Cursor setup: Arch → Windows 11

Snapshot of the Cursor setup on `archlinux` (13 Nov 2026), plus what you need to copy it to Windows. **Database tooling is left out on purpose** (no Postgres/SQLTools extensions, settings or connections).

**Short version:** it's a mix. 30 of the 44 extensions came over from your VS Code import. The other 14 you added in Cursor yourself (mostly themes and icon packs, plus Tailwind, React snippets, Colab and Hugging Face). You have no MCP servers, no user rules, no custom snippets and no disabled extensions, so the extensions, `settings.json` and `keybindings.json` are the whole setup. Not counting the 3 database extensions, there are 41 to install.

---

## 1. Where things live

| | Arch (this laptop) | Windows 11 |
|---|---|---|
| Settings + keybindings | `~/.config/Cursor/User/` | `%APPDATA%\Cursor\User\` |
| Extensions | `~/.cursor/extensions/` | `%USERPROFILE%\.cursor\extensions\` |
| MCP config | `~/.cursor/mcp.json` (empty) | `%USERPROFILE%\.cursor\mcp.json` |

---

## 2. Install the extensions (PowerShell)

Install Cursor on Windows first, then open it once. Then run this in PowerShell. Cursor picks the right Windows build for each extension automatically, so the `linux-x64` versions on Arch don't matter.

```powershell
$exts = @(
  # --- Python / data / notebooks ---
  "ms-python.python",
  "ms-python.debugpy",
  "ms-python.vscode-python-envs",
  "anysphere.cursorpyright",          # Cursor's Pylance replacement
  "charliermarsh.ruff",
  "ms-toolsai.jupyter",
  "ms-toolsai.jupyter-keymap",
  "ms-toolsai.jupyter-renderers",
  "ms-toolsai.vscode-jupyter-cell-tags",
  "ms-toolsai.vscode-jupyter-slideshow",
  "google.colab",
  "huggingface.huggingface-vscode",
  "mechatroner.rainbow-csv",

  # --- Docker / remote ---
  "docker.docker",
  "ms-azuretools.vscode-docker",
  "ms-azuretools.vscode-containers",
  "anysphere.remote-ssh",
  "anysphere.remote-containers",

  # --- Web / frontend ---
  "esbenp.prettier-vscode",
  "bradlc.vscode-tailwindcss",
  "dsznajder.es7-react-js-snippets",
  "ecmel.vscode-html-css",
  "ms-vscode.live-server",
  "ritwickdey.liveserver",

  # --- General tooling ---
  "eamodio.gitlens",
  "gruntfuggly.todo-tree",
  "oderwat.indent-rainbow",
  "bierner.markdown-mermaid",
  "tomoki1207.pdf",
  "jakobhoeg.vscode-pokemon",

  # --- Color themes (active: Ayu Mirage Bordered) ---
  "teabyii.ayu",
  "monokai.theme-monokai-pro-vscode",  # also gives you the active icon theme
  "catppuccin.catppuccin-vsc",
  "jdinhlife.gruvbox",
  "enkia.tokyo-night",
  "akamud.vscode-theme-onedark",
  "github.github-vscode-theme",

  # --- Icon themes (active: Monokai Pro Icons) ---
  "pkief.material-icon-theme",
  "vscode-icons-team.vscode-icons",
  "beardedbear.beardedicons",
  "file-icons.file-icons"
)
foreach ($e in $exts) { cursor --install-extension $e }
```

> If `cursor` isn't recognized, restart PowerShell after installing Cursor, or use **Ctrl+Shift+P → "Shell Command: Install 'cursor' command"**.

### Optional cleanup while you're at it
Things that overlap and are safe to drop on the new machine:
- **Two Live Server extensions:** `ms-vscode.live-server` and `ritwickdey.liveserver` do the same job. Keep one.
- **Three Docker extensions:** `docker.docker`, `ms-azuretools.vscode-docker` and `ms-azuretools.vscode-containers` overlap. Newer setups only need `vscode-containers`.
- **Themes and icon packs:** you use one color theme and one icon theme. The rest are only there for switching.

---

## 3. `settings.json` (Windows version)

Open with **Ctrl+Shift+P → "Preferences: Open User Settings (JSON)"** and paste this in.

```jsonc
{
    // --- Look ---
    "workbench.colorTheme": "Ayu Mirage Bordered",
    "workbench.iconTheme": "Monokai Pro Icons",
    "workbench.activityBar.orientation": "vertical",
    "workbench.colorCustomizations": {},
    "window.autoDetectColorScheme": false,
    "editor.fontSize": 16,
    "indentRainbow.indicatorStyle": "light",
    "vscode-pokemon.theme": "forest",
    "vscode-pokemon.defaultPokemon": [],

    // --- Editor behaviour ---
    "files.autoSave": "afterDelay",
    "git.autofetch": true,
    "notebook.showFoldingControls": "always",

    // --- Python ---
    "python.useEnvironmentsExtension": true,
    "python.analysis.typeCheckingMode": "standard",
    "cursorpyright.analysis.typeCheckingMode": "standard",
    "settingsSync.ignoredSettings": ["-python.defaultInterpreterPath"],
    // If you install Miniforge on Windows, point these at it, e.g.:
    // "python.condaPath": "C:\\Users\\<you>\\miniforge3\\Scripts\\conda.exe",
    // "python-envs.globalSearchPaths": ["C:\\Users\\<you>\\miniforge3", "C:\\Users\\<you>\\miniforge3\\envs"],

    // --- Cursor ---
    "cursor.cpp.disabledLanguages": ["plaintext", "markdown", "scminput", "sql"],
    "cursor.composer.queueMessageDefaultBehavior": "steer",

    // --- Terminal (fish isn't native on Windows; pick one) ---
    "terminal.integrated.defaultProfile.windows": "PowerShell"
    // or "Git Bash" if you install Git for Windows
}
```

### What I left out and why
| Setting on Arch | Reason |
|---|---|
| `python.condaPath`, `python.venvPath`, `python-envs.globalSearchPaths`, `python.defaultInterpreterPath` | Linux paths (`/home/mads/miniforge3`, `/bin/python`). Commented Windows examples are included above. |
| `terminal.integrated.*.linux` (fish at `/sbin/fish`) | Linux only. Swapped for a Windows profile. |
| `password-store: "basic"` | Linux keyring workaround. Not needed on Windows. |
| All `pgsql.*` settings and connections | No databases on the Windows laptop. |
| `vscode-pets.*`, `workbench.settings.applyToAllProfiles` | Leftovers from the VS Code import. vscode-pets isn't installed in Cursor. |
| `github.copilot.*` | Also from the VS Code import. Copilot isn't installed in Cursor, and Cursor's own Tab feature replaces it. |

---

## 4. `keybindings.json`

**Ctrl+Shift+P → "Preferences: Open Keyboard Shortcuts (JSON)"**. You can copy this over unchanged:

```json
[
    { "key": "alt+a", "command": "editor.action.commentLine", "when": "editorTextFocus && !editorReadonly" },
    { "key": "ctrl+shift+7", "command": "-editor.action.commentLine", "when": "editorTextFocus && !editorReadonly" },
    { "key": "alt+t", "command": "workbench.action.terminal.toggleTerminal", "when": "terminal.active" },
    { "key": "ctrl+shift+[Equal]", "command": "-workbench.action.terminal.toggleTerminal", "when": "terminal.active" },
    { "key": "ctrl+shift+[Semicolon]", "command": "editor.action.toggleWordWrap" },
    { "key": "alt+z", "command": "-editor.action.toggleWordWrap" }
]
```

Summary: **Alt+A** toggles comments, **Alt+T** toggles the terminal, **Ctrl+Shift+;** toggles word wrap. The `[Equal]`/`[Semicolon]` ones are physical key codes, so they hit the same physical keys if the Windows laptop also has a Swedish layout.

---

## 5. Other Cursor bits

- **Vercel plugin.** It's cached from the Cursor plugin marketplace (`~/.cursor/plugins/cache/cursor-public/vercel`). Reinstall it from Cursor's plugin marketplace if you still use it.
- **MCP servers:** none (`mcp.json` is empty).
- **User rules (Settings → Rules):** empty.
- **`skills-cursor/`:** Cursor's built-in skills. Nothing to copy.
- **Account-side stuff** like models and chat history comes back when you sign in.

---

## Appendix: VS Code vs Cursor

**Came from VS Code** (in both): Python, Jupyter (all 5), debugpy, python-envs, ruff, Docker (all 3), Prettier, HTML-CSS, both Live Servers, GitLens, Todo Tree, indent-rainbow, rainbow-csv, PDF, vscode-pokemon, vscode-icons, Ayu, One Dark, Tokyo Night, GitHub theme.

**Added in Cursor only:** cursorpyright, Cursor remote-ssh/containers, Tailwind, ES7 React snippets, Colab, Hugging Face, markdown-mermaid, Catppuccin, Gruvbox, Monokai Pro, Material Icon Theme, Bearded Icons, file-icons.

**In VS Code but not Cursor** (you didn't carry these over): Copilot Chat, Pylance (blocked in Cursor), Live Share, Remote Explorer/SSH-Edit, PPTX preview, Mermaid Chart, Mermaid Preview, Copilot Mermaid Diagram, Material Palenight theme.
