stty erase ^H
if [ -f /etc/profile.d/se_common_bash.sh ]; then
    . /etc/profile.d/se_common_bash.sh
fi
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
alias ls='ls --color=auto'
alias emacs='emacs -nw'
export PS1='[\u@\h \w]\$ '
export EDITOR='emacs -nw'
export LANG=en_US.UTF-8
export TMOUT=268435456
export HISTFILESIZE=100000

if [ -f ~/.bashrc_addtional ]; then
    . ~/.bashrc_addtional
fi

