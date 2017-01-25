#!/bin/sh

printf "(root) "
su -c 'sh scripts/root.sh'
sh scripts/user.sh
