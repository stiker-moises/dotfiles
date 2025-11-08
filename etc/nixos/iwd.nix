{ config, pkgs, lib, ... }:
{
networking = {
	networkmanager.enable = lib.mkDefault false;
	nameservers = [ "1.1.1.1" "9.9.9.9" ];
	wireless.iwd = {
		enable = true;
		settings = {
			IPv6 = {
				Enabled = true;
			};
			Settings = {
				AutoConnect = true;
			};
		};
	};
};
}

