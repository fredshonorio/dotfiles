# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=howl
export VISUAL=howl
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export PATH="$PATH:/home/fred/.local/share/coursier/bin"
export PATH="$PATH:/home/fred/.bin"
# this workaround seems to be required for nix
export LOCALE_ARCHIVE="/lib/locale/locale-archive"

source ~/.zsh_plugins.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

source ~/.aliases.sh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

if [ -e /home/fred/.nix-profile/etc/profile.d/nix.sh ]; then . /home/fred/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
