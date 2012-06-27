#!/bin/bash

rm /tmp/upload.log

TMP=/tmp/testflight-upload
LOG="${TMP}/upload.log"
ERROR_LOG="${TMP}/error.log"

rm "${LLOG}"
rm "${ERROR_LOG}"

mkdir -p "$TMP"
echo "Uploading..." > "${LOG}"
echo "" > "${ERROR_LOG}"

GIT=/usr/bin/git

APITOKEN=`defaults read com.elegantchaos.testflight-upload API_TOKEN`
if [[ "${APITOKEN}" == "" ]]; then
    echo "Need to set the TestFlight API token using 'defaults write com.elegantchaos.testflight-upload API_TOKEN <token>'" >> "${LOG}"
    exit 1
fi


# team token and distribution list are per-project settings, so should be passed in
TEAMTOKEN="$1"
DISTRIBUTION="$2"

# set this to true to show a confirmation dialog before doing the upload
CONFIRM_MESSAGE=false

# set this to true to use the git log as the default upload message
DEFAULT_MESSAGE_IS_GIT_LOG=true

MESSAGE=""

if $DEFAULT_MESSAGE_IS_GIT_LOG; then
    # use the git log since the last upload as the upload message
    MESSAGE=`cd "$PROJECT_DIR"; $GIT log --oneline testflight-upload..HEAD`
    if [[ $? != 0 ]]; then
        MESSAGE="first upload"
    fi

else
    # default to the last saved message
    if [ -e "${TMP}/upload.txt" ]; then
        MESSAGE=`cat ${TMP}/upload.txt`
    fi
fi

if $CONFIRM_MESSAGE; then
    # use applescript to ask about the upload
    MESSAGE=`osascript -e "tell application id \"com.apple.dt.Xcode\" to text returned of (display dialog \"Upload archive?\" default answer \"$MESSAGE\")"`
    if [[ $? != 0 ]] ; then
        echo "Upload cancelled" >> "${LOG}"
        exit 1
    fi
fi

# archive the last commit message, just in case we want it
echo "$MESSAGE" > "${TMP}/upload.txt"

SCRIPT_DIR=`dirname $0`

# make the ipa
echo "Making $EXECUTABLE_NAME.ipa as ${CODE_SIGN_IDENTITY}" >> "${LOG}"
APP="$ARCHIVE_PRODUCTS_PATH/Applications/$EXECUTABLE_NAME.app"
DSYM="$ARCHIVE_DSYMS_PATH/$EXECUTABLE_NAME.app.dSYM"
IPA="$TMPDIR/$EXECUTABLE_NAME.ipa"
XCROOT=`/usr/bin/xcode-select -print-path`
XCRUN="$XCROOT/usr/bin/xcrun"

echo "$XCRUN" -sdk iphoneos PackageApplication "$APP" -o "$IPA" --sign "${CODE_SIGN_IDENTITY}" --embed "${APP}/${EMBEDDED_PROFILE_NAME}" &> "${TMP}/xcrun.txt"

"$XCRUN" -sdk iphoneos PackageApplication "$APP" -o "$IPA" --sign "${CODE_SIGN_IDENTITY}" --embed "${APP}/${EMBEDDED_PROFILE_NAME}" &> "${TMP}/xcrun.log"

if [[ $? == 0 ]] ; then

        CURLLOG="${TMP}/curl.log"

        echo "Uploading to Test Flight with notes:" >> "${LOG}"
        echo "\"${MESSAGE}\"" >> "${LOG}"
        echo "" >> "${LOG}"
        echo "Distribution list ${DISTRIBUTION} will be mailed." >> "${LOG}"
        echo "" >> "${LOG}"

        zip -q -r "${DSYM}.zip" "${DSYM}"
        rm "$CURLLOG"
        curl http://testflightapp.com/api/builds.json --form file="@${IPA}" --form dsym="@${DSYM}.zip" --form api_token="${APITOKEN}" --form team_token="${TEAMTOKEN}" --form notes="${MESSAGE}" --form notify=True --form distribution_lists="${DISTRIBUTION}" -o "${CURLLOG}"
        CONFIG_URL=`"${SCRIPT_DIR}/extract-url.py" < "${CURLLOG}"`

        if [[ $? == 0 ]] ; then
            echo "Upload done." >> "${LOG}"
            open "${CONFIG_URL}"

            # update the git tag
            cd "$PROJECT_DIR";
            $GIT tag -f testflight-upload

            # clean up if the upload worked
            rm "${DSYM}.zip"
            rm "${IPA}"

        else
            echo "Test Flight returned error:" > "${ERROR_LOG}"
            cat "${CURLLOG}" >> "${ERROR_LOG}"
            open "${ERROR_LOG}"

        fi
else

    echo "Failed to build IPA"  >> "${ERROR_LOG}"
    open "${TMP}/xcrun.log"
    exit 1
fi


