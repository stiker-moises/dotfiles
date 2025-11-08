{ config, lib, pkgs, ... }:
{
imports = [
	./${lib.removeSuffix "\n" (builtins.readFile /etc/hostname)}.nix
];
boot = {
	consoleLogLevel = 0;
	initrd.verbose = false;
	kernelModules = [ "tcp_bbr" ];
	kernelPackages = pkgs.linuxPackages_zen;
	kernelParams = [
		"boot.shell_on_fail"
		"loglevel=3"
		"nmi_watchdog=0"
		"nowatchdog"
		"panic=5"
		"quiet"
		"rd.systemd.show_status=false"
		"rd.udev.log_level=3"
		"rd.udev.log_priority=3"
		"splash"
		"udev.log_priority=3"
	];
	kernel.sysctl = {
		"fs.inotify.max_user_watches" = 100000;
		"kernel.printk" = "3 3 3 3";
		"kernel.sysrq" = 0;
		"net.core.default_qdisc" = "cake";
		"net.ipv4.conf.all.accept_source_route" = 0;
		"net.ipv4.conf.all.rp_filter" = 1;
		"net.ipv4.conf.all.send_redirects" = 0;
		"net.ipv4.conf.default.rp_filter" = 1;
		"net.ipv4.conf.default.send_redirects" = 0;
		"net.ipv4.icmp_ignore_bogus_error_responses" = 1;
		"net.ipv4.tcp_congestion_control" = "bbr";
		"net.ipv4.tcp_fastopen" = 3;
		"net.ipv4.tcp_mtu_probing" = 1;
		"net.ipv6.conf.all.accept_source_route" = 0;
		"vm.swappiness" = 10;
		"vm.dirty_ratio" = 10;
		"vm.dirty_background_ratio" = 5;
	};
	loader = {
		systemd-boot.consoleMode = "max";
		timeout = 1;
	};
	plymouth = {
		enable = true;
		theme = "hexagon_red";
		themePackages = with pkgs; [
			(adi1090x-plymouth-themes.override {
			selected_themes = [ "hexagon_red" ];
			})
		];
	};
};

console = {
#	font = "ter-132n";
#	packages = [pkgs.terminus_font];
#	useXkbConfig = true;
	earlySetup = false;
};

environment = {
	variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory
	sessionVariables = {
		ALSOFT_DRIVERS = "pipewire";
		CLUTTER_BACKEND="wayland";
		ELECTRON_OZONE_PLATFORM_HINT = "wayland";
		GDK_BACKEND = "wayland,x11,*";
		HOST = config.networking.hostName;
		TZ = "$(timedatectl show -p Timezone --value)";
		MOZ_ENABLE_WAYLAND = 1;
		NIXOS_OZONE_WL = 1;
		PROTON_NO_WM_DECORATION = 0;
		QT_QPA_PLATFORM = "wayland;xcb";
		QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
		SDL_AUDIODRIVER = "pipewire";
		SDL_VIDEODRIVER = "wayland,x11,kmsdrm,windows,directx";
		WINE_NO_WM_DECORATION = 0;
		XDG_SESSION_TYPE = "wayland";
		PROTON_ENABLE_WAYLAND = 1;
	};
	systemPackages = with pkgs; [
		alacritty
		appimage-run
		bitwarden-desktop
		blueberry
		brightnessctl
		copyq
		doas-sudo-shim
		dua
		easyeffects
		eza
		ffmpeg
		ffmpegthumbnailer
		flat-remix-icon-theme
		git
		gnome-power-manager
		gperftools
		gsettings-desktop-schemas
		handlr-regex
		hunspell
		hunspellDicts.en_US
		hyprkeys
		hyprland-autoname-workspaces
		hyprland-qtutils
		iotop
		iwgtk
		jaq
		kdePackages.ark
		kdePackages.baloo
		kdePackages.discover
		kdePackages.dolphin
		kdePackages.ffmpegthumbs
		kdePackages.gwenview
		kdePackages.kde-cli-tools
		kdePackages.merkuro
		kdePackages.okular
		kdePackages.qt6ct
		kdePackages.qtstyleplugin-kvantum
		kdePackages.qtsvg
		killall
		libappindicator
		libnotify
		libsForQt5.qt5ct
		libsForQt5.qtstyleplugin-kvantum
		libsecret
		mako
		mpv
		nodejs-slim
		p7zip
		pavucontrol
		pinta
		posy-cursors
		qalculate-qt
		qtalarm
		resources
		ripgrep
		sd
		slurp
		sound-theme-freedesktop
		speedread
		sunsetr
		swayidle
		swayosd
		swww
		syncplay
		tesseract
		unrar
		walker
		warp
		waybar
		wayland-pipewire-idle-inhibit
		waypaper
		wayshot
		wl-clipboard-rs
		wl-mirror
		wl-restart
		wljoywake
		xdg-user-dirs
		xdg-utils
		zim
		zoxide
	];
};

fileSystems."/" = {
	options = [
		"noatime"
		"nodiratime"
	];
};

fonts = {
	fontDir.enable = true;
	fontconfig = {
		defaultFonts = {
			monospace = [ "Noto Sans Mono Medium" ];
			sansSerif = [ "Noto Sans Medium" ];
			serif = [ "Noto Serif Medium" ];
			emoji = [ "Noto Emoji" ];
		};
		useEmbeddedBitmaps = true;
		cache32Bit = true;
	};
	packages = with pkgs; [
		font-awesome
		nerd-fonts.noto
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-cjk-serif
		noto-fonts-lgc-plus
		noto-fonts-monochrome-emoji
		icomoon-feather
	];
};

hardware = {
	bluetooth = {
		enable = true;
		powerOnBoot = true;
	};
	uinput.enable = true;
};

i18n = {
	defaultLocale = "en_US.UTF-8";
};
networking = {
	networkmanager.enable = lib.mkForce false;
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

nixpkgs.overlays = [
	(self: super: {
		mpv = super.mpv.override {
			scripts = [ self.mpvScripts.autosub ];
		};
	})
	(final: prev: {
		adi1090x-plymouth-themes = prev.adi1090x-plymouth-themes.overrideAttrs (previousAttrs: {
			installPhase = previousAttrs.installPhase + ''
				find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetX()/Window.GetX(0)/g' {} \;
				find $out/share/plymouth/themes/ -name \*.script -exec sed -i 's/Window.GetY()/Window.GetY(0)/g' {} \;
			'';
		});
	})
	(final: prev: {
		kdePackages = prev.kdePackages.overrideScope (kfinal: kprev: {
			dolphin = kprev.dolphin.overrideAttrs (oldAttrs: {
				nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ prev.makeWrapper ];
				postInstall = (oldAttrs.postInstall or "") + ''
					wrapProgram $out/bin/dolphin \
					--set XDG_CONFIG_DIRS "${prev.libsForQt5.kservice}/etc/xdg:$XDG_CONFIG_DIRS" \
					--run "${kprev.kservice}/bin/kbuildsycoca6 --noincremental ${prev.libsForQt5.kservice}/etc/xdg/menus/applications.menu"
				'';
			});
		});
	})
];

nix.settings.extra-experimental-features = "nix-command";

programs = {
	appimage.enable = true;
	bat.enable = true;
	dconf.enable = true;
	firefox = {
		enable = true;
		package = pkgs.librewolf;
		languagePacks = ["en-US"];
	};
	gamescope = {
		enable = true;
		args = [
			"--rt"
			"--expose-wayland"
		];
	};
	hyprland = {
		enable = true;
		withUWSM = true;
	};
	hyprlock.enable = true;
	neovim = {
  		enable = true;
		defaultEditor = true;
		vimAlias = true;
	};
	nh = {
		enable = true;
	};
	nix-ld.enable = true;
	obs-studio.enable = true;
	steam = {
		package = pkgs.steam.override {
			extraPkgs = pkgs: with pkgs; [
				SDL2
				gamemode
				gtk3
				keyutils
				libglvnd
				libjpeg
				libkrb5
				libpng
				libpulseaudio
				libvorbis
				mono
				openal
				posy-cursors
				stdenv.cc.cc.lib
				xorg.libXScrnSaver
				xorg.libXcursor
				xorg.libXi
				xorg.libXinerama
			];
			extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
		};
		enable = true;
		dedicatedServer.openFirewall = true;
		localNetworkGameTransfers.openFirewall = true;
		remotePlay.openFirewall = true;
		protontricks.enable = true;
		extraCompatPackages = with pkgs; [
			proton-ge-bin
		];
	};
	thunderbird.enable = true;
	ydotool = {
		enable = true;
		group = "wheel";
	};
	zoxide = {
		enable = true;
		enableZshIntegration = true;
	};
	zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		interactiveShellInit = "source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh";
	};
};

