//
//  EMLViewController.h
//  EMLMenuBar
//
//  Created by enric.macias.lopez on 05/15/2015.
//  Copyright (c) 2014 enric.macias.lopez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EMLMenuBar.h>

@interface EMLMainViewController : UIViewController <EMLMenuBarDelegate, UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet EMLMenuBar *menuBar;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end