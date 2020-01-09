# MFSDKHybridKit

[![N|Solid](https://active.ai/wp-content/uploads/2019/03/aai_logo-min.png)](https://github.com/triniticloud/MFSDKNativeKitSample)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://github.com/triniticloud/MFSDKNativeKitSampler)

Morfeus enables financial institutions to deliver consumer services using Intuition and Automation over multiple natural channels of engagement. The Morfeus iOS hybrid SDK provides a lightweight conversational / messaging UX interface for users to interact to the Morfeus Platform. The SDK enables rich conversation components to be embedded in existing iOS Mobile Apps.

# Prerequisites

  - OS X (10.11.x)
  - Xcode 8.3 or higher
  - Deployment target - iOS 8.0 or higher

# Pod installation 

Install and configure dependencies
1. Install Cocoapods
CocoaPods is a dependency manager for Objective-C/Swift, which automates and simplifies the process of using 3rd-party libraries in your projects.  CocoaPods is distributed as a ruby gem, and is installed by running the following commands in Terminal App:

    $ sudo gem install cocoapods
    $ pod setup
2. Update .netrc file
    The Morfeus iOS SDK are stored in a secured artifactory. Cocoapods handles the process of linking these frameworks with the target application. When artifactory requests for authentication information when installing MFSDKHybridKit, cocoapods reads credential information from the file .netrc, located in ~/ directory.

    The .netrc file format is as explained: we specify machine(artifactory) name, followed by login, followed by password, each in separate lines. There is exactly one space after the keywords machine, login, password.

    machine <NETRC_MACHINE_NAME>
    login <NETRC_LOGIN>
    password <NETRC_PASSWORD>
    Steps to create or update .netrc file

    Start up Terminal in mac
    
    Type "cd ~/" to go to your home folder
    
    Type "touch .netrc", this creates a new file, If a file with name .netrc not found.
    
    Type "open -a TextEdit .netrc", this opens .netrc file in TextEdit
    
    Append the machine name and credentials shared by development team in above format, if it does not exist already.
    
    Save and exit TextEdit

3. Install the pod
    To integrate 'MFSDKHybridKit' into your Xcode project, specify the below code in your Podfile

    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '8.0'
 
    target 'TargetAppName' do
        pod '<COCOAPOD_NAME>'
    end
    Once added above code, run install command in your project directory, where your "podfile" is located.

    $ pod install
    If you get an error like "Unable to find a specification for <pod-name>", then run below command to update your specs to latest version.

    $ pod repo update
    When you want to update your pods to latest version then run below command.

    $ pod update
    Note: If we get "401 Unauthorized" error, then please verify your .netrc file and the associated credentials.


## [Released]
## [2.4.1] - 2019-10-16
### Added speech provider for native ios speech recognition alongwith Google speech recogniton 

- Native Voice feature
- New API to 
- enum SpeechProviderForVoice : SpeechProviderNative, SpeechProviderGoogle
- Default value for SpeechProviderForVoice is SpeechProviderGoogle
- timestamp added as string value alongwith the mobileios.htm url

## [Released]
## [2.4.0] - 2019-10-01
### Made in sync with Morfeus latest released version

- SDK version changed to 2.4.00
