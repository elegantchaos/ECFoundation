echo Testing IOS

source "$base/shared-test.sh"
targetIOS="ECFoundation Test iOS"
sdkIOS="iphonesimulator"

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" build


