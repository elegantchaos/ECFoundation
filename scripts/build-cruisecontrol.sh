#!/bin/sh

# Build the target.
xcodebuild -target "ECFoundation SenTest" -configuration Debug clean
xcodebuild -target "ECFoundation SenTest" -configuration Debug build
