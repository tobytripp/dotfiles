SSH_ENV=$HOME/.ssh/environment

function start_agent {
   echo "Initializing new SSH agent..."
   /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
   echo succeeded
   
   chmod 600 ${SSH_ENV}
   . ${SSH_ENV} > /dev/null
   
   /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
   . ${SSH_ENV} > /dev/null
   ps -x | grep "^ *${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
     start_agent;
   }
else
   start_agent;
fi

HOSTFILE=~/.hosts

function _ssh() {
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}
  if [ "${cur:0:1}" != "-" ]; then
        COMPREPLY=( $(awk '/^Host '$2'/{print $2}' $HOME/.ssh/config) )
  fi            
  return 0
}

complete -F _ssh ssh sftp scp
complete -A hostname ssh sftp scp
