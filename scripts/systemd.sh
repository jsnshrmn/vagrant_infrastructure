#!/usr/bin/env bash

# If systemd is working, exit.
if systemctl -a
then
  exit 0
else
  # Fire up systemd if it's not happy
  nohup systemd --system --unit=basic.target > /root/$(hostname -f).systemd.log 2>&1 &

  # Disable the ssh service, since we're running sshd in the foreground
  # to keep our container running.
  systemctl disable ssh

  # systemd will write a nologin file since it is in an interesting state.
  # Wait for that file to show up so we can delete it.
  while [ ! -f /run/nologin ]
  do
    sleep 1
  done
  rm /run/nologin
fi
