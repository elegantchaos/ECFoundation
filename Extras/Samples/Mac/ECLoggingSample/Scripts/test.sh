echo Testing Mac ECLoggingSample

base=`dirname $0`
source "$base/../../../../Scripts/shared-test.sh"
targetMac="ECLoggingSample"
sdkMac="macosx"

# build the framework

xcodebuild -target "$targetMac" $config -sdk "$sdkMac" clean build
