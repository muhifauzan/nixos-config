{ ... }:

{
  imports = [
    ./ssd.nix
    ./cpu.nix
    ./gpu.nix
    ./graphic.nix
    ./video.nix
    ./audio.nix
  ];

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
  ];
}
