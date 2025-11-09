setopt		INC_APPEND_HISTORY SHARE_HISTORY
setopt		APPEND_HISTORY
unsetopt	BG_NICE
setopt		CORRECT
setopt		EXTENDED_HISTORY
setopt		MENUCOMPLETE
setopt		ALL_EXPORT
setopt		HIST_SAVE_BY_COPY
setopt		notify globdots correct pushdtohome cdablevars autolist
setopt		correctall autocd recexact longlistjobs
setopt		autoresume histignoredups pushdsilent
setopt		autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt	bgnice autoparamslash
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done

### Set prompt
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="┌[%(!.${PR_RED}%2c.${PR_BLUE}%2c)$PR_NO_COLOR]%(?..[${PR_LIGHT_RED}%?$PR_NO_COLOR])%(!.${PR_LIGHT_RED}#.${PR_LIGHT_GREEN}
$PR_NO_COLOR└) "
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
unsetopt ALL_EXPORT

### Set alias
#############
alias ..='z ..'
alias bac="( doas nix-channel --rollback ; nix-channel --rollback ) && nh os switch -f '<nixpkgs/nixos>' || ( notify-send --urgency=low 'failed to roll back' ; pw-play --volume=0.2 '/run/current-system/sw/share/sounds/freedesktop/stereo/complete.oga' &! ) && ( notify-send --urgency=low 'Successfully rolled back' ; pw-play --volume=0.2 '/run/current-system/sw/share/sounds/freedesktop/stereo/complete.oga' &! )"
alias bt=bat
alias cat=bat
alias cd='z'
alias clients='hyprctl clients | nvim'
alias du=dua
alias gamesound="pactl load-module module-combine-sink sink_name='Stream' slaves='easyeffects_sink' && notify-send --urgency=low 'Added sink for streaming' &! "
alias gar="doas nix-env -e '.*' & nh clean all && ( notify-send --urgency=low 'Old images deleted' & pw-play --volume=0.2 '/run/current-system/sw/share/sounds/freedesktop/stereo/complete.oga' &! )"
alias hr="[[ \$(hyprctl monitors -j | jq -r '.[].name') == *HDMI-A-1* ]] && ( hyprctl reload ; hyprctl keyword monitorv2[HDMI-A-1]:disabled 0 ) || hyprctl reload"
alias ins="rg -qq 'environment.systemPackages = with pkgs; \[' /etc/nixos/$(cat /etc/hostname).nix || ( doas cp /etc/nixos/blank.nix /etc/nixos/$(cat /etc/hostname).nix ; echo 'Make sure to add your hostname.nix to the imports in /etc/nixos/configuration.nix' ) && doas nvim -u $HOME/.config/nvim/doasinit.vim /etc/nixos/$HOST.nix"
alias isomount="doas mount -o loop"
alias jq='jaq'
alias ll='eza -al'
alias ls=eza
alias nv=nvim
alias setupeverything="touch ~/.hushlogin & rm -rf /tmp/dotfiles ; git clone https://github.com/stiker-moises/dotfiles.git /tmp/dotfiles && rm -rf /tmp/dotfiles/.git && rm -rf /tmp/dotfiles/etc/nixos/configuration.nix ; doas chown -R $USER /tmp/dotfiles/.* ; doas cp -r /tmp/dotfiles/etc / && chmod -R 750 /tmp/dotfiles/.* && sd -f i 'username' $USER /tmp/dotfiles/.config/gtk-3.0/bookmarks & sd -f i 'username' $USER /tmp/dotfiles/.config/gtk-4.0/gtk.css ; touch -a /tmp/dotfiles/.config/hypr/$(cat /etc/hostname).conf ; chmod +x /tmp/dotfiles/.config/scripts/*.sh ; rm -rf /tmp/dotfiles/.git ; cp -r /tmp/dotfiles/.* ~/ ; xdg-user-dirs-update ; mkdir -p ~/Pictures/.clipboard/ & mkdir -p ~/.local/share/zsh/ & mkdir ~/Torrents & dconf write /org/gnome/desktop/interface/color-scheme \"'prefer-dark'\" & dconf write /org/gnome/desktop/wm/preferences/button-layout \"''\" & dconf write /com/github/wwmm/easyeffects/streaminputs/plugins \"['rnnoise#0', 'speex#0']\" & dconf write /com/github/wwmm/easyeffects/streaminputs/speex/0/enable-denoise false & dconf write /com/github/wwmm/easyeffects/streaminputs/speex/0/enable-dereverb false & dconf write /com/github/wwmm/easyeffects/streaminputs/speex/0/enable-vad true & dconf write /com/github/wwmm/easyeffects/streaminputs/process-all-outputs false & dconf write /com/github/wwmm/easyeffects/streaminputs/process-all-inputs true ; rm -rf /tmp/dotfiles ; zsh"
alias sl=eza
alias snv='doas nvim -u $HOME/.config/nvim/doasinit.vim'
alias sync='sync && ( notify-send --urgency=low "Sync completed" & pw-play --volume=0.2 "/run/current-system/sw/share/sounds/freedesktop/stereo/complete.oga" &! )'
alias ungamesound="pactl unload-module module-combine-sink && notify-send --urgency=low 'Removed sink for streaming' &!"
alias upd='doas nix-channel --update && nix-channel --update && nh os switch -f "<nixpkgs/nixos>" && nh clean all --keep 2 && notify-send --urgency=low "Update completed" >/dev/null || notify-send --urgency=low "Update Failed" >/dev/null ; pw-play --volume=0.2 /run/current-system/sw/share/sounds/freedesktop/stereo/complete.oga >/dev/null &!'
alias updatedots="rm -rf /tmp/dotfiles ; git clone https://github.com/stiker-moises/dotfiles.git /tmp/dotfiles && chown -R $USER /tmp/dotfiles/.* ; doas chmod -R 750 /tmp/dotfiles/.* && rm -rf /tmp/dotfiles/.config/Kvantum/kvantum.kvconfig & rm -rf /tmp/dotfiles/.local/share/kxmlgui5/gwenview/gwenviewui.rc & rm -rf /tmp/dotfiles/.config/okularpartrc & rm -rf /tmp/dotfiles/.config/QTalarm/ & rm -rf /tmp/dotfiles/.config/copyq & rm -rf /tmp/dotfiles/.config/galculator & rm -rf /tmp/dotfiles/.config/gtk-3.0 & rm -rf /tmp/dotfiles/.config/gtk-4.0 & rm -rf /tmp/dotfiles/.config/hypr/modules/2-theme.conf & rm -rf /tmp/dotfiles/.config/kdeglobals & rm -rf /tmp/dotfiles/.config/mako & rm -rf /tmp/dotfiles/.config/mimeapps.list & rm -rf /tmp/dotfiles/.config/mpv/ & rm -rf /tmp/dotfiles/.config/nvim/doasinit.vim & rm -rf /tmp/dotfiles/.config/nvim/init.vim & rm -rf /tmp/dotfiles/.config/qt5ct & rm -rf /tmp/dotfiles/.config/qt6ct & rm -rf /tmp/dotfiles/.config/wallpaper & rm -rf /tmp/dotfiles/.config/zim/ & rm -rf /tmp/dotfiles/.git & rm -rf /tmp/dotfiles/etc/nixos/configuration.nix ; cp -r /tmp/dotfiles/.* ~/ ; doas cp -r /tmp/dotfiles/etc / ; rm -rf /tmp/dotfiles ; zsh ; notify-send --urgency=low 'Dotfiles Updated' & pw-play --volume=0.2 '/run/current-system/sw/share/sounds/freedesktop/stereo/complete.oga' &!"
alias updatedotsoverwriteall="rm -rf /tmp/dotfiles ; git clone https://github.com/stiker-moises/dotfiles.git /tmp/dotfiles && chown -R $USER /tmp/dotfiles/.* ; doas chmod -R 750 /tmp/dotfiles/.* && rm -rf /tmp/dotfiles/.config/wallpaper & rm -rf /tmp/dotfiles/.config/zim/ & rm -rf /tmp/dotfiles/.git & rm -rf /tmp/dotfiles/etc/nixos/configuration.nix & sd -f i 'username' $USER /tmp/dotfiles/.config/gtk-3.0/bookmarks & sd -f i 'username' $USER /tmp/dotfiles/.config/gtk-4.0/gtk.css & sd -f i 'username' $USER /tmp/dotfiles/.config/deluge/gtk3ui.conf ; chmod +x /tmp/dotfiles/.config/scripts/*.sh && cp -r /tmp/dotfiles/.* ~/ && doas cp -r /tmp/dotfiles/etc / ; rm -rf /tmp/dotfiles ; dconf write /org/gnome/desktop/interface/color-scheme \"'prefer-dark'\" & dconf write /org/gnome/desktop/wm/preferences/button-layout \"''\" & dconf write /com/github/wwmm/easyeffects/streaminputs/plugins \"['rnnoise#0', 'speex#0']\" & dconf write /com/github/wwmm/easyeffects/streaminputs/speex/0/enable-denoise false & dconf write /com/github/wwmm/easyeffects/streaminputs/speex/0/enable-dereverb false & dconf write /com/github/wwmm/easyeffects/streaminputs/speex/0/enable-vad true & dconf write /com/github/wwmm/easyeffects/streaminputs/process-all-outputs false & dconf write /com/github/wwmm/easyeffects/streaminputs/process-all-inputs true ; zsh ; notify-send --urgency=low 'Dotfiles Overwritten' & pw-play --volume=0.2 '/run/current-system/sw/share/sounds/freedesktop/stereo/complete.oga' &!"

### Bind keys
autoload -U compinit
compinit
bindkey -e
bindkey '^?' backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '[[5~' up-line-or-history
bindkey '[[6~' down-line-or-history
bindkey '^[[A' history-substring-search-up
bindkey '^[OA' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OB' history-substring-search-down
bindkey '^r' history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.cache/zsh/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
	named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
	rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
	avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
	firebird gnats haldaemon hplip irc klog list man cupsys postfix\
	proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
	files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
	files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
	users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
	hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

#source /run/current-system/sw/share/zsh/plugins/nix/nix-zsh-completions.plugin.zsh
HISTFILE=~/.local/share/zsh/histfile
HISTSIZE=1024
SAVEHIST=4096
setopt autocd extendedglob
unsetopt beep nomatch
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
eval "$(zoxide init zsh)"
