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

## Troubleshooting

### USB Wake-Up Issues

Follow this guide to quickly stop unwanted wakes or perform a detailed diagnosis to identify and permanently disable the exact USB device causing the issue.

#### A) Quick Short‑Circuit

Disable the entire USB controller responsible for spurious wakes:

1. **Identify wake‑capable controllers**

   ```bash
   grep . /proc/acpi/wakeup
   ```
2. **Disable the controller** (e.g. `XHC1`)

   ```bash
   echo XHC1 | sudo tee /proc/acpi/wakeup
   ```
3. **Test suspend**

   ```bash
   systemctl suspend
   ```

   * If unwanted wakes stop, make it permanent by adding a udev rule in your NixOS configuration:

     ```nix
     # configuration.nix
     services.udev.extraRules = ''
     # Disable wake-up on the USB host controller (gateway device)
     ACTION=="add|change", SUBSYSTEM=="pci",
       ATTR{power/wakeup}="disabled"
     '';
     ```
   * **Trade‑off**: All devices on that USB controller lose wake capability.

#### B) Detailed Diagnosis & Targeted Fix

1. **Find the active host controller**

   ```bash
   cat /proc/acpi/wakeup
   ```

   Note the entry with `*enabled` under S3 (Sysfs node shows `pci:0000:XX:00.Y`).

2. **Map to USB bus**

   ```bash
   lsusb -t              # see "Bus N" mapping
   lsusb | grep "^Bus N"   # list devices on Bus N
   ```

3. **Locate the culprit**

   ```bash
   grep . /sys/bus/usb/devices/N-*/power/wakeup
   ```

   One path reports `enabled` (e.g. `/sys/bus/usb/devices/3-1.2.4.2/power/wakeup`).

4. **Verify device IDs**

   ```bash
   udevadm info -q all -p /sys/bus/usb/devices/3-1.2.4.2 \
     | grep -E 'ID_VENDOR_ID|ID_MODEL_ID'
   ```

   Expect lines:

   ```
   E: ID_VENDOR_ID=XXXX
   E: ID_MODEL_ID=YYYY
   ```

5. **Add a udev rule**

   ```nix
   services.udev.extraRules = ''
   ACTION=="add|bind|change", SUBSYSTEM=="usb",
     ATTRS{idVendor}=="XXXX", ATTRS{idProduct}=="YYYY",
     ATTR{power/wakeup}="disabled",
     ATTR{power/control}="auto",
     ATTR{power/autosuspend_delay_ms}="5000"
   '';
   ```

6. **Apply changes**

   ```bash
   sudo nixos-rebuild switch
   sudo udevadm control --reload
   sudo udevadm trigger --action=add --subsystem-match=usb
   ```

7. **Confirm**

   ```bash
   grep . /sys/bus/usb/devices/3-1.2.4.2/power/wakeup
   # should print "disabled"
   ```

#### Summary

* **Section A**: controller‑wide disable for an immediate stop.
* **Section B**: precise identification and permanent disable of the offending device via udev.
* Adjust `power/control` and `power/autosuspend_delay_ms` to tune responsiveness and power savings.

---

Daily driver config that's still evolving. Feel free to steal ideas!
