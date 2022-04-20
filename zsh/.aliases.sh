
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

alias flx='amm ~/meshapp/aws-tools/scripts/deploy.sc'
