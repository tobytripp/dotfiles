#!/bin/sh 

# osascript <<END 
#   tell app "Terminal" to do script "cd \"`pwd`\"" 
# END

osascript 2>/dev/null <<EOF
  tell application "System Events"
    tell process "Terminal" to keystroke "t" using command down
  end
  tell application "Terminal"
    activate
    do script with command "cd \"`pwd`\"" in window 1
  end tell
EOF
