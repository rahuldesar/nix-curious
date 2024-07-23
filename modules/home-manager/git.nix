{ config, pkgs, lib, ... }: {
  programs.git = {
    enable = true;
    userName = "Rahul Deshar";
    userEmail = "desarrahul@gmail.com";
  };
}
