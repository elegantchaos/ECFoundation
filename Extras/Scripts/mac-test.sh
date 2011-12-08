echo Testing Mac

source "$base/shared-test.sh"
targetMac="ECFoundation Test Mac"
sdkMac="macosx"

xcodebuild -target "$targetMac" $config -sdk "$sdkMac" build

