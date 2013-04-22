source ~/.bash_boost/bash_colors.sh

function prompt {
    PROMPT_COMMAND=detect_vcs
    INTERACTIVE_PROMPT="$GREEN\${__vcs_prefix}$CYAN\${base_dir}\[\$(check_git_changes)\]\${__vcs_branch_tag}$CYAN\${__cwd}$NORMAL \$ "
    NON_TTY_PROMPT='[\u@\h \W]\$ '
    if [[ $- =~ i ]]
    then
      PS1=$INTERACTIVE_PROMPT
    else
      PS1=$NON_TTY_PROMPT
    fi
  # PS2='> '
  # PS4='+ '
}
prompt
