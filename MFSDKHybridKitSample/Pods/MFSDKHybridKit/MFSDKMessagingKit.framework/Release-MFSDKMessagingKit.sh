echoTask()
{
echo ""
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)  TASK_PROGRESS$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)\t\t$1$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
echo "$(tput bold)$(tput setab 1)$(tput setaf 15)$(tput el)$(tput sgr0)"
}


#!/bin/bash
. build.properties

MF_BUILD_VERSION=$((MF_BUILD_VERSION))
MF_COMPLETEURL=${MF_BASEURL}${MF_BASE_VERSION}.${MF_BUILD_VERSION}${MF_FILEZIP}

echo "MF_BASE_VERSION=${MF_BASE_VERSION}" > build.properties
echo "MF_BUILD_VERSION=${MF_BUILD_VERSION}" >> build.properties
echo "MF_TEMPLATE_FILENAME=${MF_TEMPLATE_FILENAME}" >> build.properties
echo "MF_PODSPEC_FILENAME=${MF_PODSPEC_FILENAME}" >> build.properties
echo "MF_BASEURL='${MF_BASEURL}'" >> build.properties
echo "MF_FILEZIP='${MF_FILEZIP}'" >> build.properties
echo "MF_COMPLETEURL=${MF_BASEURL}${MF_BASE_VERSION}.${MF_BUILD_VERSION}${MF_FILEZIP}" >> build.properties

# Load the template podspec and replace version

TEMPLATE=$(cat "$MF_TEMPLATE_FILENAME" | sed "s,\[\[MF_TEMPLATE_VERSION\]\],${MF_BASE_VERSION}\.${MF_BUILD_VERSION},g;s,\[\[MF_TEMPLATE_BASEURL\]\],${MF_BASEURL},g;s,\[\[MF_TEMPLATE_FILE_ZIP\]\],${MF_FILEZIP},g")

echo "$TEMPLATE" > "${MF_PODSPEC_FILENAME}"

echo "$TEMPLATE"
#Here we get the current root directory of the project
CURR_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
COMPILER_OUTPUT="${CURR_DIRECTORY}/COMPILER_OUTPUT/"

#If directory $COMPILER_OUTPUT already exists, then delete it to have things clean
if [ -d "$COMPILER_OUTPUT" ]
then
rm -r "$COMPILER_OUTPUT"
fi

mkdir -p "$COMPILER_OUTPUT"
echoTask "CREATED COMPILER_OUTPUT DIRECTORY"

#to move to messaging kit project path , so that version can be automatically increased
cd ../../
xcrun agvtool new-marketing-version ${MF_BASE_VERSION}.${MF_BUILD_VERSION}

#to move to workspace path
cd ../

#device builds
xcodebuild -scheme MFSDKMessagingKit -workspace WebSDK.xcworkspace -sdk iphoneos -configuration Release build BUILD_DIR="${COMPILER_OUTPUT}/build" DEVELOPMENT_TEAM=S8ALLG76VY

echoTask "DEVICE BUILD DONE"

#simulator builds
xcodebuild -scheme MFSDKMessagingKit -workspace WebSDK.xcworkspace -sdk iphonesimulator -configuration Release build BUILD_DIR="${COMPILER_OUTPUT}/build" DEVELOPMENT_TEAM=S8ALLG76VY

echoTask "SIMULATOR BUILD DONE"

#universal builds
UNIVERSAL_OUTPUTFOLDER="${COMPILER_OUTPUT}/build/Release-universal"
DEVICE_OUTPUTFOLDER="${COMPILER_OUTPUT}/build/Release-iphoneos"
SIMULATOR_OUTPUTFOLDER="${COMPILER_OUTPUT}/build/Release-iphonesimulator"

mkdir -p "$UNIVERSAL_OUTPUTFOLDER"

for PROJECT_NM in "MFSDKMessagingKit"
do
cp -R "$DEVICE_OUTPUTFOLDER/$PROJECT_NM.framework" "$UNIVERSAL_OUTPUTFOLDER/"
lipo -create -output "$UNIVERSAL_OUTPUTFOLDER/$PROJECT_NM.framework/$PROJECT_NM" "$SIMULATOR_OUTPUTFOLDER/$PROJECT_NM.framework/$PROJECT_NM" "$DEVICE_OUTPUTFOLDER/$PROJECT_NM.framework/$PROJECT_NM"
done

echoTask "UNIVERSAL BUILD DONE"

cd "${COMPILER_OUTPUT}/build/Release-universal/"

zip -r MFSDKHybridKit.zip MFSDKMessagingKit.framework

echoTask "MFSDKHybridKit.zip CREATED"

cd "${COMPILER_OUTPUT}"

curl -umobile:AP4rEqYoNAZEY9YNKZWVTATEScuQ7QCvcBEbxp -T "${COMPILER_OUTPUT}/build/Release-universal/MFSDKHybridKit.zip" "${MF_COMPLETEURL}"

echoTask "UPLOAD TO ARTIFACTORY SUCCESS"

cd "${CURR_DIRECTORY}"
pod repo update --verbose

pod spec lint MFSDKHybridKit.podspec --allow-warnings
echoTask "POD VALIDATION DONE"

pod trunk push MFSDKHybridKit.podspec --allow-warnings
echoTask "POD RELEASE DONE"

if [ -d "$COMPILER_OUTPUT" ] && echoTask "DIRECTORY COMPILER_OUTPUT DELETED"
then
rm -r "$COMPILER_OUTPUT"
fi

echoTask "HAVE A GOOD DAY !"




