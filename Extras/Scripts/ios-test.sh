echo Testing IOS

base=`dirname $0`
source "$base/shared-test.sh"
targetIOS="ECFoundation Test iOS"
sdkIOS="iphonesimulator"

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" build | "${base}/ocunit2junit.rb"


