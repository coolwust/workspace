#!/bin/sh

printf "(root) "
su -c 'sh root/install.sh'
sh -l user/install.sh
