# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixal"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/London";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  #networking.interfaces.proton0.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "uk";
  };

  

  # Configure keymap in X11
  services.xserver.layout = "gb";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # X Window System
  services.xserver.enable = true;
  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      i3lock-fancy
      i3blocks
    ];
  };
  services.xserver.autorun = true; # Default is true


  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.tapping = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.al = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ and networking for the user.
  };
  users.users.root.initialHashedPassword = "";

  # Enables proprioetry software
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

  # Sys Admin Tools
    wget 
    (import ./vim.nix)
    git
    man
    which
    xclip
    xorg.xbacklight
    lsof

  # Dev Tools
    python3
    pkg-config
    gcc
    gnumake
    (st.overrideAttrs (oldAttrs: rec {
      patches = [
				/home/al/.config/st-0.8.4/st-scrollback-20200419-72e3f6c.diff
				/home/al/.config/st-0.8.4/st-scrollback-mouse-20191024-a2c479c.diff
			];
			configFile = writeText "config.def.h" (builtins.readFile /home/al/.config/st-0.8.4/config.h);
			postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.def.h";
		}
    ))

  # Personal Tools
    firefox
    vimHugeX
    bat
    feh
    fzf
    scrot

  # Communication 
    discord
    element-desktop
    protonmail-bridge
    signal-desktop
    teams
    tdesktop
    thunderbird
    zoom-us
    steam

  # Work Tools
    dia
    gnumeric
    inkscape
    libreoffice
    termdown
    todo-txt-cli
    zathura
    zotero

  # Media
    mpv
    ncspot
    pavucontrol
    pamixer
    pulseaudio
    envsubst
    playerctl

  # Security
    bitwarden
    clamav
    macchanger
    protonvpn-cli
    libsecret
    pinentry
    pass

  # Personalisation
    dijo
    flashfocus
    picom
    redshift
    unclutter
    tlp
    acpi

  # File management
    nextcloud-client
    transmission-gtk
    ranger
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true; 
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };

  environment.pathsToLink = [
      "~/.local/bin/"
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
  system.stateVersion = "20.09"; # Did you read the comment?

}

