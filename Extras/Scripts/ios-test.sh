echo Testing IOS

base=`dirname $0`
source "$base/../../../../Scripts/shared-test.sh"

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" clean build | "${base}/ocunit2junit.rb"


