#!/usr/bin/env zsh

# https://til.hashrocket.com/posts/1tqyvzsa6y-using-zsh-functions-with-xargs

# delete branch and prompt for -D if it fails
# Usage: _branch-del <branch-name>
function _branch-del() {
  [ "-z" "$1" ] && echo "Missing <branch-name>" && return -1

  _branch="$1"

  if git branch -d $_branch;
  then
    echo "Branch $_branch deleted"
  else
    if read -q "reply?Delete branch with 'git branch -D'?[y/n]: "; then
      echo
      git branch -D $_branch
    else
      return -1
    fi
  fi
}


# delete git branches
_branch-del-fzf() {
  FUNC=$(functions _branch-del);
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))' | \
    fzf --reverse -m --ansi --header="Delete local branches (TAB and Shift-TAB to select/unselect multiple)" | \
    cut -d " " -f1 | \
    # workaround to xargs not seeing a locally defined function, this would be 'xargs _branch-del' otherwise
    xargs -I{} zsh -c "eval $FUNC; _branch-del {}"
}

_branch-del-fzf;
