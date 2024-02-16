#!/bin/bash
_kill_procs() {
  kill -TERM $formreturn_server
  wait $formreturn_server
  kill -TERM $xvfb
}
# Setup a trap to catch SIGTERM and relay it to child processes
trap _kill_procs SIGTERM
XVFB_WHD=${XVFB_WHD:-1280x720x16}
# Start Xvfb
Xvfb :99 -ac -screen 0 $XVFB_WHD -nolisten tcp &
xvfb=$!
export DISPLAY=:99
/home/formreturn/formreturn_server.sh $@ &
formreturn_server=$!
wait $formreturn_server
wait $xvfb