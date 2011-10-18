#!/bin/sh

# Build the target.
xcodebuild -target "ECFoundation Test Mac" -configuration Debug clean
xcodebuild -target "ECFoundation Test Mac" -configuration Debug build
xcodebuild -target "ECFoundation Test iOS" -configuration Debug clean
xcodebuild -target "ECFoundation Test iOS" -configuration Debug build

