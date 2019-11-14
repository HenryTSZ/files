# 加载.bashrc文件
if test -f ~/.bashrc; then
	source ~/.bashrc 
fi

# 折叠路径
function _fish_collapsed_pwd() {
    local pwd="$1"
    local home="$HOME"
    local size=${#home}
    [[ $# == 0 ]] && pwd="$PWD"
    [[ -z "$pwd" ]] && return
    if [[ "$pwd" == "/" ]]; then
        echo "/"
        return
    elif [[ "$pwd" == "$home" ]]; then
        echo "~"
        return
    fi
    [[ "$pwd" == "$home/"* ]] && pwd="~${pwd:$size}"
    if [[ -n "$BASH_VERSION" ]]; then
        local IFS="/"
        local elements=($pwd)
        local length=${#elements[@]}
        for ((i=0;i<length-1;i++)); do
            local elem=${elements[$i]}
            if [[ ${#elem} -gt 1 ]]; then
                elements[$i]=${elem:0:1}
            fi
        done
    else
        local elements=("${(s:/:)pwd}")
        local length=${#elements}
        for i in {1..$((length-1))}; do
            local elem=${elements[$i]}
            if [[ ${#elem} > 1 ]]; then
                elements[$i]=${elem[1]}
            fi
        done
    fi
    local IFS="/"
    echo "${elements[*]}"
}
function _getShortPwd() {
    echo -n `pwd | sed -e "s!$HOME!~!" | sed "s:\([^/]\)[^/]*/:\1/:g"`
}
function _getGitPS1() {
    git status > /dev/null 2>&1
    if [ $? == 0 ]; then
		local branch=`git branch | grep \* | cut -d ' ' -f2`
		status=`git status 2>&1 | tee`
		dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
		untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
		ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
		newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
		renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
		deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
		bits=''
		if [ "${renamed}" == "0" ]; then
			bits=">${bits}"
		fi
		if [ "${ahead}" == "0" ]; then
			bits="*${bits}"
		fi
		if [ "${newfile}" == "0" ]; then
			bits="+${bits}"
		fi
		if [ "${untracked}" == "0" ]; then
			bits="?${bits}"
		fi
		if [ "${deleted}" == "0" ]; then
			bits="x${bits}"
		fi
		if [ "${dirty}" == "0" ]; then
			bits="!${bits}"
		fi
		if [ ! "${bits}" == "" ]; then
			echo " $branch $bits"
		else
			echo " $branch"
		fi
        
    fi
}

PS1='\[\e[38;5;166m\]$(_getShortPwd)\[\e[0m\]\[\e[38;5;135m\] >\[\e[0m\]\[\e[38;5;118m\]$(_getGitPS1)\[\e[0m\] \$ '

# title show path
export PS1="\[\e]0;\w\a\]$PS1"
