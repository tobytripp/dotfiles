#!/bin/bash
# allows cleaning mozilla app databases for enhancing performance
username=$(whoami)

function check_app {
  proc="$(ps aux | grep $username | grep -v $0 | grep $1 | grep -v grep)"
  if [ "$proc" != "" ]; then
    echo "!!! Shutdown $1 first!"
    return 1
  fi
}

function vacuum_mozillas {
  echo "Vacuuming $1 in $2..."
  find $2 -type f -name '*.sqlite' -exec sqlite3 -line {} VACUUM \;
}

function run_mozillas {
  check_app $1
  if [ "$?" -ne "1" ]; then
    vacuum_mozillas $*
  fi
}

run_mozillas firefox ~/Personal/FirefoxProfile
#run_mozillas thunderbird ~/Personal/ThunderbirdProfile

echo 'Done!'
