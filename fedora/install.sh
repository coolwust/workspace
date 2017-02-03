#!/bin/sh

printf "(root) "
su -c 'sh root/install.sh'
sh user/install.sh
