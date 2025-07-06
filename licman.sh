#!/bin/bash
#
# Author: 46285520+sfmunoz@users.noreply.github.com
# URL:    https://github.com/sfmunoz/tools
# Date:   Sun Jul 06 09:27:41 UTC 2025
#

set -e

DEBUG=${DEBUG:=1}
GIT_PUSH=${GIT_PUSH:=0}
ACCOUNT=${ACCOUNT:=sfmunoz}
EMAIL=${EMAIL:="46285520+sfmunoz@users.noreply.github.com"}
REPOS=${REPOS:="golang-playground nim-playground jekyll-playground ruby-playground rails-playground multi-tpl nextjs-dashboard postgres-image tools"}
TDIR=${TDIR:=/tmp/.licman}

COPY_OLD="Copyright (c) 2025 $ACCOUNT"
COPY_NEW="Copyright (c) 2025 $EMAIL"

debug() {
    if [ "$DEBUG" = "1" ]
    then
      set -x
      "$@"
      { set +x; } 2>/dev/null
    else
      "$@"
    fi
}

debug mkdir -p "$TDIR"
debug chmod 700 "$TDIR"
debug cd "$TDIR"

for REPO in $REPOS
do
  echo "==== $REPO ===="
  URL="git@github.com:${ACCOUNT}/${REPO}.git"
  if [ -d "$REPO" ]
  then
    echo "'$URL' already cloned"
  else
    debug git clone $URL
  fi
  debug cd $REPO
  if [ "$GIT_PUSH" != "1" ]
  then
    debug git config user.name "$ACCOUNT"
    debug git config user.email "$EMAIL"
  fi
  for B in $(git branch -a | awk '/remotes\/origin\// { b=substr($1,16) ; if ( b != "HEAD" ) print b }' | sort)
  do
    if [ "$GIT_PUSH" = "1" ]
    then
      debug git push origin $B
      continue
    fi
    debug git checkout $B
    debug awk -v O="${COPY_OLD}" -v N="$COPY_NEW" '{ if ( $0 == O ) print N ; else print $0 }' LICENSE > LICENSE.new
    debug mv LICENSE.new LICENSE
    debug git add LICENSE
    debug git commit -m "LICENSE copyright account replaced by github email"
  done
  debug git checkout main
  debug cd ..
  echo "---- $REPO ----"
done
