#!/bin/bash
export LEIN="lein update-in :local-repo str \"${M2_REPO:-.m2}\" --"

case "$1" in
    'bash')  exec bash ;;
    'repl')  exec $LEIN repl :headless \
                  :host 0.0.0.0 \
                  :port ${REPL_PORT:-5888} ;;
    *)       exec $LEIN $@ ;;
esac
