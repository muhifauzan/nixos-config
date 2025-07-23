{ pkgs, lib, ... }:

{
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "rtc_cmos.use_acpi_alarm=1"
  ];

  boot.initrd.prepend = lib.mkOrder 0 [
    "${pkgs.fetchurl {
      url = "https://gitlab.freedesktop.org/drm/amd/uploads/9fe228c7aa403b78c61fb1e29b3b35e3/slim7-ssdt";
      sha256 = "sha256-Ef4QTxdjt33OJEPLAPEChvvSIXx3Wd/10RGvLfG5JUs=";
      name = "slim7-ssdt";
    }}"
  ];
}
