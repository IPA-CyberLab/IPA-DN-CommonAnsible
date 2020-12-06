# by dnobori
alias root='sudo -H -i -u root bash'
alias en='sudo -H -i -u root bash'
alias reboot='echo Rebooting forcefully ... ; sync ; sync ; sync ; sleep 0.5 ; /sbin/reboot --force'
alias svcrunning='systemctl list-units --type=service'
alias svcall='systemctl list-unit-files --type=service'
alias svcstart='systemctl start'
alias svcstop='systemctl stop'
alias svcrestart='systemctl restart'
alias svcenable='systemctl enable'
alias svcdisable='systemctl disable'
alias svcstat='systemctl status'
alias svcstat2='systemctl status -l'
alias cpus='mpstat -P ALL 1'
alias loads='dstat --nocolor --float --bits -tclmnd --socket'
alias socks='watch -n 1 cat /proc/net/sockstat'
alias ios='iostat -dmxt 1'
alias fpath='readlink -f'

# same to .bashrc
alias ls='ls --color=auto --time-style="+%Y-%m-%d %H:%M"'
alias emacs='emacs -nw'
export PS1='[\u@\h \w]\$ '
export EDITOR='emacs -nw'
export LANG=en_US.UTF-8
export TMOUT=268435456
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
