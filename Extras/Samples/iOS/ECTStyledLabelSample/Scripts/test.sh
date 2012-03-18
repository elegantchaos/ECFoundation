echo Testing iOS ECTStyledLabelSample

base=`dirname $0`
source "$base/../../../../Scripts/shared-test.sh"
targetIOS="ECTStyledLabelSample"

# build the framework

xcodebuild -target "$targetIOS" $config -sdk "$sdkIOS" clean build
