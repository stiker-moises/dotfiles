{ config, pkgs, ... }:
{
imports = [
	./amdgpu.nix
	./amdcpu.nix
	./invidious.nix
#	./hyprland-test.nix
	./work.nix
];
boot.kernelParams = [
	"amd_pstate=active"
	"amdgpu.ppfeaturemask=0xffffffff"
	"iommu=pt"
];
programs.nix-ld = {
	libraries = with pkgs; [
	];
};
virtualisation.libvirtd = {
	enable = true;
	qemu = {
		package = pkgs.qemu_kvm;
		runAsRoot = true;
		swtpm.enable = true;
	};
};
users.users.communist = {
	extraGroups = [ "libvirtd" "dialout" ];
};
environment.systemPackages = with pkgs; [
	anydesk
	bsnes-hd
	cemu
	chromium
	clonehero
	lapce
	helix
	optipng
	cosmic-ext-calculator
	cosmic-ext-tweaks
	dolphin-emu
	element-desktop
	equibop
#	gpt4all
	inkscape
	socat
	bc
	ironbar
	iw4x-launcher
	kdePackages.neochat
	libva-utils
	logiops
	lsof
	mgba
	nheko
	python314
	qbittorrent
	r2modman
	spotify
	telegram-desktop
	yarg
	yt-dlp
#	cosmic-notifications
#	cosmic-osd
#	cosmic-settings
#	ironbar
#	cosmic-files
#	cosmic-notifications
#	cosmic-panel
#	cosmic-settings
#	cosmic-store
#	gpt4all
#	piper
#	python313Full
#	python313Packages.pip
#	python313Packages.virtualenv
#	torzu
#	vesktop
#	wineWow64Packages.stagingFull
];

hardware.keyboard.zsa.enable = true;

nixpkgs.config.permittedInsecurePackages = [
	"olm-3.2.16"
#	"libxml2-2.13.8"
#	"libsoup-2.74.3"
];

#services = {
#	kanata = {
#		keyboards.ergodox = {
#			devices = ["/dev/input/by-id/usb-ZSA_Technology_Labs_Ergodox_EZ_5VoRX_MPxar-event-kbd"];
#			extraDefCfg = ''
#				process-unmapped-keys false
#				concurrent-tap-hold yes
#			'';
#			config = builtins.readFile (./. + "/ergodox.kbd") + builtins.readFile (./. + "/chords.kbd");
#		};
#	};
#	ratbagd.enable = true;
#};
}
