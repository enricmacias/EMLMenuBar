//
//  EMLMenuBarDelegate.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 6/30/14.
//

#import <Foundation/Foundation.h>

@class EMLMenuBar;

@protocol EMLMenuBarDelegate <NSObject>

@required

- (NSUInteger)itemCountInMenuBar:(EMLMenuBar *)menuBar;
- (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;
- (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;

@optional

- (BOOL)itemSelectableAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;
- (CGFloat)itemWidthAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar;
- (void)appearanceForNormalStateMenuBarButton:(UIView *)barButton;
- (void)appearanceForSelectedStateMenuBarButton:(UIView *)barButton;

@end
