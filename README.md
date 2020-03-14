# Docker image for Android

[![docker icon](https://dockeri.co/image/faizaaslam/vend-android)](https://hub.docker.com/r/faizaaslam/vend-android/)
[![Build Status](https://travis-ci.com/faiza-aslam/android-docker-image.svg?branch=master)](https://travis-ci.com/faiza-aslam/android-docker-image)

It contains following components:

* OpenJDK 8
* Android sdk tools version 3859397
* Android sdk 28
* Android build tools 28.0.3
* Android ndk
* extras;android;m2repository
* extras;google;m2repository
* extras;google;instantapps

## Docker Build Image

    docker build -t android-image .

### Using image in Bitbucket pipeline

Here is an example of `bitbucket-pipelines.yml`

    image: faizaaslam/vend-android:latest

    pipelines:
      default:
        - step:
            name: Build Android Repository
            script:
              - chmod +x gradlew
              - ./gradlew clean assemble
            artifacts:
              - build/libs/**
