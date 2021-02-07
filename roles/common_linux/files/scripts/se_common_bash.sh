# by dnobori
alias root='sudo -H -i -u root bash'
alias en='sudo -H -i -u root bash'
alias reboot='echo Rebooting forcefully. Syncing... ; sync ; sync ; sync ; echo Sync OK. Rebooting... ; sleep 0.5 ; /sbin/reboot --force'
alias rebootbios='echo Rebooting forcefully 2. Syncing... ; sync ; sync ; sync ; echo Sync OK. Rebooting with BIOS... ; sleep 0.5 ; echo 1 > /proc/sys/kernel/sysrq ; echo b > /proc/sysrq-trigger ; echo Perhaps triggered'
alias svcrunning='systemctl list-units --type=service'
alias svcall='systemctl list-unit-files --type=service --no-pager'
alias svcstart='systemctl start'
alias svcstop='systemctl stop'
alias svcrestart='systemctl restart'
alias svcenable='systemctl enable'
alias svcdisable='systemctl disable'
alias svcstat='systemctl status --no-pager'
alias svcstat2='systemctl status -l --no-pager'
alias cpus='mpstat -P ALL 1'
alias loads='dstat --nocolor --float --bits -tclmnd --socket'
alias socks='watch -n 1 cat /proc/net/sockstat'
alias netst='netstat -Wap -46'
alias netstn='netstat -Wap -46 -n'
alias listen='netst -n | grep -F -i -e LISTEN -e "0.0.0.0" -e ":::" | grep -F -i -e tcp -e ud'
alias ios='iostat -dmxt 1'
alias fpath='readlink -f'
alias proc='ps ww -H -eo pid,lstart,wchan,time,vsize,rssize,stat,tname,euser,pcpu,pid,thcount,cmd'
alias thread='ps ww -m -eo pid,lstart,wchan,time,vsize,rssize,stat,tname,euser,pcpu,thcount,lwp,cmd'
alias lxclist='lxc list -c nsN46lc,boot.autostart:boot,volatile.last_state.power:last'
alias readlog='journalctl -xe -n 10000'
alias readlogall='journalctl -xe -n all'
alias readlogf='journalctl -f'

function lxcsetboot()
{
  command lxc config set $1 boot.autostart true
}

function lxcdisableboot()
{
  command lxc config set $1 boot.autostart false
}

function lxcunsetboot()
{
  command lxc config unset $1 boot.autostart
}

function sortdir() {
  command du -x -h -d 1 $@ | sort -h
}

function ff() {
  command find $2 -iname "*$1*" $3 $4 $5 $6 $7 $8 $9 | xargs -n 1 -r -P 1 -IXXX ls --color=auto --time-style="+%Y/%m/%d %H:%M:%S" -apd1h XXX
}

function fff() {
  command find $2 -iname "*$1*" $3 $4 $5 $6 $7 $8 $9 | xargs -n 1 -r -P 1 -IXXX ls --color=auto --time-style="+%Y/%m/%d %H:%M:%S" -lapd1h XXX
}

function tt() {
  command find $3 -type f -print -iname "*$2*" | xargs grep -F -i -n $1
}

# same to .bashrc
alias ls='ls --color=auto --time-style="+%Y/%m/%d %H:%M:%S"'
alias emacs='emacs -nw'
export PS1='[\u@\h \w]\$ '
export EDITOR='emacs -nw'
export LANG=en_US.UTF-8
export TMOUT=268435456
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DEBIAN_FRONTEND=noninteractive
