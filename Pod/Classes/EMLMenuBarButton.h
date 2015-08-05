//
//  ANIMenuBarButton.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 6/27/14.
//

#import <UIKit/UIKit.h>

@class EMLMenuBarButton;

@protocol EMLMenuBarButtonDelegate <NSObject>

- (void)didPressBarButton:(EMLMenuBarButton *)barButton;
- (void)appearanceForNormalStateMenuBarButton:(EMLMenuBarButton *)barButton;
- (void)appearanceForSelectedStateMenuBarButton:(EMLMenuBarButton *)barButton;

@end

@class EMLMenuBar;

@interface EMLMenuBarButton : UIView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, weak) IBOutlet UIImageView *backgroundSelectedImage;
@property (nonatomic, assign, getter=isSelected) BOOL selected;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<EMLMenuBarButtonDelegate> delegate;

- (void)setupWithPosition:(NSInteger)position inMenuBar:(EMLMenuBar *)menuBar;
- (void)updateButtonInMenuBar:(EMLMenuBar *)menuBar;

@end
