#!/usr/bin/env sh

ARGS="--logfile=$LOGFILE"

if [ -n "$API_SOCKET" ]; then
  ARGS="$ARGS --api-server=$API_SOCKET"
fi

# Update the API socket's ownership
if [ -n "$API_SOCKET_UID_GID" ]; then
  watch_socket() {
    # TODO: find a more efficient way to do this
    while true; do
      chown "$API_SOCKET_UID_GID" "$API_SOCKET"
      sleep 10
    done
  }

  watch_socket &
fi

# Tail the logfile so we can see its contents via docker logs
if [ -n "$LOGFILE" ]; then
  tail_logs() {
    tail -f "$LOGFILE"
  }

  tail_logs &
fi

function finish {
  # Remove the API socket on exit
  if [ -n "$API_SOCKET" ]; then
    rm "$API_SOCKET"
  fi
}
trap finish EXIT

python /klipper/klippy/klippy.py "/klipper-config/printer.cfg" $ARGS $@
