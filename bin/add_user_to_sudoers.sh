#!/usr/bin/env bash

USER=$(whoami)

echo "${USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
