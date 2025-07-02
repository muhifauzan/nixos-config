{ config, ... }:

{
  config = {
    virtualisation.podman.autoPrune.enable = true;

    users.users.${config.username} = {
      subUidRanges = [
        {
          startUid = 100000;
          count = 65536;
        }
      ];

      subGidRanges = [
        {
          startGid = 100000;
          count = 65536;
        }
      ];
    };
  };
}
