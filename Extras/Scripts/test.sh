#xcodebuild -workspace "ECFoundation.xcworkspace" -scheme "ECFoundation iOS" -sdk iphonesimulator build test

targetIOS="ECFoundation Test iOS"
targetMac="ECFoundation Test Mac"
sdkIOS="iphonesimulator"
sdkMac="macosx"
config="-configuration Debug"


echo Testing IOS
xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" build > /dev/null
xcodebuild -target "$targetIOS" $config -sdk iphonesimulator build

echo Testing Mac
xcodebuild -target "$targetMac" $config -sdk "$sdkMac" build > /dev/null
xcodebuild -target "$targetMac" $config -sdk macosx build

