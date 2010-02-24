source .bash_colors.sh

function parse_git_branch {
 git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function check_git_changes {
 var=`git status 2> /dev/null | sed -e '/(working directory clean)$/!d' | wc -l`
 if [ $var -ne 1 ]; then
  tput setaf 1 # red
 else
  tput setaf 2 # green
 fi
}

function detect_vcs {
  VCS=''
  git_dir() {
    base_dir=$(git rev-parse --show-cdup 2>/dev/null) || return 1
    VCS='git'

		if [ -n "$base_dir" ]; then
      base_dir=`cd $base_dir; pwd`
		else
			base_dir=$PWD
		fi
		
		vcs_branch=$(parse_git_branch)
		
    alias pull="git pull"
		alias commit="git commit -a"
		alias push="commit ; git push"
		alias revert="git checkout"
  }
  
  svn_dir() {
    [ -d ".svn" ] || return 1
    VCS='svn'
    while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
		base_dir=`cd $base_dir; pwd`
		vcs_branch=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')
		
		alias pull="svn up"
		alias commit="svn commit"
		alias push="svn ci"
		alias revert="svn revert"
  }
  
  git_dir || svn_dir
  
  if [ -n "$VCS" ]; then
		alias st="$VCS status"
		alias d="$VCS diff"
		alias up="pull"
		base_dir="$(basename "${base_dir}")"
		__vcs_prefix="($VCS)"
		__vcs_branch_tag="[$vcs_branch]"
	else
	  __vcs_prefix=''
	  __vcs_branch_tag=''
	fi
}

function prompt {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  
  PROMPT_COMMAND=detect_vcs
  PS1="\h:$GREEN\${__vcs_prefix}$BLUE\${base_dir}\$(check_git_changes)\${__vcs_branch_tag}$BLUE\W$NORMAL \$ "
  PS2='> '
  PS4='+ '
}
prompt

# PS1='\u@\h:$__vcs_prefix\[${_bold}\]\[${BLUE}\]${__vcs_base_dir}\[${_normal}\]${__vcs_ref}\[${BLUE}\]${__vcs_sub_dir}\[${_normal}\]\$ '
