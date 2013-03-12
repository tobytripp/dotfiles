function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function check_git_changes {
  GREEN=$(tput setaf 2)
  RED=$(tput setaf 1)

  status=`git status 2> /dev/null | grep 'working directory clean' | wc -l`
  if [ $status -ne 1 ]; then
    echo $RED
  else
    echo $GREEN
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
  }

  svn_dir() {
    [ -d ".svn" ] || return 1
    VCS='svn'
    # while [ -d "$base_dir/../.svn" ]; do base_dir="$base_dir/.."; done
    # base_dir=`cd $base_dir; pwd`
    vcs_branch=$(svn info "$base_dir" | awk '/^URL/ { sub(".*/","",$0); r=$0 } /^Revision/ { sub("[^0-9]*","",$0); print r":"$0 }')

  }

  hg_dir() {
    base_dir=$PWD
    if [ -d "$base_dir/.hg" ]; then
      VCS="hg"
      vcs_branch=$(hg branch)
    fi
  }

  git_dir || svn_dir || hg_dir

  if [ -n "$VCS" ]; then
    __vcs_prefix="($VCS)"
    __vcs_branch_tag="[$vcs_branch]"
  else
    __vcs_prefix=''
    __vcs_branch_tag=''
  fi

  base_dir="$(basename "${base_dir}")"
  __cwd=${PWD/$HOME/'~'}
  __cwd="$(basename "${__cwd}")"
  __cwd=${__cwd/$base_dir/\/}
}
