#!/bin/bash

set -e

tag=$1

# Deployment is performed when $TRAVIS_TAG points to head of master.
# Below is a workaround to check this condition, since Travis doesn't
# fetch any reference object when a tag is pushed.

git clone https://github.com/snowplow/iglu-central.git tmp/iglu-central
cd tmp/iglu-central/
head_tags=$(git tag -l --points-at refs/heads/master)
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
    echo "Tag $tag does not point at master branch. You need to push master before the tag. Aborting deploy..."
    exit 1
fi
