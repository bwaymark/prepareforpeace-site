#!/bin/zsh
# Copy downloaded site files into your site folder and/or start the local preview.
#
# Usage:
#   ./runMe.zsh               uses the folder you are in as the site folder
#   ./runMe.zsh ~/path/site   uses the folder you name as the site folder
#
# It looks in Downloads for the newest prepareforpeace zip file
# (for example prepareforpeace-site.zip) or unzipped prepareforpeace-site folder.

set -e

# 1. Where the site is (the destination).
if [[ -n "$1" ]]; then
  dest=${1/#\~/$HOME}
else
  dest=$PWD
fi
dest=${dest:A}

if [[ ! -f "$dest/_config.yml" ]]; then
  echo "Stopping: $dest does not look like the site folder (no _config.yml)."
  exit 1
fi

# 2. What to do.
echo "Site folder: $dest\n"
echo "  1) Copy new files, then preview"
echo "  2) Copy new files only"
echo "  3) Preview only"
read "choice?Choose 1, 2 or 3 [1]: "
choice=${choice:-1}

if [[ "$choice" != [123] ]]; then
  echo "Stopping: please choose 1, 2 or 3."
  exit 1
fi

# Unzip a zip file into a temporary folder and print the folder holding the site files.
unzip_to_temp() {
  local zip=$1
  tmp=$(mktemp -d -t prepareforpeace)
  unzip -q "$zip" -d "$tmp"
  rm -rf "$tmp/__MACOSX"
  if [[ -d "$tmp/prepareforpeace-site" ]]; then
    print -r -- "$tmp/prepareforpeace-site"
  else
    print -r -- "$tmp"
  fi
}

# 3. Copy, if asked.
if [[ "$choice" == [12] ]]; then
  # Newest prepareforpeace zip file or prepareforpeace-site folder in Downloads.
  # (N) = no error if none, om = newest first.
  default_src=""
  for f in ~/Downloads/prepareforpeace*(Nom); do
    if [[ -f "$f" && "$f" == *.zip ]] || [[ -d "$f" && "${f:t}" == prepareforpeace-site* ]]; then
      default_src=$f
      break
    fi
  done

  src=""
  if [[ -n "$default_src" ]]; then
    echo "\nNewest download found: $default_src"
    read "answer?Copy from this? [Y/n] "
    [[ "$answer" != [Nn]* ]] && src=$default_src
  else
    echo "\nNo prepareforpeace zip file or folder found in Downloads."
  fi

  if [[ -z "$src" ]]; then
    read "src?Enter the zip file or folder to copy from (you can drag it into this window): "
    src=${src%% }                    # drop the trailing space a drag-and-drop adds
    src=${src//\\/}                  # drop backslashes before spaces
    src=${src/#\~/$HOME}             # expand a leading ~
    src=${src:-$PWD}                 # nothing entered: use the folder you are in
  fi

  tmp=""
  if [[ -f "$src" && "$src" == *.zip ]]; then
    echo "Unzipping $src"
    src=$(unzip_to_temp "$src")
    tmp=${src%/prepareforpeace-site}
  elif [[ ! -d "$src" ]]; then
    echo "Stopping: not found, or not a zip file or folder: $src"
    exit 1
  fi
  src=${src:A}

  if [[ "$src" == "$dest" ]]; then
    echo "Stopping: the folder to copy from is the same as the site folder ($dest)."
    exit 1
  fi

  echo "\nCopying from $src to $dest"
  # _config.yml is never overwritten, so your keys stay safe.
  rsync -av --exclude '_config.yml' "$src/" "$dest/"

  # Tidy up the temporary unzip folder.
  [[ -n "$tmp" && -d "$tmp" ]] && rm -rf "$tmp"

  echo "\nChanges compared with what is on GitHub:"
  git -C "$dest" status --short
fi

# 4. Preview, if asked.
if [[ "$choice" == [13] ]]; then
  echo "\nStarting preview at http://localhost:4000 (press Ctrl+C to stop)"
  cd "$dest"
  bundle exec jekyll serve --livereload --config _config.yml,_config.dev.yml
fi
