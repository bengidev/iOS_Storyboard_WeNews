![Static Badge](https://img.shields.io/badge/version-12.0-orange?style=for-the-badge&logo=ios&link=https%3A%2F%2Fsupport.apple.com%2Fen-us%2F100100) ![Static Badge](https://img.shields.io/badge/version-5.x-orange?style=for-the-badge&logo=swift&link=https%3A%2F%2Fwww.swift.org) ![Static Badge](https://img.shields.io/badge/version-1.7.38-white?style=for-the-badge&logo=cocoapods&link=https%3A%2F%2Fcocoapods.org) ![Static Badge](https://img.shields.io/badge/license-MIT-white?style=for-the-badge&logo=alchemy) 



# Welcome to WeNews!

A simple news app for iOS which using Swift and Storyboard to create the UI



## Credits

These are credits for resources that this app used
- [Three muffins sitting on top of a wire rack](https://unsplash.com/photos/three-muffins-sitting-on-top-of-a-wire-rack-Pw6Qtdt2eq0)
- [A newspaper laying on the ground next to a door](https://unsplash.com/photos/a-newspaper-laying-on-the-ground-next-to-a-door-Y3B6FBaiyi8)
- [LEGO Batman](https://unsplash.com/photos/lego-batman-minifig-demvKRNvtLY)
- [Loading](https://unsplash.com/photos/text-jf1EomjlQi0)



## Requirements

These are the minimum requirements to be able to run the app:
-   iOS 12.0+
-   Swift 5.0+



## Stacks

- RxSwift
- Storyboard
- CoreData


## Features

 - [x] OnBoarding
 - [x] Home
 - [x] TabBar
 - [x] Featured
 - [x] Favorites



## Installation

To install this framework, follow these commands.
Go to your Flutter directory, and direct to ios directory
```
cd example_app/ios/
```

Initialize `Podspec` when it's not installed yet
```
pod init
```

Open your `Podfile` with your favorite editor, and edit to be the same like the following
```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://gitlab.com/bengidev/TradeInFatFramework.git'

def base_pods
	pod 'TradeInFatFramework'
end

# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Tester Project' do
  # Comment the next line if you don't want to use dynamic frameworks
	use_frameworks!

	# Pods for Tester Project
	base_pods
end
```



## Getting Started

To make it easy for you to get started, here's a list of recommended next steps.
Clone the repository to your local directory
```
cd your_directory
git clone https://gitlab.com/bengidev/TradeInFatFramework.git
```

Direct to the Flutter directory, and run these commands
```
cd example_app

flutter pub get
flutter pub upgrade
flutter run
```



## How To Use

If you want to use your Camera on your phone, please ensure
you add required permissions into your `info.plist` file inside your project,
such as:

Privacy - Camera Usage Description
```
<key>NSCameraUsageDescription</key>
<string>This app would like to access your camera for testing your camera hardware</string>

<key>NSMicrophoneUsageDescription</key>
<string>This app would like to access your microphone for testing your camera hardware</string>
```

If you have done to add required privacy permissions to your `Project` in your `.xcworkspace` or `.xcodeproj`, 
then edit the file to match below codes:

First, cd to your `Native_Example` directory and open the directory:
```
cd Native_Example
cd NativeExample
```

Then run following command to install and update the pods:

```
pod install --repo-update
pod update
```

Then try to run your project using the `Run` button inside your XCode.



## License

TradeInFatFramework is released under the BizInsight Ltd. license. See [License](https://gitlab.com/bengidev/TradeInFatFramework/-/blob/main/LICENSE) for details.
