//
//  EMLFastPageViewController.m
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 5/18/15.
//  Copyright (c) 2015 enric.macias.lopez. All rights reserved.
//

#import "EMLFastPageViewController.h"

@interface EMLFastPageViewController (){
    NSTimer *_timer;
}

@property (assign, nonatomic) CGPoint panGestureStartPoint;
@property (assign, nonatomic) CGFloat distanceXFromInitialPoint;

@end

@implementation EMLFastPageViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Access to page view controller scroll view pan gesture.
    // We need this gesture recognizer for a faster category tab menu transition.
    for (UIScrollView *view in self.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            for (UIGestureRecognizer *gestureRecognizer in view.gestureRecognizers){
                if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
                    [gestureRecognizer addTarget:self action:@selector(handlePanGestureRecognizer:)];
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)changeToDirection:(EMLCategoryTabDirection)direction
{
    [self.fastDelegate changeToDirection:direction];
    
    [self stopTimer];
    [self startTimer];
}

#pragma mark Timer
- (void)startTimer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(timerFired:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)stopTimer
{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (void)timerFired:(NSTimer *)timer
{
    [self.fastDelegate checkForWorstCaseFired];
}

#pragma mark - UIGestureRecognizerDelegate

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer
{
    switch (panGestureRecognizer.state){
        case UIGestureRecognizerStateBegan:{
            if(panGestureRecognizer.numberOfTouches > 0){
                // Save the inital position
                self.panGestureStartPoint = [panGestureRecognizer locationOfTouch:0 inView:self.view];
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged:{
            if(panGestureRecognizer.numberOfTouches > 0){
                // Calculate new distance from initial point
                self.distanceXFromInitialPoint = self.panGestureStartPoint.x - [panGestureRecognizer locationOfTouch:0 inView:self.view].x;
            }
            
            break;
        }
        case UIGestureRecognizerStateEnded:{
            NSLog(@"UIGestureRecognizerStateEnded");
            NSLog(@"distanceX: %f", self.distanceXFromInitialPoint);
            
            CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
            NSLog(@"velocity: %f, %f",velocity.x,velocity.y);
            
            if (fabs(self.distanceXFromInitialPoint) >= self.view.frame.size.width/2){
                // The distance reached is bigger or equal than half the screen width size,
                // the page is going to be changed.
                if (self.distanceXFromInitialPoint > 0){
                    [self changeToDirection:EMLCategoryTabDirectionNext];
                }
                else if (self.distanceXFromInitialPoint < 0){
                    [self changeToDirection:EMLCategoryTabDirectionPrevious];
                }
            }
            else if (velocity.x > 300 && self.distanceXFromInitialPoint < -10){
                // Velocity and distance are big enough to go to the previous page
                [self changeToDirection:EMLCategoryTabDirectionPrevious];
            }
            else if (velocity.x < -300 && self.distanceXFromInitialPoint > 10){
                // Velocity and distance are big enough to go to the next page
                [self changeToDirection:EMLCategoryTabDirectionNext];
            }
            else{
                // There is no page change
            }
            
            break;
        }
        case UIGestureRecognizerStatePossible:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        default:{
            break;
        }
    }
}

@end
