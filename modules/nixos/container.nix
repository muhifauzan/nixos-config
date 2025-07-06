{ machine, ... }:

let
  inherit (machine) user;
in
{
  config = {
    virtualisation.podman.autoPrune.enable = true;

    users.users.${user.username} = {
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
