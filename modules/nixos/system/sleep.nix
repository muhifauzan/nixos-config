{ ... }:

{
  boot.kernelParams = [
    "mem_sleep_default=deep"
    "hibernate.compressor=lz4"
    "rtc_cmos.use_acpi_alarm=1"
  ];

  systemd.sleep.extraConfig = ''
    AllowSuspend=yes
    AllowHibernation=yes
    AllowHybridSleep=yes
    AllowSuspendThenHibernate=yes
    SuspendState=mem
    MemorySleepMode=deep
    HibernateDelaySec=30m
    HibernateOnACPower=yes
  '';
}
