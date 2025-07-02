typeset -U path cdpath fpath manpath
for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/ym75ziw5xry66p1cxfzkds4y86fp9rv8-zsh-5.9/share/zsh/$ZSH_VERSION/help"

## home-manager/antidote begin :
source /nix/store/ak532mi5l6cc3bawdhdwssy8f5aifk9h-antidote-1.9.10/share/antidote/antidote.zsh


bundlefile=/nix/store/w23a0b5r2f1b142xwb7zid7p99pnmam0-hm_antidote-files
zstyle ':antidote:bundle' file $bundlefile
staticfile=/tmp/tmp_hm_zsh_plugins.zsh-w23a0b5r2f1b142xwb7zid7p99pnmam0
zstyle ':antidote:static' file $staticfile

antidote load $bundlefile $staticfile

## home-manager/antidote end

autoload -U compinit && compinit
# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
unsetopt HIST_SAVE_NO_DUPS
unsetopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


export GPG_TTY=$TTY
/nix/store/llxp5n33a0l8fbhvhmgq5l8kvz8c887j-gnupg-2.4.7/bin/gpg-connect-agent --quiet updatestartuptty /bye > /dev/null
