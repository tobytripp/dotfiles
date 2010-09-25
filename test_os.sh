UNAME=`uname -a`
echo $UNAME
echo $UNAME | grep "Darwin"
if [[ $? -eq 0 ]] 
  then
    export DARWIN=true
    export LINUX=false
  else
    export LINUX=true
    export DARWIN=false
fi