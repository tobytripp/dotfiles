source ~/.bash_boost/bash_colors.sh

function prompt {
    PROMPT_COMMAND=detect_vcs
    PS1="$GREEN\${__vcs_prefix}$CYAN\${base_dir}\[\$(check_git_changes)\]\${__vcs_branch_tag}$CYAN\${__cwd}$NORMAL \$ "
  # PS2='> '
  # PS4='+ '
}
prompt
