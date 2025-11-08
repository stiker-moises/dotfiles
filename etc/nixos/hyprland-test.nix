{pkgs, lib, ...}: let
	flake-compat = builtins.fetchTarball "https://github.com/edolstra/flake-compat/archive/master.tar.gz";
		hyprland = (import flake-compat {
		src = builtins.fetchTarball "https://github.com/vaxerski/Hyprland/archive/e74f2de3a4c19d75d14e538c102641efd08acbee.tar.gz";
	}).defaultNix;
	hyprlandNixpkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
	programs.hyprland = {
		package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};
	hardware.graphics = {
		package = hyprlandNixpkgs.mesa;
		package32 = hyprlandNixpkgs.pkgsi686Linux.mesa;
	};
}
