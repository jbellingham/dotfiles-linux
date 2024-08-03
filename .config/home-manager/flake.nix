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
  outputs = {
    nixpkgs,
    # nixpkgs_2311,
    home-manager,
    nixGL,
    ...
  }:
  let
    system = "x86_64-linux";
    # oldPkgsSrc = builtins.fetchTarball {
    #   # https://github.com/nixos/nixpkgs/tree/nixos-23.11
    #   url = "https://github.com/nixos/nixpkgs/archive/219951b495fc2eac67b1456824cc1ec1fd2ee659.tar.gz";
    #   sha256 = "sha256-u1dfs0ASQIEr1icTVrsKwg2xToIpn7ZXxW3RHfHxshg=";
    #   name = "source";
    # };

    # oldPkgs = import oldPkgsSrc {
    #   inherit system;
    #   config.allowUnfree = true;
    # };

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      # overlays = [ (final: prev: { glibc = oldPkgs.glibc; }) ];
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