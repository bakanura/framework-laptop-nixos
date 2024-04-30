# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
# add nixos-hardware channel declaratively
  hardwareTarball =
    fetchTarball
      https://github.com/NixOS/nixos-hardware/archive/master.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      # Add the framework 16 profile for latest fingerprint support from nixos-hardware repo
      <nixos-hardware/framework/16-inch/cpu/7040-amd>
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
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable firmware updates with fwupd
  services.fwupd.enable = true;
  services.fwupd.extraRemotes = [ "lvfs-testing" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.extraConfig = "load-module module-combine-sink";
  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
  };

  programs.bash.shellAliases = { mixer = "pulsemixer"; };
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Fingerprint with fprintd
  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090; #(If the vfs0090 Driver does not work, use the following driver)

  # Powermanagement
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Enable thermal data
  services.thermald.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.lunchbag = {
    isNormalUser = true;
    description = "Lunchbag";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
	firefox
	lutris
	wine
	discord
	steam
	thunderbird
	vscode
	terraform
	pulseaudioFull
	# Console mixer
	pulsemixer
	# Equalizer on sterids
	easyeffects
	ldacbt
	fprintd
	fwupd
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable and install Steam + prerequisities
  hardware.steam-hardware = {
    enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	pkgs.steam
	pkgs.ldacbt
	pkgs.fprintd
	pkgs.fwupd
	pkgs.vscode
	(vscode-with-extensions.override {
	    vscodeExtensions = with vscode-extensions; [
	      bbenoist.nix
	      ms-python.python
	      ms-azuretools.vscode-docker
	      ms-vscode-remote.remote-ssh
	    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
	      {
	        name = "remote-ssh-edit";
	        publisher = "ms-vscode-remote";
	        version = "0.47.2";
	        sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
	      }
	    ];
	  })
	pkgs.go
	pkgs.terraform
	pkgs.pulseaudioFull
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
  # services.openssh.enable = true;

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
  system.stateVersion = "23.11"; # Did you read the comment?

}
