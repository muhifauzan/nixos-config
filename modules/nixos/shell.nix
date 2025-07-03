{ user, pkgs, ... }:

{
  config = {
    programs.zsh.enable = true;
    users.users.${user.username}.shell = pkgs.zsh;
  };
}
