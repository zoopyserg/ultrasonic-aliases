alias u='sudo apt -qq update -y && sudo apt -qq upgrade -y && sudo apt -qq autoremove -y'
alias s='git status'
alias b='git branch'
alias l='git log --graph --oneline'
alias a='git add -A'
alias c='git commit'
alias co='git checkout'
alias ca='git commit --amend --no-edit'
alias r='RUN_LONG_TESTS=true rspec .'
alias rp='rake parallel:spec'
alias rpf='rake parallel:spec[^spec/features]'
alias rf='rspec --tag focus '
alias bu='bundle'
alias rse='bin/rails db:environment:set RAILS_ENV=development'
alias dbrst='bin/rails db:reset'
alias dbrstt='bin/rails db:reset RAILS_ENV=test'
alias st='git stash'
alias sta='git stash apply'

alias cleartmp='rm -rf ./tmp/*'

alias src='source ~/.bashrc'

alias rs='rails server --binding=0.0.0.0'
alias rc='rails console'
alias dbc='rails db:create'
alias dbm='rails db:migrate'
alias dbt='rails db:test:prepare'
alias dbd='rails db:drop'
alias dbs='rails db:seed'
alias pdbd='rails parallel:drop'
alias pdbc='rails parallel:create'
alias pdbm='rails parallel:load_schema'
alias rjcw='rake jobs:clear jobs:work'
alias rj='rake jobs:work'

alias pdb='pdbd && pdbc && pdbm'
alias pr='rake parallel:spec'
alias pdbr='bu && pdb && pr'

alias gib='gem install bundler'

alias dddb='rse && dbd && dbc && dbm && dbt && dbs'
alias ddb='rse && dbd && dbc && dbm && dbrst && dbrstt'
# alias db='rse && dbrst && dbrstt'

db() {
  echo '>> Setting environment'
  echo ''
  rse

  echo '>> Drop'
  echo ''
  dbd

  echo '>> Create'
  echo ''
  dbc

  echo '>> Get db/structure from main'
  echo ''
  git checkout main -- db/structure.sql

  echo '>> Schema load'
  echo ''
  rails db:schema:load

  echo '>> Reset db/structure'
  echo ''
  git reset db/structure.sql

  echo '>> Checkout db/structure'
  echo ''
  git checkout db/structure.sql

  echo '>> Migrate'
  echo ''
  dbm

  echo '>> Prepare test base'
  echo ''
  rails db:test:prepare

  echo '>> Seed'
  echo ''
  rails db:seed

  echo '>> Test seed'
  echo ''
  RAILS_ENV=test rails db:reset
}

dbbi() {
  echo '>> Setting environment'
  echo ''
  rse

  echo '>> Drop'
  echo ''
  dbd

  echo '>> Create'
  echo ''
  dbc

  echo '>> Migrate'
  echo ''
  dbm

  echo '>> Prepare test base'
  echo ''
  rails db:test:prepare

  echo '>> Get data from Binance'
  echo ''
  rake binance:setup
}

alias dbr='cleartmp && bu && db && r'
alias dbrs='bu && db && rs'
alias ddbrs='bu && ddb && rs'
alias d='git diff'
alias dn='git diff HEAD^ --name-only'
alias dh='git diff HEAD'
alias e='exit'
alias off='sudo poweroff'
alias gph='git push uc-dev-1 $(git rev-parse --abbrev-ref HEAD):main'
alias gpfh='git push --force uc-dev-1 $(git rev-parse --abbrev-ref HEAD):main'
alias gpfh5='git push --force uc-dev-5 $(git rev-parse --abbrev-ref HEAD):main'
alias gpf='git push --force'
alias gp='git push'
alias ho='heroku open'
alias jr='cd ~/Documents/Journal\ of\ Repetitions\ All\ Files/akadan/'
alias da='cd ~/Documents/Device\ Advice\ All\ Files/device-advice'
alias v='nvim'
alias vi='nvim'
alias rr='rails routes'
alias f='git fetch'
alias p='git pull'
alias ga='git add'
alias m='meld'
alias hc='heroku run rails c'
alias aca='a && ca'
alias ac='a && c'
alias gib='gem install bundler -v 2.3.26'
alias uninstallallgems="gem uninstall -aIx"
alias reinstallgems="uninstallallgems && gib && bu"
alias hl="heroku logs --tail --remote uc-dev-1"

if [ -f "/usr/share/bash-completion/completions/git" ]; then
  source /usr/share/bash-completion/completions/git
  __git_complete co _git_checkout
  __git_complete gp _git_push
  __git_complete ga _git_add
  __git_complete gpf _git_push
  __git_complete p _git_pull
else
  echo "Error loading git completions"
fi


makeprojectvirgin() {
  # git clean -x -d -f -n except .env
  git clean -x -d -f -n | grep -v .env | xargs rm -rf
  git reset --hard
  git checkout .
  git pull
  git status
}

findme() {
  git grep $1 c15-multibrand
}

avi_to_mp4() {
  # $1 is the avi file
  # $2 is the mp4 file
  ffmpeg -i $1 -c:v libx265 -crf 26 -preset fast -c:a aac -b:a 128k -x265-params lossless=1 -r 60 $2
}

# a function called ru() that will run rubocop -A against all files that were edited in this Git folder, excluding all file types that are not .rb and not .erb
ru() {
  git diff --name-only HEAD^ | grep -E '\.(rb|erb)$' | xargs rubocop -A
}

herokuresetdb() {
  heroku pg:reset --remote uc-dev-1
  heroku run rake db:schema:load --remote uc-dev-1
  heroku run "RAILS_ENV=test rake db:seed" --remote uc-dev-1
}

resetpasswords() {
  rails runner 'AdminUser.find_each{|u| u.update_attribute(:password, "123123a"); u.update_columns(encrypted_otp_secret: nil, otp_required_for_login: false); }'
  rails runner 'User.find_each{|u| u.update_attribute(:password, "123123a"); u.update_columns(encrypted_otp_secret: nil, otp_required_for_login: false); }'
}

herokuresetpasswords() {
  # server number variable - if $1 is present then $1, else 1
  server_number=${1:-1}

  heroku run rails runner 'AdminUser.find_each{|u| u.update_attribute(:password, "123123a"); u.update_columns(encrypted_otp_secret: nil, otp_required_for_login: false); }' --remote uc-dev-$server_number
  heroku run rails runner 'User.find_each{|u| u.update_attribute(:password, "123123a"); u.update_columns(encrypted_otp_secret: nil, otp_required_for_login: false); }' --remote uc-dev-$server_number
}

foo() {
  server_number=${1:-1}
  echo $server_number
}

replace_unsanitized() {
  grep -Rl unsanitized app/ | xargs sed -i "s/\.unsanitized/.instance_variable_get(:@filename)/g"
}

undo_replace_unsanitized() {
  grep -Rl ".instance_variable_get(:@filename)" app/ | xargs sed -i "s/\.instance_variable_get(:@filename)/.unsanitized/g"
}

fix_schema() {
  git checkout main -- db/structure.sql
  dbd
  dbc
  db
  dbm
}

# use gh cli to send a PR into main with the following format:
# title:
# feat: #code: lower case title
# body:
# Fixes #code



