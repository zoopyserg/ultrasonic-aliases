# Ultrasonic Aliases
Aliases that help you to work as fast as a jet plane on your Rails projects.

This saves you 5 minutes here, 3 minutes there, and when you sum up the time savings across a 1-year-long project with multiple people in a team, it saves up to 20% of project's budget.

Want to thank me?
Please support me on Patreon, I'll be happy: https://www.patreon.com/vinogradoff_group_tip_jar/

# Setup
````
curl -fsSL https://github.com/zoopyserg/ultrasonic-aliases/raw/main/.setup.sh | bash
````
(this will download aliases and vimrc to your $HOME directory and install Vundle)

Open Vim in a new tab and run:
````
:BundleInstall
````
to install the plugins, and you're good to go.

# Usage:
Obviously, after you `cd <into your project>`,

## Run the Rails server
(with all bundle installations, database create/migrate/test:prepare/seed etc):
````bash
> dbrs
````

## Run tests:
````bash
> dbr
````
Launches Bundle Install, (re)creates the database (drop/create/migrate/test:prepare/seed etc.) and runs `rspec .`.

Yes, it recreates the database and migrates again.

Gone are the days when a project with a 3-year-old commit history stops working because the old migrations broke and no one has time to fix them.

## Run tests even faster:
````bash
> r
````
Yes, just `r`. `rspec .` is too long.

To some, it sounds funny, but to a person who typed `rspec .` thousands of times this is a relief.

## Here are some other aliases:
````
s='git status'
b='git branch'
l='git log'
a='git add -A'
c='git commit'
ca='git commit --amend'
r='rspec .'
bu='bundle'
rs='rails server'
dbc='rails db:create'
dbm='rails db:migrate'
dbt='rails db:test:prepare'
dbd='rails db:drop'
dbs='rails db:seed'
db='dbd && dbc && dbm && dbt && dbs'
dbr='bu && db && r'
dbrs='bu && db && rs'
e='exit'
off='sudo poweroff'
````

Check out all aliases in `.aliases.sh` file.
The list is constantly growing.
