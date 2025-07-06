# tools
This repository is meant to hold a bunch of tools not requiring a full-fledged repository for themselves.

- [licman.sh: repo+branch LICENSE files manager](#licmansh-repobranch-license-files-manager)

## licman.sh: repo+branch LICENSE files manager

[licman.sh](licman.sh) is a simple tool to manage every **repo+branch → LICENSE** file.

Usage (two steps):

- **(1)** git-pull + local-edit + git-commit (safe):
```
$ ./licman.sh
```
- **(2)** git-push (may be dangerous since data is pushed to GitHub):
```
$ GIT_PUSH=1 ./licman.sh
```
Params example (env vars):
```
$ DEBUG=0 ACCOUNT=myaccount EMAIL=myemail REPOS="repo1 repo2 repo2 TDIR=/tmp/.licman-tmp ./licman.sh
```
Defaults:
```
$ cat licman.sh
(...)
DEBUG=${DEBUG:=1}
GIT_PUSH=${GIT_PUSH:=0}
ACCOUNT=${ACCOUNT:=sfmunoz}
EMAIL=${EMAIL:="46285520+sfmunoz@users.noreply.github.com"}
REPOS=${REPOS:="golang-playground nim-playground jekyll-playground ruby-playground rails-playground multi-tpl nextjs-dashboard postgres-image tools"}
TDIR=${TDIR:=/tmp/.licman}
(...)
```
