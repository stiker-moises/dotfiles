{ config, pkgs, ... }:
{
environment.systemPackages = with pkgs; [
	chromium
	element-desktop
	spotifywm
	telegram-desktop
];
nixpkgs.config.permittedInsecurePackages = [
	"jitsi-meet-1.0.8043"
	"electron-29.4.6"
];
}
