# Telephone directory iOS

[![License][license-image]][license-url]
[![License][swift-image]][swift-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

An iOS application that provides a telephone directory.

The application handles a set of entries, that contain a first name, last name, and a telephone number.
The entries should be validated, so that it's not possible to enter an empty first or last name; and the phone number should be of the form
`+39 02 1234567`
That is a "+" followed by a nonempty group of digits, a space, a nonempty group of digits, a space, a group of digits with at least 6 digits.

## Build Requirements

- iOS SDK 11.0 or later
- Xcode 9.2

## Runtime Requirements
- iOS 11.0 or later

## Compatibility

Tested on:
- iPhone 6/6+
- iPhone 6s/6s+
- iPhone 7/7+
- iPhone 8/8+
- iPhone X
- iPad Air 2
- iPad Pro

## Installation

Clone the repository, build and run `Telephone Directory iOS` scheme (CMD + R).
If you want to run on physical device, remember to add a valid `DEVELOPMENT_TEAM` in Signing's Target settings.

[swift-image]:https://img.shields.io/badge/swift-4.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: https://choosealicense.com/licenses/mit/
