# System-wide NixOS configuration for the "vimyoung" laptop.
# Rebuild with: nh os switch . --hostname vimyoung

{ config, lib, pkgs, ... }:

{
	# Include the hardware scan (disks, kernel modules, CPU).
	imports = [
		./host/hardware-configuration.nix
	];

	# Boot with systemd-boot on EFI.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	# Hostname on the local network.
	networking.hostName = "vimyoung";

	# NetworkManager handles Wi-Fi and Ethernet (use nmcli or nmtui).
	networking.networkmanager.enable = true;

	# Local time zone.
	time.timeZone = "Europe/Kyiv";

	# Enable flakes and the unified `nix` command.
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Optional HTTP proxy (uncomment and adjust if needed).
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# System language and locale.
	i18n.defaultLocale = "ru_RU.UTF-8";

	# Text console settings (usually not needed with a graphical login).
	# console = {
	#   font = "Lat2-Terminus16";
	#   keyMap = "us";
	#   useXkbConfig = true; 	# use xkb.options in tty.
	# };

	# Wayland session: niri compositor with the GDM login screen.
	programs.niri.enable = true;
	services.displayManager.gdm.enable = true;

	# X11 is not used; xwayland-satellite covers legacy X applications.
	# services.xserver.enable = true;

	# Alternative tiling compositor (disabled).
	# programs.hyprland.enable = true;

	# X11 keymap (only relevant when X11 is enabled).
	# services.xserver.xkb.layout = "us";
	# services.xserver.xkb.options = "eurosign:e,caps:escape";

	# Printing support (disabled).
	# services.printing.enable = true;

	# PipeWire handles sound for native and PulseAudio applications.
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	# Touchpad support (usually enabled by the desktop manager).
	# services.libinput.enable = true;

	# Main user account; set the password once with `passwd`.
	users.users.vimyoung = {
		isNormalUser = true;
		extraGroups = [ "wheel" "input" "networkmanager" "video" "render" ]; 	# `wheel` enables sudo.
	};

	# Steam with ports opened for Remote Play and game servers.
	programs.steam = {
		enable = true;
		remotePlay.openFirewall = true;
		dedicatedServer.openFirewall = true;
	};

	# Desktop shell: bar, launcher, lock screen and theming.
	programs.serpantinum.enable = true;

	# System-wide packages (user tools live in Home Manager).
	environment.systemPackages = with pkgs; [
		xwayland-satellite
		pulseaudio
	];

	# Adwaita Mono is used by serpantinum (theme.fontFamily).
	fonts.packages = [ pkgs.adwaita-fonts ];

	# Allow proprietary software.
	nixpkgs.config.allowUnfree = true;

	# ventoy is flagged insecure in nixpkgs (bundled binaries with CVEs).
	# Prefer `nix shell nixpkgs#ventoy` instead of installing it permanently.
	nixpkgs.config.permittedInsecurePackages = [ "ventoy-1.1.18" ];

	# AppImage support (disabled).
	# programs.appimage = {
	#   enable = true;
	#   binfmt = true;
	# };

	# Garbage-collect old generations once a day.
	nix.gc = {
		automatic = true;
		dates = "daily";
		options = "--delete-older-than 7d";
	};

	# Deduplicate files in the Nix store.
	nix.settings.auto-optimise-store = true;

	# Keep ten boot entries and clean /tmp on boot.
	boot.loader.systemd-boot.configurationLimit = 10;
	boot.tmp.cleanOnBoot = true;

	# Thermal management and Intel media drivers.
	services.thermald.enable = true;

	hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];
	hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];

	# Firmware updates and storage maintenance.
	hardware.enableAllFirmware = true;
	services.fstrim.enable = true;
	services.fwupd.enable = true;
	services.gvfs.enable = true;
	services.udisks2.enable = true;

	# Compressed RAM swap for better responsiveness.
	zramSwap.enable = true;

	boot.kernel.sysctl = {
		"vm.swappiness" = 100;
		"vm.page-cluster" = 0;
	};

	# Spread interrupts across CPU cores.
	services.irqbalance.enable = true;

	# Quiet boot (optional).
	# boot.kernelParams = [ "quiet" "loglevel=3" ];

	# SUID helpers and the GPG agent (disabled).
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# Remote shell access (disabled).
	# services.openssh.enable = true;

	# Firewall ports (the firewall stays enabled by default).
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# networking.firewall.enable = false;

	# Keep a copy of this configuration in the system profile (disabled).
	# system.copySystemConfiguration = true;

	# Initial NixOS release; do not change after installation.
	# See https://nixos.org/manual/nixos/stable/#sec-upgrading
	# and https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
	system.stateVersion = "26.05";
}
