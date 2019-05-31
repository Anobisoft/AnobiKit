# AnobiKit

[![Version](https://img.shields.io/cocoapods/v/AnobiKit.svg?style=flat)](http://cocoapods.org/pods/AnobiKit)
[![Platform](https://img.shields.io/cocoapods/p/AnobiKit.svg?style=flat)](http://cocoapods.org/pods/AnobiKit)
[![Language](https://img.shields.io/github/languages/top/Anobisoft/AnobiKit.svg)](https://github.com/Anobisoft/AnobiKit)
[![CI Status](http://img.shields.io/travis/Anobisoft/AnobiKit.svg?style=flat)](https://travis-ci.org/Anobisoft/AnobiKit)
[![Codecov](https://codecov.io/gh/Anobisoft/AnobiKit/branch/master/graph/badge.svg)](https://codecov.io/gh/Anobisoft/AnobiKit)
[![License](https://img.shields.io/cocoapods/l/AnobiKit.svg?style=flat)](http://cocoapods.org/pods/AnobiKit)
[![Twitter](https://img.shields.io/badge/twitter-@Anobisoft-blue.svg?style=flat)](http://twitter.com/Anobisoft)

Collection of tools and extesions.

## CocoaPods integration
To integrate **AnobiKit** into your Xcode project using [CocoaPods](http://cocoapods.org), specify it in your `Podfile`:

```
use_frameworks! #optional

target 'iOSTargetName' do
  platform :ios, '9.3'
  pod 'AnobiKit', '~> 0.14.0'
end

target 'WatchTargetName' do
  platform :watchos, '3.0'
  pod 'AnobiKit', '~> 0.14.0'
end
```
Then, run the following command:
```
$ pod install
```

## Requirements

| Minimum iOS Target | Minimum macOS Target | Minimum tvOS Target | Minimum watchOS Target | 
|:------------------:|:--------------------:|:-------------------:|:----------------------:|
| iOS 8.3            | OS X 10.12           | tvOS 9.0            | watchOS 3.0            |

