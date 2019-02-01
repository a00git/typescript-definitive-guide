#!/bin/bash

export WORKING_DIR=`pwd`

export CYAN_COLOR=\033[46m


echo " > [meta WorkingDir] $WORKING_DIR"
echo " [build WhatsIsNew] Start Build."

#remove hashed directory /dest
if [ -d $WORKING_DIR/dest ]; then
rm -r $WORKING_DIR/dest
echo "$CYAN_COLOR > delete dir /dest"
fi

#build book
cross-env NODE_ENV=production npm run build

#copy app
git clone --depth=1 --branch=gh-pages   https://${GITHUB_TOKEN}@github.com/$TRAVIS_REPO_SLUG.git app



#remove prev book files
if [ -d $WORKING_DIR/app/whats-is-new ]; then
rm -r $WORKING_DIR/app/whats-is-new
echo "$CYAN_COLOR > delete dir whats-is-new from app"
fi

#copy book, images and app
cp -rf $WORKING_DIR/app/. $WORKING_DIR/dest
#cp -rf $WORKING_DIR/images $WORKING_DIR/dest/whats-is-new

echo "$CYAN_COLOR [build WhatsIsNew] Complete Build."
