#!/bin/bash

set -e

tag=$1

# deploy only if tag points to master branch

git clone https://github.com/snowplow/iglu-central.git tmp/iglu-central
cd tmp/iglu-central/
head_tags=$(git tag -l --points-at refs/remotes/origin/fix-gh-actions)
cd ../../
rm -rf tmp

exist="false"
for t in $head_tags
do
    if [ "$t" == "$tag" ]; then
        exist="true"
    fi
done

if [ "$exist" == "true" ]; then
    echo "Tag $tag points at master branch. Proceed to deploy..."
    exit 0
else
    echo "Tag $tag does not point at master branch. Aborting deploy..."
    exit 1
fi
