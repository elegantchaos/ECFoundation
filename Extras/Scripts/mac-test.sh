echo Testing Mac

base=`dirname $0`
source "$base/shared-test.sh"
targetMac="ECFoundation Test Mac"

# build the framework

xcodebuild -target "$targetMac" $config -sdk "$sdkMac" clean build | "${base}/ocunit2junit.rb"