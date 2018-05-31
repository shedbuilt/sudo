#!/bin/bash
# Install sudoers file, if absent
if [ ! -e /etc/sudoers ]; then
    install -vm400 /usr/share/defaults/etc/sudoers /etc/sudoers
fi
# Add wheel group for sudoers, if absent
getent group wheel
if [ $? -ne 0 ]; then
    groupadd -g 1001 wheel
fi
