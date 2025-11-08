{ config, pkgs, lib, ... }:
{
boot.initrd.kernelModules = [ "amdgpu" ];
services.xserver.videoDrivers = [ "amdgpu" ];
hardware = {
	amdgpu.initrd.enable = true;
	graphics = {
		enable = true;
		enable32Bit = true;
	};
};
environment.systemPackages = with pkgs; [ lact ];
systemd = {
	packages = with pkgs; [ lact ];
	services.lactd.wantedBy = ["multi-user.target"];
};
}

