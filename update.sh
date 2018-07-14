#!/bin/bash

VERSION=$1
if [ -z "$VERSION" ]; then
    echo "No version given"
    exit 1
fi

sed -i "s/version=\".*/version=\"$VERSION\" \\\/g" Dockerfile
sed -i "s/hugo_version=.*/hugo_version=$VERSION/g" Dockerfile

docker build -t lfkeitel/hugo:$VERSION .
docker tag lfkeitel/hugo:$VERSION lfkeitel/hugo:latest

sed -i "s/Hugo Version.*/Hugo Version\\*\\*: $VERSION/g" README.md

echo "Check built images and push to Docker Hub"
