//
//  EMLViewController.m
//  EMLMenuBar
//
//  Created by enric.macias.lopez on 05/15/2015.
//  Copyright (c) 2014 enric.macias.lopez. All rights reserved.
//

#import "EMLMainViewController.h"
#import "EMLContentViewController.h"

typedef enum : NSUInteger {
    ENCategoryTabDirectionNext          = 0,
    ENCategoryTabDirectionPrevious      = 1,
} ENCategoryTabDirection;

@interface EMLMainViewController () {
    NSTimer *_timer;
}

@property (nonatomic, strong) NSArray *menuDataSource;

@property (assign, nonatomic) CGPoint panGestureStartPoint;
@property (assign, nonatomic) CGFloat distanceXFromInitialPoint;

@end

@implementation EMLMainViewController

#pragma mark -
#pragma mark Lifecycle
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Menu Bar";
    
    [self.menuBar setup];
    self.menuBar.selectedItemIndex = 0;
    
    // Access to page view controller scroll view pan gesture.
    // We need this gesture recognizer for a faster category tab menu transition.
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            for (UIGestureRecognizer *gestureRecognizer in view.gestureRecognizers){
                if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]){
                    [gestureRecognizer addTarget:self action:@selector(handlePanGestureRecognizer:)];
                }
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.pageViewController = segue.destinationViewController;
    
    _pageViewController.view.bounds = self.containerView.bounds;
    
    _pageViewController.dataSource = self;
    _pageViewController.delegate = self;
    
    EMLContentViewController *controller = [self viewControllerAtIndex:0];
    [_pageViewController setViewControllers:@[controller]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:NULL];
}

#pragma mark -
#pragma mark Init
#pragma mark -


#pragma mark -
#pragma mark Private
#pragma mark -

- (EMLContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.menuDataSource count] == 0) || (index >= [self.menuDataSource count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    EMLContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

- (void)checkAndFixSelectedTabBarIfNeeded
{
    NSUInteger currentIndex = ((EMLContentViewController*) self.pageViewController.viewControllers[0]).pageIndex;
    
    if (currentIndex != self.menuBar.selectedItemIndex) {
        [self.menuBar setSelectedItemIndex:currentIndex animated:YES notifyDelegate:NO];
    }
}

- (void)changeTabToDirection:(ENCategoryTabDirection)direction
{
    NSUInteger index = ((EMLContentViewController*) self.pageViewController.viewControllers[0]).pageIndex;
    
    switch (direction) {
        case ENCategoryTabDirectionPrevious:{
            if (index == 0) {
                break;
            }
            [self.menuBar setSelectedItemIndex:index-1 animated:YES notifyDelegate:NO];
            break;
        }
        case ENCategoryTabDirectionNext:{
            if (index == (self.menuDataSource.count - 1)) {
                break;
            }
            [self.menuBar setSelectedItemIndex:index+1 animated:YES notifyDelegate:NO];
            break;
        }
        default:{
            break;
        }
    }
    
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
    [self checkAndFixSelectedTabBarIfNeeded];
}

#pragma mark -
#pragma mark MenuDataSource
#pragma mark -

- (NSArray *)menuDataSource
{
    if (!_menuDataSource) {
        _menuDataSource = @[@"Page 1",@"Page 2",@"Page 3",@"Page 4",@"Page 5",@"Page 6",@"Page 7"];
    }
    
    return _menuDataSource;
}

#pragma mark -
#pragma mark EMLMenuBarDelegate
#pragma mark -

- (NSUInteger)itemCountInMenuBar:(EMLMenuBar *)menuBar
{
    return [[self menuDataSource] count];
}

- (NSString *)itemTitleAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar
{
    return [[self menuDataSource] objectAtIndex:index];
}

- (void)itemSelectedAtIndex:(NSUInteger)index inMenuBar:(EMLMenuBar *)menuBar
{
    NSLog(@"Tag selected");
    self.pageViewController.view.userInteractionEnabled = NO;
    
    NSUInteger currentIndex = ((EMLContentViewController*) self.pageViewController.viewControllers[0]).pageIndex;
    UIPageViewControllerNavigationDirection direction = index > currentIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    
    EMLContentViewController *controller = [self viewControllerAtIndex:index];
    __weak UIPageViewController* pvcw = self.pageViewController;
    [_pageViewController setViewControllers:@[controller]
                                  direction:direction
                                   animated:YES
                                 completion:^(BOOL finished) {
                                     UIPageViewController* pvcs = pvcw;
                                     if (!pvcs) return;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [pvcs setViewControllers:@[controller]
                                                        direction:direction
                                                         animated:NO completion:nil];
                                     });
                                     
                                     // Enable interaction again once the category is changed.
                                     self.pageViewController.view.userInteractionEnabled = YES;
                                 }];
}

#pragma mark -
#pragma mark UIPageViewControllerDataSource
#pragma mark -

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EMLContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((EMLContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.menuDataSource count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

#pragma mark -
#pragma mark UIPageViewControllerDelegate
#pragma mark -

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed){
        [self checkAndFixSelectedTabBarIfNeeded];
    }
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
            //self.animationStageEnabled = YES;
            
            CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
            NSLog(@"velocity: %f, %f",velocity.x,velocity.y);
            
            if (fabs(self.distanceXFromInitialPoint) >= self.view.frame.size.width/2){
                // The distance reached is bigger or equal than half the screen width size,
                // the page is going to be changed.
                if (self.distanceXFromInitialPoint > 0){
                    [self changeTabToDirection:ENCategoryTabDirectionNext];
                }
                else if (self.distanceXFromInitialPoint < 0){
                    [self changeTabToDirection:ENCategoryTabDirectionPrevious];
                }
            }
            else if (velocity.x > 300 && self.distanceXFromInitialPoint < -10){
                // Velocity and distance are big enough to go to the previous page
                [self changeTabToDirection:ENCategoryTabDirectionPrevious];
            }
            else if (velocity.x < -300 && self.distanceXFromInitialPoint > 10){
                // Velocity and distance are big enough to go to the next page
                [self changeTabToDirection:ENCategoryTabDirectionNext];
            }
            else{
                // There is no page change
                //self.animationStageEnabled = NO;
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
