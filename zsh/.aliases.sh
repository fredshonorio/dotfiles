
alias ap='readlink -e "$1"' # Absolute path of the argument
alias t='(wezterm start --cwd $PWD) &> /dev/null &'

# View logs of a container in an instance
# $ i-log <instance-index> <container-substring> [<docker logs options>]
#alias i-log='ssh "ecs-dev-$1" "docker logs $3 \$(docker ps --format \"{{.Names}}\t{{.ID}}\" | grep $2 | cut -f2)"'

yay-unused() {
    yay -Rns $(yay -Qtdq)
}

alias tpx='terraform plan -out x'
alias tax='terraform apply x'
alias tfmt='terraform fmt -recursive'
alias tss='terraform state show'
alias tsl='terraform state list | grep'
alias ti='terraform import'

alias list-sbt='jps | grep sbt-launch.jar | cut -f 1 -d " " | xargs pwdx'

# kill a java process
jpsk() {
    jps -l | awk '{
        # run pwdx for the first column, write the output to `wd`
        cmd = "pwdx "$1
        cmd | getline wd
        close(cmd)
        # pwdx prefixes the working directory with the pid, like "1234: /home/john", we remove it (modifying `wd` in-place)
        sub("[0-9]+: ", "", wd)
        # then append wd to the jps output
        print $0  " [" wd "]"
    }' | fzf --reverse -m -e -i | cut -d " " -f1 | xargs kill 2>/dev/null
}

# mod-init <module-name> <root-package>
mod-init() {
  [ "-z" "$1" ] && echo "Missing <module-name> and <root-package\n\nUsage: mod-init <module-name> <root-package>" && return -1
  [ "-z" "$2" ] && echo "Missing <root-package\n\nUsage: mod-init <module-name> <root-package>" && return -1
  mkdir -p modules/$1/src/main/scala/$2
  mkdir -p modules/$1/src/test/scala/$2
  mkdir -p modules/$1/src/it/scala/$2
}
