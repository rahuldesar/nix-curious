# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, pkgs-stable, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kathmandu";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "dvorak";

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu # application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock # default i3 screen locker
        i3blocks # if you are planning on using i3blocks over i3status
      ];
    };
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  # https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vader = {
    isNormalUser = true;
    description = "vader";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [''
      ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCEsztEnDtojTl8Nlxx51YS4A2RGCUUIbxGM+6cX9/k2ow0Ddzv/y4b+cwbTq3s6a1zNPSGNFRM38jASAG5+MPvIn8kQ2DlgWrPWs4E3y5UbwVUiobC1yJqDbxljcPbN1SupB31mb3IR0iMDzTbBsZq94Qj6dq80mNL276H+RJIyjqjshZJW+DGqHNoyhWAXVduQDh5Z5AnL13TTOS1ur7Kic8MoAFAl2NnmWNkxdEitQFykavueBgJ+pSBfdUI2NzG+ofxrqlkwzNkPIQNnnG7hpAtQ3PttPiU36lqybEsrj+xsh8pSK6vVXKP7Anb58hExxSMuv1M2lk5dKRo98EE83f7uH3eVY+Xzx1uHO3hzTNscrWoVR0CTDGa5ZgGQmMEwoFapLGiWEg7lK0OXrurhARSovgQsTrlNZa0SPc5X6Dl4hHxS3FxzzkT1YEvh08r3OS1TqZfaBhbbD3skh44Leg2Er6l+7i5reLvS0RF93YOFSl+6lqwMP22bySWa20= rahul@rahul-pc
    ''];
    packages = with pkgs-stable;
      [
        #  thunderbird
      ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs = { zsh = { enable = true; }; };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs-stable; [
    kitty
    # Essentials
    git
    autojump
    fzf
    htop
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    tree
    jq
    tmux
    thefuck
    tldr

    curl
    gh

    # Quality of life 
    ripgrep
    lazydocker
    dua
    lazygit
    dive # Docker layers inspect tool
    btop

    # Extras
    # rustc
    # rustup
    # cargo

    # Experimental
    rofi

    nixfmt

    #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.grub.configurationLimit = 10;

  # Perform garbage collection weekly to maintain low disk usage
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  # You can also manually optimize the store via:
  #    nix-store --optimise
  # Refer to the following link for more details:
  # https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
  nix.settings.auto-optimise-store = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
