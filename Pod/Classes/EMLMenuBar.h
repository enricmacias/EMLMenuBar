//
//  EMLMenuBar.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 6/30/14.
//

#import <UIKit/UIKit.h>

#import "EMLMenuBarDelegate.h"
#import "EMLMenuBarButton.h"

@interface EMLMenuBar : UIView <EMLMenuBarButtonDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger selectedItemIndex;
@property (nonatomic, assign) BOOL bounces; // defaults to NO
@property (nonatomic, strong) NSArray *barButtonsArray;
@property (nonatomic, strong) UIView *topBarView;

@property (nonatomic, weak) IBOutlet id<EMLMenuBarDelegate> delegate;

- (void)setup;
- (void)reloadMenu;
- (CGFloat)barLenght;
- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex animated:(BOOL)animated notifyDelegate:(BOOL)notifyDelegate;

@end
