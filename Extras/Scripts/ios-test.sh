targetIOS="ECFoundation Test iOS"
sdkIOS="iphonesimulator"

echo Testing IOS
xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" build > /dev/null
xcodebuild -target "$targetIOS" $config -sdk iphonesimulator build


