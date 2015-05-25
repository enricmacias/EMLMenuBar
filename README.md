# EMLMenuBar

[![CI Status](http://img.shields.io/travis/enric.macias.lopez/EMLMenuBar.svg?style=flat)](https://travis-ci.org/enric.macias.lopez/EMLMenuBar)
[![Version](https://img.shields.io/cocoapods/v/EMLMenuBar.svg?style=flat)](http://cocoapods.org/pods/EMLMenuBar)
[![License](https://img.shields.io/cocoapods/l/EMLMenuBar.svg?style=flat)](http://cocoapods.org/pods/EMLMenuBar)
[![Platform](https://img.shields.io/cocoapods/p/EMLMenuBar.svg?style=flat)](http://cocoapods.org/pods/EMLMenuBar)

## Description

Implements a scrollable view with buttons in it. Offers different delegate methods to use it as a menu bar and some design and animation customization.

![alt tag](https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/preview.gif)

## Requirements

- iOS 7.0
- ARC

## Usage

Check the example project in the "Example" folder.

1. Create a UIView in Interface Builder with EMLMenuBar as a class.
![alt tag](https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/usage1.png)
2. Set the delegate and datasource to your UIViewController
3. Implement the EMLMenuBarDataSource and its required methods:
```objective-c
- (NSUInteger)itemCountInMenuBar:(EMLMenuBar *)menuBar;
- (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;
```
4. Implement the EMLMEnuBarDelegate and its required method:
```objective-c
- (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;
```

## Customization
-

## Installation

#### Cocoapods

EMLMenuBar is available through [CocoaPods](http://cocoapods.org). 

```ruby
pod "EMLMenuBar"
```

#### Manually

Import the following files into your project:

EMLMenuBar/Pod/Classes folder:
```ruby
EMLMenuBar.h
EMLMenuBar.m
EMLMenuBarButton.h
EMLMenuBarButton.m
EMLMenuBarDataSource.h
EMLMenuBarDelegate.h
```
EMLMenuBar/Pod/Resources folder:
```ruby
EMLMenuBarButton.xib
```

## Author

enric.macias.lopez, enric.macias.lopez@gmail.com

## License

EMLMenuBar is available under the MIT license. See the LICENSE file for more info.
