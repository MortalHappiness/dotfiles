#!/usr/bin/env bash

set -exo pipefail

git fetch upstream

DEFAULT_BRANCH=$(git remote show upstream | grep "HEAD branch" | awk '{print $NF}')

git checkout -b origin-$DEFAULT_BRANCH --track origin/$DEFAULT_BRANCH
git reset --hard upstream/$DEFAULT_BRANCH
git push origin origin-$DEFAULT_BRANCH:$DEFAULT_BRANCH --force
git checkout spike/test
git branch -D origin-$DEFAULT_BRANCH
