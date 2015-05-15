//
//  ANIMenuBarButton.m
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 6/27/14.
//

#import "EMLMenuBarButton.h"
#import "EMLMenuBar.h"

#define kButtonYOffset 2.0f

@interface EMLMenuBarButton()

@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, assign) CGFloat buttonHeight;
@property (nonatomic, assign) BOOL autoWidth;

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
    // Set UI
    [self.layer setCornerRadius:3.0f];
    
    // Init
    self.index = position;
    self.autoWidth = ![(id)menuBar.delegate respondsToSelector:@selector(itemWidthAtIndex:inMenuBar:)];
    self.buttonWidth = (self.autoWidth ? 70.0f : [menuBar.delegate itemWidthAtIndex:position inMenuBar:menuBar]);
    self.buttonHeight = menuBar.frame.size.height;
    
    // Set frame
    CGFloat posX = 0.0f;
    if (position != 0){
        EMLMenuBarButton *previousButton = menuBar.barButtonsArray[position-1];
        posX = previousButton.frame.origin.x + previousButton.frame.size.width;
    }
    
    [self setFrame:CGRectMake(posX, 0.0f,
                              self.buttonWidth, self.buttonHeight - kButtonYOffset)];
    
    // Set title
    self.titleLabel.text = [menuBar.delegate itemTitleAtIndex:position
                                                    inMenuBar:menuBar];
    
    // Set gesture recognizer
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSingleTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:singleTap];
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
    
    //NewsCategory category = [ANICategoryDataSource categoryTypeAtIndex:self.index];
    
    if (selected){
        CGRect newFrame = self.frame;
        newFrame.size.height = self.buttonHeight;
        
        if (animated){
            [UIView animateWithDuration:0.25f animations:^{
                self.frame = newFrame;
                //self.backgroundColor = [ANICategoryDataSource activeColorByCategory:category];
                //self.titleLabel.textColor = [UIColor whiteColor];
            }];
        }
        else{
            self.frame = newFrame;
            //self.backgroundColor = [ANICategoryDataSource activeColorByCategory:category];
            //self.titleLabel.textColor = [UIColor whiteColor];
        }
    }
    else{
        CGRect newFrame = self.frame;
        newFrame.size.height = self.buttonHeight - kButtonYOffset;
        
        if (animated){
            [UIView animateWithDuration:0.25f animations:^{
                self.frame = newFrame;
                //self.backgroundColor = [ANICategoryDataSource unactiveColorByCategory:category];
                //self.titleLabel.textColor = [ANICategoryDataSource titleColorByCategory:category];
            }];
        }
        else{
            self.frame = newFrame;
            //self.backgroundColor = [ANICategoryDataSource unactiveColorByCategory:category];
            //self.titleLabel.textColor = [ANICategoryDataSource titleColorByCategory:category];
        }
    }
}

#pragma mark -
#pragma mark Actions
#pragma mark -

- (void)didSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self.delegate didPressBarButton:self];
}

@end