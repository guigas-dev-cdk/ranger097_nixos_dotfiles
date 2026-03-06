{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";


   lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";

      # Optional but recommended to limit the size of your system closure.
      inputs.nixpkgs.follows = "nixpkgs";
    };



   home-manager = {
   url = "github:nix-community/home-manager";
   inputs.nixpkgs.follows = "nixpkgs";


};
  };
 
  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs: {
   nixosConfigurations.pokemon = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
 specialArgs = { inherit inputs; };
  modules = [
  ./configuration.nix
  home-manager.nixosModules.home-manager
  
lanzaboote.nixosModules.lanzaboote
({ pkgs, lib, ... }: {



 boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
 })





{
home-manager.useGlobalPkgs = true;
home-manager.useUserPackages = true;
home-manager.users.ranger = import ./home.nix;
home-manager.backupFileExtension = "backup";




}
  ];
  };
};
}
