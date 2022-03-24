# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

LC_ALL=en_US.UTF-8

export EDITOR=howl
export VISUALEDITOR=howl

if [ -e /home/fred/.nix-profile/etc/profile.d/nix.sh ]; then . /home/fred/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

source ~/.zsh_plugins.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# This is temporary, should remove eventually
# https://github.com/NixOS/nixpkgs/issues/163374#issuecomment-1069598111
export NIX_PATH=$NIX_PATH:REPEAT=$HOME/.empty.nix

# stow (which is written in perl) is annoyed by locales
# https://unix.stackexchange.com/a/243189
export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"

source ~/.aliases.sh
