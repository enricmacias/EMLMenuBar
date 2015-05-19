//
//  EMLFastPageViewController.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 5/18/15.
//  Copyright (c) 2015 enric.macias.lopez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EMLCategoryTabDirectionNext          = 0,
    EMLCategoryTabDirectionPrevious      = 1,
} EMLCategoryTabDirection;

@protocol EMLFastPageViewControllerDelegate <NSObject>

- (void)changeToDirection:(EMLCategoryTabDirection)direction;
- (void)checkForWorstCaseFired;

@end

@interface EMLFastPageViewController : UIPageViewController

@property (nonatomic, weak) id <EMLFastPageViewControllerDelegate> fastDelegate;

@end
