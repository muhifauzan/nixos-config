{ pkgs, machine, ... }:

let
  inherit (machine) user;
in
{
  config = {
    programs.zsh.enable = true;
    users.users.${user.username}.shell = pkgs.zsh;
  };
}
