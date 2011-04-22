if [ -f ${rvm_path}/contrib/ps1_functions ]; then
    . ${rvm_path}/contrib/ps1_functions
fi

ps1_user() {
  if [[ $UID -eq 0 ]]  ; then
    printf "\033[31m\\\u\033[0m"
  else
    printf "\033[32m\\\u\033[0m"
  fi

  printf "@\033[36m\\h\033[35m:\w\033[0m "

  return 0
}

PS1="$(ps1_user)\$(ps1_git)\$(ps1_rvm)\n\$(rvm-prompt u) "
