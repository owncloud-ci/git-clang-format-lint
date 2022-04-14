#!/bin/sh

# temporary workaround to mitigate the impact of CVE-2022-24765
# https://github.blog/2022-04-12-git-security-vulnerability-announced/
# actions are run as root, but the .git dir is owned by some other (non-root user)
git config --global --add safe.directory /github/workspace

cd "$GITHUB_WORKSPACE"

diff=`git-clang-format --diff --commit $INPUT_BASE`
[ "$diff" = "no modified files to format" ] && exit 0
[ "$diff" = "clang-format did not modify any files" ] && exit 0

printf "\033[1mYou have introduced coding style breakages, suggested changes:\n\n"

echo "$diff" | colordiff
exit 1
