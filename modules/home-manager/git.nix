{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Muhammad Fauzan";
    userEmail = "mfauzanmhf@gmail.com";

    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}

