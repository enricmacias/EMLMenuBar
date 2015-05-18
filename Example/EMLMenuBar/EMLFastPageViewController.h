//
//  EMLFastPageViewController.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 5/18/15.
//  Copyright (c) 2015 enric.macias.lopez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ENCategoryTabDirectionNext          = 0,
    ENCategoryTabDirectionPrevious      = 1,
} ENCategoryTabDirection;

@protocol EMLFastPageViewControllerDelegate <NSObject>

- (void)changeToDirection:(ENCategoryTabDirection)direction;
- (void)checkForWorstCaseFired;

@end

@interface EMLFastPageViewController : UIPageViewController

@property (nonatomic, weak) id <EMLFastPageViewControllerDelegate> fastDelegate;

@end
