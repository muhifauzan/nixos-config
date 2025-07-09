# Project Context

## 🖥️ System Foundation
- **OS**: NixOS (unstable channel)
- **Package Manager**: Nix with flakes
- **System Config**: Declarative NixOS configuration
- **User Config**: Home-manager (integrated via NixOS module)

## 🪟 Desktop Environment  
- **Compositor**: Hyprland v0.49.0 (Wayland)
- **Terminal**: kitty
- **Shell**: zsh
- **Editor**: Zed with nixd LSP integration

## 🛠️ Development Tools
- **LSP**: nixd (Nix language server)
- **Formatter**: nixfmt via treefmt
- **Build Tool**: `nixos-rebuild`, `nix build`
- **Version Control**: git
- **Testing**: `nix flake check`, dry-build validation

## 🏗️ Project Architecture
**Extensible Monitor Configuration API** using registry pattern:

```nix
# Base options: name, width, height, position, scale, etc.
# Extension registry: modules._monitorExtensions  
# Hyprland extension: VRR, workspace, transform, adaptive sync
# Dynamic composition: types.submoduleWith
```

## 🔧 Configuration Management
- **Structure**: Flake-based with custom utils
- **Modularity**: Separated nixos/home-manager modules
- **Machine Support**: Multi-machine configurations (acinonyx, panthera)
- **Validation**: Assertion-based validation
- **Pattern**: Extension registry with dynamic type composition

## 📦 Package Management
- **System Packages**: NixOS configuration with enable flags
- **User Packages**: Home-manager
- **Development**: Custom modules for dev tools

## 📁 Project Structure
```
nixos-config/
├── flake.nix                    # Main flake configuration
├── hosts/default/               # Machine configurations
├── modules/
│   ├── nixos/                   # NixOS system modules
│   ├── home-manager/            # Home manager modules  
│   ├── options/                 # Custom option definitions
│   └── options.nix              # Package enable options
├── lib/utils.nix                # Flake utilities and machine builders
└── .knowledge/                  # Claude workflow system
```

## 🔗 External Dependencies
- **nixpkgs**: github:NixOS/nixpkgs/nixos-unstable
- **home-manager**: github:nix-community/home-manager
- **hyprland**: github:hyprwm/Hyprland/v0.49.0
- **treefmt-nix**: github:numtide/treefmt-nix

## 🎯 Key Features Implemented
- **Extensible Monitor API**: Type-safe monitor configuration with DE-specific extensions
- **Machine Builder**: Utility functions for multi-machine flake configurations  
- **Type Safety**: Strong typing with nixd LSP integration
- **Knowledge System**: Optimized workflow for AI assistance
- **Reproducibility**: Flake lock ensures consistency

## 🧪 Testing & Validation
- **Syntax**: `nix flake check`
- **Build**: `nixos-rebuild dry-build --flake .#acinonyx`
- **LSP**: nixd provides autocompletion and type checking in Zed
- **Type Safety**: Nix type system validation with assertions

---
*Permanent project context - technologies, architecture, and setup*
