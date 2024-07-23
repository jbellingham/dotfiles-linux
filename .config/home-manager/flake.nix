{
  description = "Home Manager configuration of root";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixGL = {
      url = "github:guibou/nixGL";
      flake = false;
    };
  };
  outputs = { nixpkgs, home-manager, nixGL, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    nixgl = import nixGL {
      inherit pkgs;
    };
  in {
    homeConfigurations."jesse" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit nixgl;
      };
      modules = [ ./home.nix ];
    };
  };
}