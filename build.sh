#! /bin/bash

#NOOP='true'
#DO_PUSH='true'
#NO_BUILD='true'

DOCKER_REPO="${DOCKER_REPO:-moonbuggy2000/phpmemcachedadmin}"

all_tags='latest'
default_tag='latest'

. "hooks/.build.sh"
