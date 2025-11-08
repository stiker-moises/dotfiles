{ config, pkgs, ... }:
{
imports = [
# uncomment your gpu
#	./amdgpu.nix
#	./intelgpu.nix
#	./nvidiagpu.nix
# and cpu
#	./amdcpu.nix
];
environment.systemPackages = with pkgs; [
	#install things here
];
nixpkgs.config.permittedInsecurePackages = [
	#you may need this for certain packages
];
}
