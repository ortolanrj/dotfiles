{
  description = "My NixOS Configuration and Dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        ponzi = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix 
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ponzi = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
      homeConfig = {
        ponzi = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "ponzi";
          homeDirectory = "/home/ponzi";
          stateVersion = "21.11";
          configuration = {
            imports = [
              ./home.nix
            ];
          };
        };
      };
    };
}
