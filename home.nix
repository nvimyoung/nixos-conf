# Per-user configuration (Home Manager) for "vimyoung".
{
  config,
  pkgs,
  serpantinum,
  ...
}:
{
  # One module per application or topic.
  imports = [
    serpantinum.homeManagerModules.default
    ./dot/packages.nix
    ./dot/bash.nix
    ./dot/kitty.nix
    ./dot/serpantinum.nix
    ./dot/niri.nix
    ./dot/neovim.nix
    ./dot/firefox.nix
    ./dot/git.nix
    ./dot/fastfetch.nix
    ./dot/btop.nix
    ./dot/opencode.nix
  ];

  # Basic account settings; never change stateVersion after the first install.
  home = {
    username = "vimyoung";
    homeDirectory = "/home/vimyoung";
    stateVersion = "26.05";
  };

  # Create the standard XDG folders (Downloads, Documents, ...).
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  # niri compositor config, generated from Nix settings in dot/niri.nix.

  # Default programs and Wayland flags for GUI toolkits.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # Use the GTK3 theme for Qt applications.
  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  # Bibata mouse cursor for Wayland and X11 applications.
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 22;

    gtk.enable = true;
    x11.enable = true;
  };
}
