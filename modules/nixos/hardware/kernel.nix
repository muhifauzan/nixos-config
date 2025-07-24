{ ... }:

{
  boot.kernelParams = [
    "acpi.prefer_microsoft_dsm_guid=1"
    "pcie_aspm.policy=powersupersave"
  ];
}
