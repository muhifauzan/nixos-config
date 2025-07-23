# My NixOS Config

###### 🚧 This is a Work in Progress

Personal NixOS flake with modular configuration system.

## Quick Start

```nix
{
  modules.amd.enable = true;                # AMD hardware
  modules.hyprland.enable = true;           # Hyprland WM
  modules.packages.extras.enable = true;    # CLI tools
  modules.dev.elixir.phoenix.enable = true; # Development
}
```

## Current Setup

**Hardware:**
- 🚧 AMD laptop (acinonyx) running Hyprland with full development environment
- 🚧 workstation *planned*

**Features:** 🚧 Multi-monitor support, development tools (Nix/Elixir/Node/Python), AI packages, SOPS secrets

```nix
modules = {
  # Hardware
  amd.enable = true;
  battery.enable = true;

  # Monitors (custom multi-monitor system)
  monitors = [
    {
      name = "eDP-1";
      primary = true;
      width = 2880;
      height = 1800;
      scale = 1.5;
      # ... more config
    }
  ];

  # Desktop
  hyprland.enable = true;

  # Development
  dev = {
    elixir.phoenix.enable = true;
    node.enable = true;
    python.enable = true;
  };

  # Packages & Apps
  packages.extras.enable = true;
  ai.enable = true;
  spotify.enable = true;
  # ...
};
```

## Available Options

- **Hardware:** `amd`, `battery`, `cpu.amd`, `gpu.amd`
- **Desktop:** 🚧 `hyprland`, `xdg`
- **Packages:** 🚧 `admin`, `extras`, `network`, `archive`, `cli`
- **Development:** 🚧 `nix`, `elixir`, `elixir.phoenix`, `node`, `python`
- **Apps:** 🚧 `ai`, `spotify`
- **Advanced:** 🚧 `monitors` (multi-monitor configuration system)

### Custom Module System

- **Basic toggles:** Simple feature flags in `modules/options.nix`
- **Complex options:** Advanced configs like monitors in `modules/options/`
- 🚧 **Implementations:** Most logic still uses traditional NixOS/home-manager modules

## Structure

```
├── flake.nix              # Main flake
├── hosts/acinonyx/        # Laptop config
├── modules/
│   ├── options.nix        # Simple feature toggles
│   ├── options/           # Complex configurations (monitors, etc.)
│   ├── nixos/             # NixOS modules
│   └── home-manager/      # Home-manager modules
└── lib/                   # Utilities
```

## Tech Stack

- **Base:** NixOS flake + home-manager
- **Desktop:** 🚧 Hyprland with custom configuration
- **Hardware:** AMD-optimized (laptop + future workstation)
- **Development:** 🚧 Multi-language setup with dev containers
- **Secrets:** SOPS encryption
- **Containers:** 🚧 Podman + quadlet

## Next

- More custom module implementations
- Expand package collections
- Add workstation config (`panthera`)

---

Daily driver config that's still evolving. Feel free to steal ideas!
