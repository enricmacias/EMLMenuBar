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

#### Quick setup

1. Create a UIView in Interface Builder with EMLMenuBar as a class. (The buttons will have the height of this view)

  ![alt tag](https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/usage1.png)
2. Adopt EMLMenuBarDataSource and EMLMEnuBarDelegate into your UIViewController.

  ```objective-c
  @interface EMLMainViewController : UIViewController <EMLMenuBarDelegate, EMLMenuBarDataSource>
  ```
3. Assign the delegate and datasource to your UIViewController.

  ![alt tag](https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/usage2.png)
4. Implement the EMLMenuBarDataSource and its required methods:

  ```objective-c
  - (NSUInteger)itemCountInMenuBar:(EMLMenuBar *)menuBar;
  - (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;
  ```
5. Implement the EMLMEnuBarDelegate and its required method:

  ```objective-c
  - (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;
  ```

## Customization

- Choose one of the three types of button alineation:

  **EMLMenuBarStyleNone** (Default). The width is the one set in EMLMenuBarDataSource.
  ![alt tag](https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/customization1.png)

  **EMLMenuBarStyleFitText**
  ![alt tag](https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/customization2.png)

  **EMLMenuBarStyleFillMenu**
  ![alt tag](https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/customization3.png)

- Modify the button design through interface builder with EMLMenuBarButton xib file:
```ruby
EMLMenuBarButton.xib
```

- Create your own animation with:
```objective-c
- (void)appearanceForNormalStateMenuBarButton:(EMLMenuBarButton *)barButton;
- (void)appearanceForSelectedStateMenuBarButton:(EMLMenuBarButton *)barButton;
```

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
