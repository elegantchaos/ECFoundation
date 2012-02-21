echo Testing Mac

base=`dirname $0`
ecunittests="$base/../../Modules/ECUnitTests/Scripts"
source "$ecunittests/test-common.sh"

xcodebuild -target "ECFoundation Test Mac" -configuration "$testConfig" -sdk "$testSDKMac" $testOptions | "$ecunittests/$testConvertOutput"