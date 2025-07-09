# Project Architecture

## 🏗️ System Overview
**NixOS Flake Configuration with Hyprland Desktop Environment**

```
nixos-config/
├── flake.nix              # Main flake definition
├── lib/utils.nix          # Machine configuration utilities  
├── hosts/
│   └── default/
│       ├── configuration.nix  # NixOS config
│       └── home.nix           # Home-manager config
└── modules/
    ├── nix.nix            # Nix settings
    ├── options.nix        # Option definitions
    ├── options/           # Modular option definitions
    ├── nixos/             # NixOS-specific modules
    └── home-manager/      # Home-manager modules
```

## 🎯 Design Patterns

### Machine Configuration Pattern
- **Utils library**: Handles machine defaults and auto-resolution
- **Multi-machine support**: workstation, laptop, server configs
- **Auto-resolution**: Hostnames, config paths, home-manager setup
- **Flake integration**: Clean input management with follows

### Module System Pattern
- **Custom namespace**: `modules.*` for project options
- **Separation**: nixos vs home-manager modules
- **Option definitions**: Separated from implementations
- **Extensibility**: Registry-based extension system

### Extension Registry Pattern
```nix
# Extension point
options.modules._extensions = mkOption {
  type = types.listOf types.deferredModule;
  internal = true;
};

# Auto-registration
config.modules._extensions = [
  { options.newFeature = { ... }; }
];

# Dynamic composition
serviceType = types.submoduleWith {
  modules = [ baseModule ] ++ extensions;
};
```

## 🛠️ Key Technologies
- **NixOS**: Declarative system configuration
- **Home-manager**: User environment management
- **Hyprland**: Wayland compositor
- **Flakes**: Reproducible builds and inputs

## 🎨 Configuration Philosophy
- **Type safety**: Strong typing with validation
- **Extensibility**: Easy to add new features
- **Modularity**: Clean separation of concerns
- **Declarative**: Everything as code
- **Reproducible**: Flake-based builds

## 🖥️ Monitor System Implementation

### Current Monitor Module
Located: `modules/options/monitors.nix`

**Module Import Chain:**
```
hosts/default/configuration.nix
  └── modules/nixos/default.nix
      └── modules/default.nix
          └── modules/options.nix
              └── modules/options/default.nix
                  └── modules/options/monitors.nix
```

**Current Usage Pattern:**
```nix
modules.monitors = [
  {
    name = "eDP-1";
    primary = true;
    width = 2880;
    height = 1800;
    refreshRate = 90;
    position = "0x0"; 
    scale = 1.5;
  }
  {
    name = "DP-4";
    width = 3440;
    height = 1440;
    refreshRate = 144;
    position = "auto";
    scale = 1;
    options = "vrr, 1";  # ← Not type-safe, string-based
  }
];
```

**Current Limitations:**
- No extensibility for DE-specific options
- String-based `options` field (not type-safe)
- Manual extension requires code changes
- No separation of base vs extended functionality
- No LSP autocompletion for extensions

## 🔧 Development Workflow
- **Editor**: Zed with nixd LSP
- **Building**: `nixos-rebuild` or `nix build`
- **Formatting**: treefmt with nixfmt
- **Testing**: `nix flake check` validation
