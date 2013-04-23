source ~/.bash_boost/bash_colors.sh

function prompt {
    PROMPT_COMMAND=detect_vcs
    REMOTE_LOGIN_PROMPT="$CYAN\u$NORMAL@$GREEN\h:$GREEN\${__vcs_prefix}$CYAN\${base_dir}\[\$(check_git_changes)\]\${__vcs_branch_tag}$CYAN\${__cwd}$NORMAL \$ "
    NON_TTY_PROMPT='[\u@\h \W]\$ '
    if [[ $- =~ i ]]
    then
      PS1=$REMOTE_LOGIN_PROMPT
    else
      PS1=$NON_TTY_PROMPT
    fi    
  # PS2='> '
  # PS4='+ '
}
prompt
