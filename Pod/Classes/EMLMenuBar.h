//
//  EMLMenuBar.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 6/30/14.
//

#import <UIKit/UIKit.h>

#import "EMLMenuBarDelegate.h"
#import "EMLMenuBarDataSource.h"
#import "EMLMenuBarButton.h"

typedef enum : NSUInteger {
    EMLMenuBarStyleNone             = 0,  // The width is the one setted in EMLMenuBarDataSource.
    EMLMenuBarStyleFitText          = 1,  // The buttons fit the title text.
    EMLMenuBarStyleFillMenu         = 2,  // The buttons fill the menu view, creating a menu without scroll.
} EMLMenuBarStyle;

@interface EMLMenuBar : UIView <EMLMenuBarButtonDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSUInteger selectedItemIndex;
@property (nonatomic, assign) BOOL bounces; // default is to NO
@property (nonatomic, strong) NSArray *barButtonsArray;
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, assign) EMLMenuBarStyle menuBarStyle; // default is to EMLMenuBarStyleNone

@property (nonatomic, weak) IBOutlet id<EMLMenuBarDelegate> delegate;
@property (nonatomic, weak) IBOutlet id<EMLMenuBarDataSource> dataSource;

- (void)setup;
- (void)reloadMenu;
- (CGFloat)barLenght;
- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex animated:(BOOL)animated notifyDelegate:(BOOL)notifyDelegate;

@end
