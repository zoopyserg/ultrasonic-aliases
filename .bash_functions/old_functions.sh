# Prompt Setup

# Prompt Setup

# function minutes_since_last_commit {
# now=`date +%s`
# last_commit=`git log --pretty=format:'%at' -1`
# seconds_since_last_commit=$((now-last_commit))
# minutes_since_last_commit=$((seconds_since_last_commit/60))
# echo $minutes_since_last_commit
# }
#
# RED="\033[0;31m"
# YELLOW="\033[0;33m"
# GREEN="\033[0;32m"
# WHITE="\033[0;37m"
#
# git_prompt() {
# local g="$(__gitdir)"
# if [ -n "$g" ]; then
# local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
# if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
# local COLOR=${RED}
# elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
# local COLOR=${YELLOW}
# else
# local COLOR=${GREEN}
# fi
# local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m${WHITE}"
# # The __git_ps1 function inserts the current git branch where %s is
# local GIT_PROMPT=`__git_ps1 "(%s|${SINCE_LAST_COMMIT})"`
# echo ${GIT_PROMPT}
# fi
# }
#
# PS1="\n\W \$(git_prompt) → "
#!/bin/sh
# Opens the github page for the current git repository in your browser
# git@github.com:jasonneylon/dotfiles.git
# https://github.com/jasonneylon/dotfiles/

# function gh() {
#   giturl=$(git config --get remote.origin.url)
#   if [ "$giturl" == "" ]
#     then
#      echo "Not a git repository or no remote.origin.url set"
#      exit 1;
#   fi
#
#   giturl=${giturl/git\@github\.com\:/https://github.com/}
#   giturl=${giturl/\.git/\/tree/}
#   branch="$(git symbolic-ref HEAD 2>/dev/null)" ||
#   branch="(unnamed branch)"     # detached HEAD
#   branch=${branch##refs/heads/}
#   giturl=$giturl/tree/$branch
#   open $giturl
# }
