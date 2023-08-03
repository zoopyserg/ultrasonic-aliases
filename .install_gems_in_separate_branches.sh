#!/bin/bash

# Read the Gemfile
while read -r line; do
  # Check if the line contains a gem definition
  if [[ $line == gem* ]]; then
    # Extract the gem name
    gem_name=$(echo $line | awk -F"'" '{ print $2 }')

    # Skip if gem name is 'rails' or empty
    if [[ $gem_name == 'rails' ]] || [[ -z $gem_name ]]; then
      continue
    fi

    # Remove version requirement and GitHub link requirement
    sed -i "/gem '$gem_name'/d" Gemfile
    echo "gem '$gem_name'" >> Gemfile

    # Create a new branch and switch into it
    git checkout -b "updating-gem-$gem_name"

    # Run bundle update for the gem
    bundle update $gem_name

    # Commit the changes
    git commit -am "Updating gem $gem_name"

    # Push the changes, setting the new branch as the upstream branch
    git push --set-upstream origin "updating-gem-$gem_name"

    # Switch back to the main branch
    git checkout main
  fi
done < Gemfile
