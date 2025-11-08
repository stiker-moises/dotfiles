{ config, pkgs, ... }:
{
imports = [
	./hardware-configuration.nix
	./sys.nix
];

# Bootloader.
boot.loader = { 
	systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
};
networking.hostName = "anarchy-desktop";
# Set your time zone.
time.timeZone = "America/Indiana/Indianapolis";

# Select internationalisation properties.
i18n = {
	defaultLocale = "en_US.UTF-8";
	extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};
};

# Configure console keymap
console.keyMap = "us";

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.communist = {
	isNormalUser = true;
	description = "Communist";
	extraGroups = [ "network" "wheel" ];
};

# Enable automatic login for the user.
services.getty.autologinUser = "communist";

# Allow unfree packages
nixpkgs.config.allowUnfree = true;
# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
# enable = true;
# enableSSHSupport = true;
# };
system.stateVersion = "24.05"; # Did you read the comment?
}
