#!/bin/bash

find / -type f -path "*/var/cache/apparmor/*" -name "snap-confine.core.*" | xargs -n 1 -P 1 -IXXX rm -f XXX

find / -type f -path "*/var/cache/apparmor/*" -name "snap-snapd.core.*" | xargs -n 1 -P 1 -IXXX rm -f XXX

