echo Testing Mac

source "$base/share-test.sh"
targetMac="ECFoundation Test Mac"
sdkMac="macosx"

xcodebuild -target "$targetMac" $config -sdk "$sdkMac" build

