FROM openjdk:8

# Define Android tools version, home and paths
ENV ANDROID_SDK_TOOLS_VERSION="3859397"
ENV ANDROID_HOME="/opt/android-sdk"
ENV PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# Download and unzip android sdk
RUN apt-get -qq update && apt-get -qq -y install file build-essential

RUN echo "Installing sdk tools ${ANDROID_SDK_TOOLS_VERSION}" && \
    wget --quiet --output-document=android-sdk.zip \
    https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_VERSION}.zip && \
    mkdir --parents "$ANDROID_HOME" && \
    unzip -o -qq android-sdk.zip -d "${ANDROID_HOME}" && \
    rm --force android-sdk.zip && \
    mkdir --parents "$ANDROID_HOME/.android/" && \
    echo '### User Sources for Android SDK Manager' > "$ANDROID_HOME/.android/repositories.cfg" && \
    echo "Installing licenses" && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager --licenses > /dev/null && \
    echo "Installing platform 28" && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager "platform-tools" > /dev/null && \
    echo "Installing platform tools 28" && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager "platforms;android-28" > /dev/null && \
    echo "Installing build tools " && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager "build-tools;28.0.3" > /dev/null

RUN echo "Installing extras " && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager "extras;android;m2repository" > /dev/null && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager "extras;google;m2repository" > /dev/null && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager "extras;google;instantapps" > /dev/null

RUN echo "Installing ndk bundle" && \
    yes | "$ANDROID_HOME"/tools/bin/sdkmanager "ndk-bundle" > /dev/null