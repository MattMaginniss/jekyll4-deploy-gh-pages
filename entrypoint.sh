#!/bin/bash
export NVM_DIR=~/.nvm
source ~/.nvm/nvm.sh

set -e

DEST="${JEKYLL_DESTINATION:-_site}"
REPO="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
BRANCH="gh-pages"
BUNDLE_BUILD__SASSC=--disable-march-tune-native

echo "Installing gems..."
npm i
bundle config path vendor/bundle
bundle install --jobs 4 --retry 3

echo "Building Jekyll site..."

if [ ! -z $YARN_ENV ]; then
  echo "Installing javascript packages..."
  yarn
fi

JEKYLL_ENV=production NODE_ENV=production bundle exec jekyll build

echo "Publishing..."

cd ${DEST}

echo "initialized..."
git init
echo "name config..."
git config user.name "${GITHUB_ACTOR}"
echo "email config..."
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
echo "add..."
git add .
echo "commit..."
git commit -m "published by GitHub Actions"
echo "pushing..."
git push --force ${REPO} master:${BRANCH}
echo "done!"