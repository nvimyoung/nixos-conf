{
  # NixOS flake for the "vimyoung" laptop.
  description = "nvimyoung NixOS configuration";

  inputs = {
    # Unstable packages, shared by the system and Home Manager.
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # User-level configuration (dotfiles, programs, services).
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop shell, bar, launcher and lock screen.
    serpantinum = {
      url = "github:ilyamiro/serpantinum";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, serpantinum, ... }: {
    # `nix fmt` uses nixfmt.
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;

    # One host: the NixOS system plus the same user's Home Manager profile.
    nixosConfigurations.vimyoung = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        serpantinum.nixosModules.default

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit serpantinum; };

          home-manager.users.vimyoung = import ./home.nix;
        }
      ];
    };
  };
}
