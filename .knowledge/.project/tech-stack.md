# Technology Stack

## 🖥️ System Foundation
- **OS**: NixOS (unstable channel)
- **Package Manager**: Nix with flakes
- **System Config**: Declarative NixOS configuration
- **User Config**: Home-manager (integrated via NixOS module)

## 🪟 Desktop Environment  
- **Compositor**: Hyprland v0.49.0 (Wayland)
- **Terminal**: kitty
- **Shell**: zsh
- **Editor**: Zed

## 🛠️ Development Tools
- **LSP**: nixd (Nix language server)
- **Formatter**: nixfmt via treefmt
- **Build Tool**: `nixos-rebuild`, `nix build`
- **Version Control**: git

## 📦 Package Management
- **System Packages**: NixOS configuration
- **User Packages**: Home-manager
- **Development**: Custom modules with enable flags

## 🔧 Configuration Management
- **Structure**: Flake-based with custom utils
- **Modularity**: Separated nixos/home-manager modules
- **Machine Support**: Multi-machine configurations
- **Validation**: Assertion-based validation

## 🧪 Testing & Validation
- **Syntax**: `nix flake check`
- **Build**: `nixos-rebuild dry-build`
- **LSP**: Manual testing in Zed
- **Type Safety**: Nix type system validation

## 📁 File Organization
```
Committed to Git:
├── flake.nix, lib/, hosts/, modules/
├── .knowledges/README.md
├── .knowledges/session-start.md  
├── .knowledges/templates/
└── .knowledges/core/

Local Only (.gitignored):
├── .knowledges/active/
├── .knowledges/.archives/
└── .knowledges/debug scripts
```

## 🔗 External Dependencies
- **nixpkgs**: github:NixOS/nixpkgs/nixos-unstable
- **home-manager**: github:nix-community/home-manager
- **hyprland**: github:hyprwm/Hyprland/v0.49.0
- **treefmt-nix**: github:numtide/treefmt-nix

## 🎯 Key Features
- **Type Safety**: Strong typing with nixd LSP
- **Reproducibility**: Flake lock ensures consistency
- **Extensibility**: Module system supports extensions
- **Validation**: Assertions prevent invalid configs
- **Documentation**: Integrated with LSP for autocompletion
