{ config, ... }:

{
  config = {
    users.users.${config.username} = {
      extraGroups = [ "podman" ];

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
