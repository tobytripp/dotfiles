source ~/.bashrc

source ~/.bash_vcs.sh
source ~/.bash_login

source ~/.jumplist/j.sh

_mategem()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    local gems="$(gem environment gemdir)/gems"
    COMPREPLY=($(compgen -W '$(ls $gems)' -- $curw));
    return 0
}
complete -F _mategem -o dirnames mategem

##
# Your previous /Users/toby/.bash_profile file was backed up as /Users/toby/.bash_profile.macports-saved_2009-12-21_at_09:37:47
##

# MacPorts Installer addition on 2009-12-21_at_09:37:47: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# rvm-install added:
if [[ -s /Users/toby/.rvm/scripts/rvm ]] ; then source /Users/toby/.rvm/scripts/rvm ; fi

