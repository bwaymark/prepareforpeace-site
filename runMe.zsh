#!/bin/zsh
# Copy downloaded site files into this folder, then start the local preview.
# Usage: ./runMe.zsh   (it always works in the folder it lives in)

set -e
cd "${0:A:h}"

# Default to the newest prepareforpeace-site folder in Downloads,
# including copies such as "prepareforpeace-site 6".
# (N) = no error if none, / = folders only, om = newest first.
matches=(~/Downloads/prepareforpeace-site*(N/om))
default_src=${matches[1]:-$HOME/Downloads/prepareforpeace-site}

echo "Copy new files from: $default_src"
read "answer?Is this the right folder? [Y/n] "

if [[ "$answer" == [Nn]* ]]; then
  read "src?Enter the folder to copy from (you can drag it into this window): "
  src=${src%% }            # drop the trailing space a drag-and-drop adds
  src=${src//\\/}          # drop backslashes before spaces from drag-and-drop
  src=${src/#\~/$HOME}     # expand a leading ~
else
  src=$default_src
fi

src=${src%/}/              # end in exactly one /, so rsync copies the contents

if [[ ! -d "$src" ]]; then
  echo "Folder not found: $src"
  exit 1
fi

echo "\nCopying from $src"
# _config.yml is never overwritten, so your keys stay safe.
rsync -av --exclude '_config.yml' "$src" .

echo "\nChanges compared with what is on GitHub:"
git status --short

echo "\nStarting preview at http://localhost:4000 (press Ctrl+C to stop)"
bundle exec jekyll serve --livereload --config _config.yml,_config.dev.yml
