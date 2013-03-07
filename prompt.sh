if [ -f ${rvm_path}/contrib/ps1_functions ]; then
    . ${rvm_path}/contrib/ps1_functions
else
    . ~/.ps1_functions.sh
fi

export PROMPT_COMMAND="history -a; ps1_update --notime --prompt ∴"
#ps1_set --notime --prompt ∴
ps2_set
ps4_set
