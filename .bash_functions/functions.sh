# MY FUNCTIONS
fix_and_commit_shit() {
  fix_definitely_bad_shit
  if [ -z "$(git diff)" ]; then
    echo "no shit to fix"
  else
    commit_all_files
    log_chore_to_Jira
  fi
}

commit_all_files() {
  git add -A
  git commit -m "Shit Fixed"
}

copy_yamls() {
  ls config/*.yml.* | while read p; do cp $p $(echo $p | sed "s/yml.*/yml/g" ); done;
}

# RSpec bash scripts
rspec_low_level() {
  rspec spec/controllers/ spec/models/ spec/helpers/
}

rspec_high_level() {
  rspec spec/features
}

rspec_each() {
  find $1 -name '*_spec.rb' | while read p; do echo "" && echo -e "\033[31m$p\e[0m" && echo "" && rspec $p; done
}

lfs() {
  highlight_shit
  fix_definitely_bad_shit
  fix_shit_that_is_usually_bad
}

fix_shit_that_is_usually_bad() {
  fix_bad_pluck
  replace_be_success_tests
  replace_put_with_patch
  # todo: fix j render (sometimes I forget to put j)
  # todo: order of callbacks in model/controller
  # todo: syntax from Serge's docs
  # todo: hyphenated JS/CSS rather than camel cased
  # todo: speces around braces & operators
}

highlight_shit() {
  highlight_bad_haml
  highlight_bad_multiline_blocks
  highlight_curly_braces_inside_braces # question: should I remove all curly braces for hashes
  highlight_column_updates_in_specs
  highlight_multiline_specs # single line specs that should be multiline (not sure btw, sometimes I do need separate specs)
  highlight_js_inside_haml_files
  highlight_js_haml_files
  highlight_and_replace_new_shit
}

highlight_and_replace_new_shit() {
  grep ";" $(find . -name "*.rb") # don't use semiculumns in pure ruby
  pcregrep -MHn '^class.*\nend' $(find . -name "*.rb") # at least replace \n with ;, better - FooError = Class.new(StandardError)
  pcregrep -MHn 'def \w*; .+end' $(find . -name "*.rb") # avoid single line methods
  pcregrep -MHn 'def \w*\s*\nend' $(find . -name "*.rb") # avoid empty multiline methods (do def method; end)

  # todo: spaces around symbols
  # pcregrep -MHn '[^\s{]}' $(find . -name "*.rb")
  # rule changes, depending if word is surrounded by quotes, if it's emty hash etc

  # so it's like grep only within those strings that are not surrounded by quotes
  # break files into parts

  # remove spaces inside square braces
  egrep -l '\[\s.*\]' $(find . -name "*.rb") | while read p; do sed -i "s/\[\(\s\)\(.*\]\)/[\2/g" $p; done
  egrep -l '\[.*\s\]' $(find . -name "*.rb") | while read p; do sed -i "s/\(\[.*\)\(\s\)]/\1]/g" $p; done

  # remove spaces inside round braces
  egrep -l '\(\s.*\)' $(find . -name "*.rb") | while read p; do sed -i "s/(\(\s\)\(.*)\)/(\2/g" $p; done
  egrep -l '\(.*\s\)' $(find . -name "*.rb") | while read p; do sed -i "s/\((.*\)\(\s)\)/\1)/g" $p; done

  egrep "\s[a-z]+[A-Z]+" $(find . -name "*.rb") # show camelCase words

  # replace #order(shit: :asc) to #order(:asc)
  grep -Rl ": :asc" app/ | while read p; do sed -i "s/(\(.*\): :asc)/(:\1)/g" $p; done
}

fix_definitely_bad_shit() {
  add_semicolumns_to_js
  remove_selenium
  remove_focus
  remove_puts
  fix_old_hashes
  # todo: spaces in hashes
}

replace_put_with_patch() {
  grep -Rl "method: :put" app/ spec/ | xargs sed -i "s/method: :put/method: :patch/g"
  grep -Rl "put :" spec/controllers/ | xargs sed -i "s/put :/patch :/g"
}

fix_old_hashes() {
  egrep -Rl "([^:]):(\w+) =>" app/ spec/ | xargs sed -i "s/\([^:]\):\(\w\+\) =>/\1\2:/g"
}

