top -ocpu -FR -l2 -n20 | grep '^....[1234567890] ' | grep -v ' 0.0% ..:' | cut -c 1-24,33-42,64-77