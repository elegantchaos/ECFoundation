echo Testing iOS ECTTableBindingsSample

base=`dirname $0`
source "$base/../../../../Scripts/shared-test.sh"
targetIOS="ECTTableBindingsSample"

# build the framework

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" clean build
