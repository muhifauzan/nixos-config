# Quick Reference: Extensible Monitor API

## 🚀 Quick Start

### Basic Configuration
```nix
modules.monitors = [
  {
    name = "DP-1";
    primary = true;
    width = 2560;
    height = 1440;
    refreshRate = 144;
    position = "0x0";
    scale = "1";
  }
];
```

### With Hyprland Extensions
```nix
modules.monitors = [
  {
    name = "DP-1";
    primary = true;
    width = 2560;
    height = 1440;
    
    hyprland = {
      workspace = "1";
      vrr = 1;              # 0=off, 1=on, 2=fullscreen
      transform = 0;        # 0=0°, 1=90°, 2=180°, 3=270°
      adaptiveSync = true;
      bitdepth = 10;        # 8 or 10-bit color
    };
  }
];
```

### Multiple Monitors
```nix
modules.monitors = [
  {
    name = "eDP-1";
    primary = true;
    width = 2880;
    height = 1800;
    scale = "1.5";
    hyprland.workspace = "1";
  }
  {
    name = "DP-4";
    width = 3440;
    height = 1440;
    refreshRate = 144;
    position = "auto";
    hyprland = {
      vrr = 1;
      workspace = "2";
      adaptiveSync = true;
    };
  }
];
```

## 📋 Available Options

### Base Options (Always Available)
- `name`: Monitor identifier (string or `{ desc = "Description"; }`)
- `width`, `height`: Resolution in pixels
- `refreshRate`: Refresh rate in Hz (default: 60)
- `position`: Position like "0x0", "1920x0", or "auto"
- `scale`: Scaling factor as string (e.g., "1", "1.5")
- `primary`: Whether this is the primary monitor (bool)
- `enabled`: Whether monitor is enabled (default: true)
- `workspace`: Default workspace (string, optional)

### Hyprland Options (`hyprland.*`)
- `workspace`: Workspace assignment
- `vrr`: Variable refresh rate (0, 1, 2)
- `transform`: Rotation (0, 1, 2, 3)
- `bitdepth`: Color depth (8, 10)
- `adaptiveSync`: Enable adaptive sync (bool)
- `mirror`: Mirror to another monitor (string)

## 🧪 Testing Checklist

### nixd LSP Integration
- [ ] Type `modules.monitors[0].hyprland.` → autocompletion appears
- [ ] Invalid values show type errors
- [ ] Hover shows option descriptions

### Build Testing
```bash
# From your nixos-config project directory
chmod +x .knowledges/verify-cleanup.sh
./.knowledges/verify-cleanup.sh

# Or manually:
nix flake check
nix eval .#nixosConfigurations.acinonyx.options.modules.monitors
```

### Assertion Testing
- [ ] Multiple `primary = true` → error message
- [ ] Single primary monitor → builds successfully

## 🔧 Extending the API

### Adding New DE Support
1. Create `modules/options/monitors-{de}.nix`
2. Register extension:
   ```nix
   config.modules._monitorExtensions = [
     { options.{de} = { /* options */ }; }
   ];
   ```
3. Add to `modules/options/default.nix` imports
4. Options automatically available as `{de}.*`

## 🎯 Key Benefits

✅ **Type Safety**: No more string-based config  
✅ **LSP Support**: Full autocompletion in nixd  
✅ **Extensibility**: Easy to add new DEs  
✅ **Clean API**: Separation of base vs DE options  
✅ **Future Proof**: Registry-based architecture
