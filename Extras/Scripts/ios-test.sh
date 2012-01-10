echo Testing IOS

base=`dirname $0`
source "$base/shared-test.sh"
targetIOS="ECFoundation Test iOS"

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" clean build | "${base}/ocunit2junit.rb"


