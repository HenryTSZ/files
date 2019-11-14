hello() {
  weather=$(curl wttr.in/?format="%E6%82%A8%E7%8E%B0%E5%9C%A8%E7%9A%84%E4%BD%8D%E7%BD%AE%E5%9C%A8:%20%l,%20%E5%A4%A9%E6%B0%94%E4%B8%BA:%20%C,%20%E6%B8%A9%E5%BA%A6%E4%B8%BA:%20%t,%20%E6%B9%BF%E5%BA%A6%E4%B8%BA:%20%h,%20%E9%A3%8E%E5%8A%9B%E4%B8%BA:%20%w,%20%E9%99%8D%E6%B0%B4%E4%B8%BA:%20%p&lang=zh" -#)
  me="亲爱的 $(whoami),"
  time="今天是 $(date "+%F %T %A"),"

  arr=('Hi!' ${me} ${time} ${weather})

  i=0
  l=${#arr[*]}
  while [ $i -le $l ]
  do
    if [ $i == $l ]
    then
      echo ${arr[$i]}
    else
      echo -e "${arr[$i]} \c"
    fi
    let "i++" 
    sleep 0.2
    wait
  done
}
hello

alias ll='ls -l'
alias .='cd ../'
alias ..='cd ../../'
alias ...='cd ../../../'

alias gl='git pull'
alias gaa='git add .'
alias gcmsg='git commit -m'
alias gcam='git commit -a -m'
alias gp='git push'
alias gco='git checkout'
alias gm='git merge'
alias gss='git status -s'
alias glol='git log –graph –pretty = format:’%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset’ –abbrev-commit'
alias grh='git reset HEAD'
alias gba='git branch -a'
alias gcf='git config –list'
alias gcl='git clone'
alias gd='git diff'
alias ghh='git help'

alias ni='npm i'
alias ns='npm run serve'
alias nb='npm run build'
alias nd='npm run dev'
