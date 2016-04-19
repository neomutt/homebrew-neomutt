#!/usr/bin/env sh
# Update the NeoMutt formula to use the tagged release given as an argument

USAGE="Usage: ./update_version.sh <tag>"
GITHUB_TAGREF_URL=https://api.github.com/repos/neomutt/neomutt/git/refs/tags/
GITHUB_TAG_URL=https://api.github.com/repos/neomutt/neomutt/git/tags/
FORMULA_PATH=Formula/neomutt.rb

# Require the first argument
if [ -z "$1" ]; then
  echo $USAGE
  exit
fi

# The first argument should be neomutt-<tag> or just <tag>
# Prepend neomutt- if it's not already present
if [[ "$1" == neomutt-* ]]; then
  TAG="$1"
else
  TAG="neomutt-$1"
fi


# Echo the JSON response from the URL argumnet
# Echo's a message if a resource was not found at the URL
get_json() {
  JSON=`curl --silent "$1"`
  if [[ "$JSON" == *"Not Found"* ]]; then
    echo "Could not find tag in neomutt repository"
    return
  fi
  echo $JSON
}

# Echo value of a key from a JSON response
# JSON as the first argument, key as the second
# Expects the key's value to be string
get_key() {
  echo `echo $1 | sed -E -n 's/.*"'$2'": "([a-z0-9]+)".*/\1/p'`
}

# First we get the hash of the tag *object*
JSON=`get_json "$GITHUB_TAGREF_URL$TAG"`
TAGREFSHA=`get_key "$JSON" sha`
# Then we get the hash of the commit the tag points to
JSON=`get_json "$GITHUB_TAG_URL$TAGREFSHA"`
TAGSHA=`get_key "$JSON" sha`

# Replace the tag and hash in the formula with that of the specified version
sed -E -i.bak '/url/ s/tag => "(.*)", :revision => "(.*)"/tag => "'$TAG'", :revision => "'$TAGSHA'"/' $FORMULA_PATH
# Remove the backup made by sed
rm $FORMULA_PATH.bak
