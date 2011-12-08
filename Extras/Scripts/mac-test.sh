echo Testing Mac

base=`dirname $0`
source "$base/shared-test.sh"
targetMac="ECFoundation Test Mac"
sdkMac="macosx"

xcodebuild -target "$targetMac" $config -sdk "$sdkMac" build

