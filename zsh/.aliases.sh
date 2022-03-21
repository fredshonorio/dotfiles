
alias ap='readlink -e "$1"' # Absolute path of the argument path
alias t='(kitty -d $PWD) &> /dev/null &'  

# Find containers in all the cluster
# $ c-ps <container-substring>
alias c-ps='pssh -h ~/.aws-hosts.txt -i "docker ps -a | grep $1"'

# View logs of a container in an instance
# $ i-log <instance-index> <container-substring> [<docker logs options>]
#alias i-log='ssh "ecs-dev-$1" "docker logs $3 \$(docker ps --format \"{{.Names}}\t{{.ID}}\" | grep $2 | cut -f2)"'

