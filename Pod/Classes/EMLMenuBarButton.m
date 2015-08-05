//
//  ANIMenuBarButton.m
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 6/27/14.
//

#import "EMLMenuBarButton.h"
#import "EMLMenuBar.h"

@interface EMLMenuBarButton()

@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) BOOL autoWidth;
@property (nonatomic, weak) UIView *originalPrimitiveInstanceButton;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end

@implementation EMLMenuBarButton

#pragma mark -
#pragma mark UIView
#pragma mark -

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark -
#pragma mark Init
#pragma mark -

- (void)setupWithPosition:(NSInteger)position inMenuBar:(EMLMenuBar *)menuBar;
{
    // Init
    self.index = position;
    
    switch (menuBar.menuBarStyle) {
        case EMLMenuBarStyleNone:{
            self.autoWidth = ![(id)menuBar.delegate respondsToSelector:@selector(itemWidthAtIndex:inMenuBar:)];
            self.buttonWidth = (self.autoWidth ? 70.0f : [menuBar.dataSource itemWidthAtIndex:position inMenuBar:menuBar]);
            break;
        }
        case EMLMenuBarStyleFitText:{
            NSString *title = [menuBar.dataSource itemTitleAtIndex:position inMenuBar:menuBar];
            CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f]}];
            self.buttonWidth = size.width+30.0f;
            break;
        }
        case EMLMenuBarStyleFillMenu:{
            CGFloat buttonSizeByMenuSize = ([menuBar.dataSource itemCountInMenuBar:menuBar] > 0) ? menuBar.frame.size.width/[menuBar.dataSource itemCountInMenuBar:menuBar] : 0.0f;
            self.buttonWidth = buttonSizeByMenuSize;
            break;
        }
        default:{
            break;
        }
    }
    
    self.buttonHeight = menuBar.frame.size.height;
    
    // Set frame
    CGFloat posX = 0.0f;
    if (position != 0){
        EMLMenuBarButton *previousButton = menuBar.barButtonsArray[position-1];
        posX = previousButton.frame.origin.x + previousButton.frame.size.width;
    }
    
    [self setFrame:CGRectMake(posX, 0.0f,
                              self.buttonWidth, self.buttonHeight)];
    
    // Set title
    self.titleLabel.text = [menuBar.dataSource itemTitleAtIndex:position
                                                    inMenuBar:menuBar];
    
    // Background image
    if ([menuBar.dataSource respondsToSelector:@selector(itemImageAtIndex:inMenuBar:)]){
        self.backgroundImage.image = [menuBar.dataSource itemImageAtIndex:position
                                                                inMenuBar:menuBar];
        self.backgroundImage.hidden = NO;
    }
    
    // Background selected image
    if ([menuBar.dataSource respondsToSelector:@selector(itemSelectedImageAtIndex:inMenuBar:)]){
        self.backgroundSelectedImage.image = [menuBar.dataSource itemSelectedImageAtIndex:position
                                                                                inMenuBar:menuBar];
        self.backgroundSelectedImage.hidden = YES;
    }
}

#pragma mark -
#pragma mark Update
#pragma mark -

- (void)updateButtonInMenuBar:(EMLMenuBar *)menuBar
{
    [self setupWithPosition:self.index inMenuBar:menuBar];
}

#pragma mark -
#pragma mark Selection methods
#pragma mark -

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    _selected = selected;
    
    if (selected){
        if (animated){
            [UIView animateWithDuration:0.25f animations:^{
                [self.delegate appearanceForSelectedStateMenuBarButton:self];
            }];
        }
        else{
            [self.delegate appearanceForSelectedStateMenuBarButton:self];
        }
        
        if (self.backgroundSelectedImage){
            [self showSelectedImage];
        }
    }
    else{
        if (animated){
            [UIView animateWithDuration:0.25f animations:^{
                [self.delegate appearanceForNormalStateMenuBarButton:self];
            }];
        }
        else{
            [self.delegate appearanceForNormalStateMenuBarButton:self];
        }
        
        if (self.backgroundSelectedImage){
            [self hideSelectedImage];
        }
    }
}

- (void)showSelectedImage
{
    self.backgroundImage.hidden = YES;
    self.backgroundSelectedImage.hidden = NO;
}

- (void)hideSelectedImage
{
    self.backgroundImage.hidden = NO;
    self.backgroundSelectedImage.hidden = YES;
}

#pragma mark -
#pragma mark ANIMenuBarButtonDelegate
#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self showSelectedImage];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate didPressBarButton:self];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideSelectedImage];
}

@end
