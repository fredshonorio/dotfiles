
alias ap='readlink -e "$1"' # Absolute path of the argument
alias t='(wezterm start --cwd $PWD) &> /dev/null &'

# Find containers in all the cluster
# $ c-ps <container-substring>
alias c-ps='pssh -h ~/.aws-hosts.txt -i "docker ps -a --format \"table {{.ID}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\" | sed \"s/758826220996.dkr.ecr.eu-west-1.amazonaws.com\///\" | grep $1"'

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

alias flx='java -jar /home/fred/meshapp/flx/target/fat-jar/flx.jar'

alias list-sbt='jps | grep sbt-launch.jar | cut -f 1 -d " " | xargs pwdx'


# standup [<n-days>]
standup() {
    # git standup does not respect locales, and compares the value of the current day to "mon" to decide if it should adjust the date filter
    # it is never "mon" in my system, so on a monday i never see friday's commits
    # looking at the code it would seem that providing -w with my locale would work, but it doesn't

    # this script adjusts the -d paremeter on a monday, pins the author a cds into a directory

    AUTHOR="Fred Honorio"
    WORKDIR="/home/fred/meshapp"
    MONDAY="seg"
    ARG_D=""

    if [ -n "$1" ]; then
        ARG_D="-d $1"
    elif [ "$(date +%a)" = $MONDAY ]; then
        ARG_D="-d 4" # unsure why 4, 3 would make sense
    fi

    cd $WORKDIR
    git standup -s $ARG_D -a $AUTHOR -w "seg"
    cd -
}

# mod-init <module-name> <root-package>
mod-init() {
  [ "-z" "$1" ] && echo "Missing <module-name> and <root-package\n\nUsage: mod-init <module-name> <root-package>" && return -1
  [ "-z" "$2" ] && echo "Missing <root-package\n\nUsage: mod-init <module-name> <root-package>" && return -1
  mkdir -p modules/$1/src/main/scala/$2
  mkdir -p modules/$1/src/test/scala/$2
  mkdir -p modules/$1/src/it/scala/$2
}
