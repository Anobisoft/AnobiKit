# AnobiKit

[![CI Status](http://img.shields.io/travis/Anobisoft/AnobiKit.svg?style=flat)](https://travis-ci.org/Anobisoft/AnobiKit)
[![Codecov](https://codecov.io/gh/Anobisoft/AnobiKit/branch/master/graph/badge.svg)](https://codecov.io/gh/Anobisoft/AnobiKit)
[![Version](https://img.shields.io/cocoapods/v/AnobiKit.svg?style=flat)](http://cocoapods.org/pods/AnobiKit)
[![Platform](https://img.shields.io/cocoapods/p/AnobiKit.svg?style=flat)](http://cocoapods.org/pods/AnobiKit)
[![Language](https://img.shields.io/github/languages/top/Anobisoft/AnobiKit.svg)](https://github.com/Anobisoft/AnobiKit)
[![License](https://img.shields.io/cocoapods/l/AnobiKit.svg?style=flat)](http://cocoapods.org/pods/AnobiKit)
[![Twitter](https://img.shields.io/badge/twitter-@Anobisoft-blue.svg?style=flat)](http://twitter.com/Anobisoft)

Collection of tools and extesions.

## Installation with CocoaPods
[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like **AnobiKit** in your projects. You can install it with the following command:
```
$ gem install cocoapods
```
#### Podfile
To integrate **AnobiKit** into your Xcode project using CocoaPods, specify it in your `Podfile`:

```
use_frameworks!

target 'iOSTargetName' do
  platform :ios, '9.3'
  pod 'AnobiKit', '~> 0.13.0'
end

target 'WatchTargetName' do
  platform :watchos, '3.0'
  pod 'AnobiKit', '~> 0.13.0'
end
```
Then, run the following command:
```
$ pod install
```
