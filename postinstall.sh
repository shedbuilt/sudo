#!/bin/bash
# Add wheel group for sudoers, if absent
getent group wheel
if [ $? -ne 0 ]; then
    groupadd -g 1001 wheel
fi
