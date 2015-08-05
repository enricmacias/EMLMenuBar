//
//  EMLMenuBarDataSource.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 5/19/15.
//
//

#import "EMLMenuBarButton.h"

@class EMLMenuBar;

@protocol EMLMenuBarDataSource <NSObject>

@required

// Implement this function to specify how many items are in the menu.
- (NSInteger)itemCountInMenuBar:(EMLMenuBar *)menuBar;

// Implement this function to specify the title to each menu item.
- (NSString *)itemTitleAtIndex:(NSInteger)index inMenuBar:(EMLMenuBar *)menuBar;

@optional

// Implement this function to specifiy a specific background image to each menu item.
- (UIImage *)itemImageAtIndex:(NSInteger)index inMenuBar:(EMLMenuBar *)menuBar;

// Implement this function to specifiy a different background image to each menu item when this is selected.
- (UIImage *)itemSelectedImageAtIndex:(NSInteger)index inMenuBar:(EMLMenuBar *)menuBar;

// Implement this function to specify a concrete width for your buttons
- (CGFloat)itemWidthAtIndex:(NSInteger)index inMenuBar:(EMLMenuBar *)menuBar;

// Implement this function to give a customized appearance to your button (Normal State)
- (void)appearanceForNormalStateMenuBarButton:(EMLMenuBarButton *)barButton;

// Implement this function to give a customized appearance to your button (Selected State)
- (void)appearanceForSelectedStateMenuBarButton:(EMLMenuBarButton *)barButton;

@end
