//
//  EMLViewController.h
//  EMLMenuBar
//
//  Created by enric.macias.lopez on 05/15/2015.
//  Copyright (c) 2014 enric.macias.lopez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EMLMenuBar.h>
#import "EMLFastPageViewController.h"

@interface EMLMainViewController : UIViewController <EMLMenuBarDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate, EMLFastPageViewControllerDelegate>

@property (nonatomic, weak) IBOutlet EMLMenuBar *menuBar;
@property (nonatomic, weak) IBOutlet UIView *containerView;

@property (nonatomic, weak) EMLFastPageViewController *pageViewController;

@end