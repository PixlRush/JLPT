#!/bin/bash

BRANCH=$(git branch --show-current)
TAG=$(git describe --tags --abbrev=0 HEAD)
STEPS=$(git rev-list $TAG..HEAD --count)

echo "$BRANCH: $TAG-$((STEPS + 1))" > version.tex
