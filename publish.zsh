#!/bin/zsh
# Check the site builds, then commit your changes and push them to GitHub.
# Usage: ./publish.zsh   (it always works in the folder it lives in)

set -e
cd "${0:A:h}"

# 1. Anything to publish?
if [[ -z "$(git status --porcelain)" ]]; then
  echo "No changes to publish."
  exit 0
fi

echo "These files have changed:\n"
git status --short
echo ""

# 2. Safety check: never publish placeholder keys over the real ones.
if grep -q "PASTE-" _config.yml; then
  echo "Stopping: _config.yml still contains a PASTE- placeholder."
  echo "Publishing it would break the contact form on the live site."
  exit 1
fi

# 3. Make sure the site builds before anything goes live.
echo "Checking the site builds..."
if ! bundle exec jekyll build --quiet; then
  echo "\nStopping: the site did not build. Fix the error above and try again."
  exit 1
fi
echo "Build OK.\n"

# 4. Ask for a description of the changes.
message=""
while [[ -z "$message" ]]; do
  read "message?Describe your changes in a few words: "
done

read "confirm?Publish these changes to the live site? [y/N] "
if [[ "$confirm" != [Yy]* ]]; then
  echo "Nothing published. Your changes are still here."
  exit 0
fi

# 5. Commit, collect any changes made on github.com, then push.
git add -A
git commit -m "$message"
git pull --rebase
git push

echo "\nPublished. The live site updates within a couple of minutes:"
echo "https://prepareforpeace.org.uk"
