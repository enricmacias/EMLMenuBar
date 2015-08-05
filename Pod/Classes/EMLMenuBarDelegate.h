//
//  EMLMenuBarDelegate.h
//  EMLMenuBar
//
//  Created by Enric Macias Lopez on 6/30/14.
//

@class EMLMenuBar;

@protocol EMLMenuBarDelegate <NSObject>

@required

// Implement this function to perform the necessary changes on your interface after a button has been clicked.
- (void)itemSelectedAtIndex:(NSInteger)index inMenuBar:(EMLMenuBar *)menuBar;

@end