qt = {
	enable = true;
	platformTheme = "qt5ct";
};

security = {
	doas = {
		enable = true;
		extraRules = [{
			groups = [ "wheel" ];
			keepEnv = true;
			persist = true;
			noLog = true;
		}];
	};
	pam.services = {
		greetd.enableGnomeKeyring = true;
		hyprlock.text = "auth include login";
	};
	polkit = {
		enable = true;
		extraConfig = ''
			polkit.addRule(function(action, subject) {
				if (
					subject.isInGroup("users") && (
						action.id == "org.freedesktop.login1.reboot" ||
						action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
						action.id == "org.freedesktop.login1.power-off" ||
						action.id == "org.freedesktop.login1.power-off-multiple-sessions"
					)
				)
				{
					return polkit.Result.YES;
				}
			}
			)
		});
		'';
	};
	rtkit.enable = true;
	sudo.enable = lib.mkForce false;
};

services = {
	ananicy = {
		enable = true;
		package = pkgs.ananicy-cpp;
		rulesProvider = pkgs.ananicy-rules-cachyos;
	};
	dbus.implementation = "broker";
	earlyoom = {
		enable = true;
		enableNotifications = true;
		freeMemThreshold = 1;
		reportInterval = 0;
		extraArgs = [
			"--avoid"
			"'(^|/)(pipewire|wireplumber|pipewire-pulse|firefox|.firefox-wrapped|.librewolf-wrapped|librewolf|floorp|.floorp-wrapped|chromium|wfica|Xwayland|teams-for-linux|alacritty|nvim|hx|sunsetr|easyeffects|.easyeffects-wrapped|swayidle|hyprland-autoname-workspaces|wljoywake)$'"
			"--ignore"
			"'(^|/)(init|systemd|Hyprland|.Hyprland-wrapped|dbus-broker|dbus-broker-launch|earlyoom|mako|waybar|.waybar-wrapped)$'"
		];
	};
	flatpak.enable = true;
	fstrim.enable = true;
	fwupd.enable = true;
	gnome.gnome-keyring.enable = true;
	greetd = {
		enable = true;
		settings = rec {
			default_session = {
				command = "${pkgs.wl-restart}/bin/wl-restart -n 20 ${config.programs.hyprland.package}/bin/Hyprland > /dev/null";
				user = config.services.getty.autologinUser;
			};
		};
	};
	gvfs = {
		enable = true;
		package = pkgs.gvfs;
	};
	journald.storage = "none";
	kanata = {
		enable = true;
		keyboards.all = {
			config = builtins.readFile (./. + "/main.kbd") + builtins.readFile (./. + "/chords.kbd");
			extraDefCfg = ''
				process-unmapped-keys false
				concurrent-tap-hold yes
				linux-device-detect-mode keyboard-only
				linux-dev-names-exclude (
					"ZSA Technology Labs Ergodox EZ"
					"CharaChorder CharaChorder Two S3 Keyboard"
					"Paris Commune Keyboard"
					"Kathakali's S21+ Keyboard"
					"ydotoold virtual device"
					"Eee PC WMI hotkeys"
				)
			'';
			port = 52612;
		};
	};
	kmscon = {
		enable = true;
		hwRender = true;
		autologinUser = config.services.getty.autologinUser;
	};
	libinput = {
		mouse = {
			accelProfile = "flat";
			additionalOptions =
				''
					Option "HighResolutionWheelScrolling" "true"
				'';
		};
		touchpad = {
			accelProfile = "adaptive";
			tapping = true;
			tappingButtonMap = "lmr";
		};
	};
	logind.settings.Login = {
		HandleLidSwitch = "ignore";
		HandlePowerKey = "ignore";
		HandlePowerKeyLongPress = "poweroff";
	};
	pipewire = {
		alsa = {
			enable = true;
			support32Bit = true;
		};
		enable = true;
		jack.enable = true;
		pulse.enable = true;
	};
	playerctld.enable = true;
	power-profiles-daemon.enable = true;
	systembus-notify.enable = true;
	udev.extraRules = ''
		SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="0", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
		SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_ONLINE}=="1", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"
	'';
	upower = {
		enable = true;
		usePercentageForPolicy = true;
#		timeLow = 2160;
#		timeCritical = 1080;
#		timeAction = 540;
		percentageLow = 20;
		percentageCritical = 5;
		percentageAction = 2;
		criticalPowerAction = "Suspend";
		allowRiskyCriticalPowerAction = true;
		noPollBatteries = true;
	};
};

systemd = {
	settings.Manager.DefaultTimeoutStopSec = "10s";
	user.services.polkit-gnome-authentication-agent-1 = {
		after = [ "graphical-session.target" ];
		description = "polkit-gnome-authentication-agent-1";
		serviceConfig = {
			ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
			Restart = "on-failure";
			RestartSec = 1;
			TimeoutStopSec = 10;
			Type = "simple";
		};
		wantedBy = [ "graphical-session.target" ];
		wants = [ "graphical-session.target" ];
	};
};

users.defaultUserShell = pkgs.zsh;

xdg = {
	icons.fallbackCursorThemes = [ "Posy_Cursor_Black" ];
	portal = {
		config = {
			common = {
				default = ["gtk" "hyprland"];
				"org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
			};
		};
		enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk
		];
		xdgOpenUsePortal = true;
	};
};
}
