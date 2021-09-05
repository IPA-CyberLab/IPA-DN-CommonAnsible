#!/bin/bash

find / -xdev -type f -path "*/var/cache/apparmor/*" -name "snap-confine.core.*" | xargs -n 1 -P 1 -IXXX rm -f XXX
find / -xdev -type f -path "*/var/cache/apparmor/*" -name "snap-confine.snapd.*" | xargs -n 1 -P 1 -IXXX rm -f XXX

find /vmdata1/ -xdev -type f -path "*/var/cache/apparmor/*" -name "snap-confine.core.*" | xargs -n 1 -P 1 -IXXX rm -f XXX
find /vmdata1/ -xdev -type f -path "*/var/cache/apparmor/*" -name "snap-confine.snapd.*" | xargs -n 1 -P 1 -IXXX rm -f XXX

