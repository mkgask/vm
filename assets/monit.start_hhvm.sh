#!/bin/bash

# This file should be saved in /usr/local/sbin
# It must exist because sometime a crashed process 
# leaves a socket behind, rendering it unstartable
# So what we do is test whether the socket file
# leftover is there and delete it. Also, make sure
# this file is executable: $ chmod +x start_hhvm.sh

SOCKET=/var/run/hhvm/hhvm.sock
if [ -e $SOCKET ];
then
  rm -f $SOCKET
fi

#/etc/init.d/hhvm start
/usr/sbin/service hhvm start
exit 0;
