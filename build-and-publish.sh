#!/bin/bash
JEKYLL_ENV=production jekyll build
git add --all
git commit -m 'build'
git push origin master