highlight_js_inside_haml_files() {
  grep -Rn 'data-' app/views | grep -v 'stylesheet\|javascript'
}

highlight_column_updates_in_specs() {
  # todo: update_all
  grep -R "update_column" spec/
}

highlight_multiline_specs() {
  find spec/ -name '*.rb' | while read p; do pcregrep -MHn 'specify((?!build).)*(\n).*specify((?!build).)*' $p; done
}

highlight_js_haml_files() {
  find app/views -name '*.js.haml'
}

highlight_bad_haml() {
  grep -REn '%a|%input|%button|%img' app/views
}

highlight_bad_multiline_blocks() {
  grep -REn '{ expect|before {|it {|specify {' spec/ | grep -v '}'
  grep -Rn 'let' spec/ | grep '{' | grep -v '}'
}

highlight_curly_braces_inside_braces(){
  find app/ spec/ -name '*.rb' | while read p; do grep -H '({' $p; done
}

remove_focus() {
  grep -Rl ', :focus' spec/ | while read p; do sed -i "s/, :focus//g" $p; done
}

replace_be_success_tests() {
  grep -Rl be_success spec/ | while read p; do sed -i "s/be_success/render_template :create/g" $p; done
}

add_semicolumns_to_js() {
  find app/views/ -name '*.js.erb' | while read p; do sed -i 's/)\s*$/);/g' $p; done
}

fix_bad_pluck() {
  grep -Rl 'pluck(&:' app/ spec/ | while read p; do sed -i "s/pluck(&:/pluck(:/g" $p; done
}

add_selenium() {
  if [ -z "`grep selenium Gemfile`" ]; then
    sed -i "/group :test/ a gem 'selenium-webdriver'" Gemfile
    sed -i "/group :test/ a gem 'chromedriver-helper'" Gemfile
    sed -i "s/webkit/selenium/g" spec/support/capybara.rb
    echo "Capybara.register_driver :selenium do |app|" >> spec/support/capybara.rb
    echo "  Capybara::Selenium::Driver.new(app, :browser => :chrome)" >> spec/support/capybara.rb
    echo "end" >> spec/support/capybara.rb
    bundle
  fi
}

remove_selenium() {
  if [ -n "`grep selenium Gemfile`" ]; then
    sed -i '/selenium-webdriver/d' Gemfile
    sed -i '/chromedriver-helper/d' Gemfile
    bundle
    sed -i '$ d' spec/support/capybara.rb
    sed -i '$ d' spec/support/capybara.rb
    sed -i '$ d' spec/support/capybara.rb
    sed -i 's/selenium/webkit/g' spec/support/capybara.rb
  fi
}

remove_puts() {
  grep -Rwl 'puts' app/ spec/ lib/ | while read p; do sed -i '/\sputs\s/d' $p; done
}


# cool commands
# find spec/ -cmin -180 -type f | xargs rspec

deployable_branch() {
  awk < config/deploy/staging.rb '$2 ~ /branch/ { print $3 }' | sed /'.*'/p | sed "s/'//g" | sed -n 1p
}

git_rebase() {
  git rebase $(git rev-parse --abbrev-ref --symbolic-full-name @{u})
}

git_checkout() {
  git fetch
  git checkout $1
  git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
  while read local remote
  do
    if [[ "$1" == $local ]]; then
      if [ -n "`git diff $local $remote`" ]; then
        git_rebase
      fi
    fi
  done
}

sync_branches() {
  git fetch
  git for-each-ref --format="%(refname:short) %(upstream:short)" refs/heads | \
  while read local remote
  do
      [ -z "$remote" ] && git branch -D $local && continue

      if [ -n "`git diff $local $remote`" ]; then
        git checkout $local
        git_rebase
        if [[ "`deployable_branch`" == $local* ]]; then csd; fi
      fi
  done
}

generate_report() {
  git fetch
  git branch -r | \
  while read branch
  do
    if [ -n "`git checkout -b $(date | md5sum) $branch`" ]; then
      git log --pretty=format:'%s' --since='8 day ago' | grep "^\["
    fi
  done
}
