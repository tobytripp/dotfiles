if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then
  source "$HOME/.rvm/scripts/rvm" ;
fi

PS1="$YELLOW[\$(rvm-prompt v p g)]$NORMAL\$ $PS1"