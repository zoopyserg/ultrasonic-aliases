alias u='sudo apt -qq update -y && sudo apt -qq upgrade -y && sudo apt -qq autoremove -y'
alias s='git status'
alias b='git branch'
alias l='git log --graph --oneline --branches'
alias a='git add -A'
alias c='git commit'
alias co='git checkout'
alias ca='git commit --amend --no-edit'
alias r='rspec .'
alias rp='rake parallel:spec'
alias rpf='rake parallel:spec[^spec/features]'
alias rf='rspec --tag focus '
alias bu='bundle'
alias rse='bin/rails db:environment:set RAILS_ENV=development'
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

alias pdb='pdbd && pdbc && pdbm'
alias pr='rake parallel:spec'
alias pdbr='bu && pdb && pr'

alias db='rse && dbd && dbc && dbm && dbt && dbs'
alias dbr='bu && db && r'
alias dbrs='bu && db && rs'
alias d='git diff'
alias dh='git diff HEAD'
alias e='exit'
alias off='sudo poweroff'
alias gph='git push heroku $(git rev-parse --abbrev-ref HEAD):main'
alias gpfh='git push --force heroku $(git rev-parse --abbrev-ref HEAD):main'
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

findme() {
  git grep $1 c15-multibrand
}
