echo Testing iOS ECLoggingSample

base=`dirname $0`
source "$base/../../../../Scripts/shared-test.sh"
targetIOS="ECLoggingSample"

# build the framework

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" clean build
