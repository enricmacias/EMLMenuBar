//
//  EMLViewController.m
//  EMLMenuBar
//
//  Created by enric.macias.lopez on 05/15/2015.
//  Copyright (c) 2014 enric.macias.lopez. All rights reserved.
//

#import "EMLMainViewController.h"
#import "EMLContentViewController.h"

@interface EMLMainViewController ()

@property (nonatomic, strong) NSArray *menuDataSource;

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
    [self initScrollView];
    self.menuBar.selectedItemIndex = 0;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.menuDataSource.count,
                                             self.scrollView.frame.size.height);
    self.scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Init
#pragma mark -

- (void)initScrollView
{
    for (int i=0;i<self.menuDataSource.count;i++){
        EMLContentViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        viewController.titleString = self.menuDataSource[i];
        
        CGRect newFrame = viewController.view.frame;
        newFrame.origin.x = self.scrollView.frame.size.width * i;
        newFrame.size = self.scrollView.frame.size;
        viewController.view.frame = newFrame;
        
        [self addChildViewController:viewController];
        [self.scrollView addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
    }
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
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * index;
    frame.origin.y = 0;
    [self.scrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark -
#pragma mark ScrollViewDelegate
#pragma mark -

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.scrollView]){
        
        CGFloat pageWidth = scrollView.frame.size.width;
        float fractionalPage = scrollView.contentOffset.x / pageWidth;
        NSInteger page = lround(fractionalPage);
        
        self.menuBar.selectedItemIndex = page;
    }
}

@end
