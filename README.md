# Oh My Zsh Custom Setup

A portable Oh My Zsh configuration featuring:

- **Theme:** [Powerlevel10k](https://github.com/romkatv/powerlevel10k) — fast, feature-rich prompt
- **Plugins:** `zsh-syntax-highlighting`, `zsh-autosuggestions`, `git`
- **Custom config:** `.zshrc`, `.p10k.zsh`, `.zshenv`

## Prerequisites

Before running the installer, make sure you have:

| Requirement | Notes |
|---|---|
| **zsh >= 5.3** | Most Linux/macOS systems already have it. Check with `zsh --version` |
| **curl** | Used to download Oh My Zsh and the font |
| **git** | Used to clone plugins and the theme |
| **A Nerd Font** | Powerlevel10k uses special icons — **MesloLGS NF** is recommended (the installer can auto-install it) |
| **Make zsh your default shell** (optional) | Run `chsh -s $(which zsh)` after installation |

## Quick Start

```bash
git clone https://github.com/<your-username>/Oh_my_zsh_custom_setup.git ~/Oh_my_zsh_custom_setup
bash ~/Oh_my_zsh_custom_setup/setup.sh
```

The installer will:

1. Install the **MesloLGS NF** font (if missing)
2. Install **Oh My Zsh** (if missing)
3. Install the **Powerlevel10k** theme
4. Install **zsh-syntax-highlighting** and **zsh-autosuggestions** plugins
5. Symlink the config files (`.zshrc`, `.p10k.zsh`, `.zshenv`) into your home directory

## After Installation

1. **Set the terminal font** to **MesloLGS NF** in your terminal emulator settings.
2. **Restart your terminal** or run `exec zsh`.
3. If you want to reconfigure the prompt style later, run `p10k configure`.

## What's Included

```
Oh_my_zsh_custom_setup/
├── .zshrc           # Main Zsh configuration
├── .p10k.zsh        # Powerlevel10k prompt configuration
├── .zshenv          # Environment variables
├── custom/
│   ├── themes/      # Place your custom themes here
│   └── plugins/     # Place your custom plugins here
├── setup.sh         # Automated installer
└── README.md        # This file
```

## Adding Your Own Customization

If you create your own themes or plugins, place them in the `custom/` directory:

```bash
cp my-theme.zsh-theme custom/themes/
cp my-plugin.plugin.zsh custom/plugins/
```

Then commit and push — the installer leaves those directories intact.

## Notes

- The installer symlinks config files (`.zshrc`, `.p10k.zsh`, `.zshenv`) so that pulling updates from the repo automatically applies them (after restarting the shell).
- Machine-specific `PATH` entries (e.g., Docker, editors) are harmless — they simply won't exist on other machines.
- Terminal color scheme, transparency, and font size are **not** included — those are settings of your terminal emulator itself.
