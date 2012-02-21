echo Testing IOS

base=`dirname $0`
ecunittests="$base/../../Modules/ECUnitTests/Scripts"
source "$ecunittests/test-common.sh"

xcodebuild -target "ECFoundation Test iOS" -configuration "$testConfig" -sdk "$testSDKiOS" $testOptions | "$ecunittests/$testConvertOutput"


