#!/bin/bash

PLIST="$1"
if [ "$PLIST" == "" ]; then
    PLIST="${TARGET_BUILD_DIR}/${INFOPLIST_PATH}"
fi

VERSION=`git log --oneline | wc -l`

# update the plist in the built app
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $VERSION" "$PLIST"

echo "Bumped build number to $VERSION in $PLIST"
