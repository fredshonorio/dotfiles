{
  description = "home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # makes home-manager use our nixpkgs, not its own
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cellar.url = "github:VirtusLab/cellar";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      cellar,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      myLib = import ./myLib.nix { lib = nixpkgs.lib; };
      mkHome =
        module:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./common.nix module ];
          extraSpecialArgs = { inherit cellar myLib; };
        };
    in
    {
      homeConfigurations = {
        "fred@whale" = mkHome ./host-whale.nix;
        "fred@lance" = mkHome ./host-lance.nix;
        "fred@liminal" = mkHome ./host-liminal.nix;
        "fred@wooly" = mkHome ./host-wooly.nix;
      };
    };
}
