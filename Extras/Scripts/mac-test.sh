targetMac="ECFoundation Test Mac"
sdkMac="macosx"

echo Testing Mac
xcodebuild -target "$targetMac" $config -sdk "$sdkMac" build > /dev/null
xcodebuild -target "$targetMac" $config -sdk macosx build

