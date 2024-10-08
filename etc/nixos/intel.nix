{ config, pkgs, ... }:
{
hardware.graphics = {
	enable = true;
	extraPackages = with pkgs; [
		vpl-gpu-rt
		intel-media-driver # LIBVA_DRIVER_NAME=iHD
		intel-vaapi-driver # LIBVA_DRIVER_NAME=i965
		libvdpau-va-gl
	];
};
#exists for legacy reasons, remove after next nixos update
#hardware.opengl = {
#	enable = true;
#	extraPackages = with pkgs; [
#		onevpl-intel-gpu
#		intel-media-driver # LIBVA_DRIVER_NAME=iHD
#		intel-vaapi-driver # LIBVA_DRIVER_NAME=i965
#		libvdpau-va-gl
#	];
#};
environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}

