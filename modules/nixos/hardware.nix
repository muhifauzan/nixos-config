{ ... }:

{
  imports = [ ./hardware ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "nvme"
  ];

  hardware = {
    enableRedistributableFirmware = true;
    bluetooth.enable = true;
  };
}
