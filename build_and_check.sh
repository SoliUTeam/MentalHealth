#!/bin/bash
# Set the path to your Xcode project
PROJECT_PATH="./MentalHealth.xcodeproj"

# Set the scheme name
SCHEME_NAME="MentalHealth"

# Set the build directory (optional)
BUILD_DIR="build"

# Set the build configuration (optional)
CONFIGURATION="Debug"

# Set the destination (optional)
DESTINATION="platform=iOS Simulator,name=iPhone 12"

# Build the project
xcodebuild \
    -project "$PROJECT_PATH" \
    -scheme "$SCHEME_NAME" \
    -configuration "$CONFIGURATION" \
    -destination "$DESTINATION" \
    -derivedDataPath "$BUILD_DIR" \
    -allowProvisioningUpdates \
    clean build

# Check if build succeeded
if [ $? -eq 0 ]; then
    echo "Build succeeded."
else
    echo "Build failed."
fi
