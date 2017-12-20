#!/bin/bash
if [ ! -e /etc/sudoers ]; then
    install -v -m400 /etc/sudoers.default /etc/sudoers
fi
