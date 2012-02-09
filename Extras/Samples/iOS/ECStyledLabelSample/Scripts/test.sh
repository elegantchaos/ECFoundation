echo Testing iOS ECStyledLabelSample

base=`dirname $0`
source "$base/../../../../Scripts/shared-test.sh"
targetIOS="ECStyledLabelSample"

# build the framework

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" clean build
