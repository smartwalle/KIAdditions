//
//  UITableViewController+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-3-14.
//  Copyright (c) 2013年 杨 烽. All rights reserved.
//

#import "UITableViewController+KIAdditions.h"

@implementation UITableViewController (KIAdditions)

- (void)setBackgroundImage:(UIImage *)image {
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    [backgroundView setBackgroundColor:[UIColor colorWithPatternImage:image]];
    [self.tableView setBackgroundView:backgroundView];
    [self reloadVisibleCells];
}

- (void)setBackgroundColor:(UIColor *)color {
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    [backgroundView setBackgroundColor:color];
    [self.tableView setBackgroundView:backgroundView];
    [self reloadVisibleCells];
}

- (void)reloadVisibleCells {
    [self.tableView reloadRowsAtIndexPaths:[self.tableView indexPathsForVisibleRows]
                          withRowAnimation:UITableViewRowAnimationNone];
}

- (void)addItemToFirst:(id)item withDataSource:(NSMutableArray *)dataSource {
//    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:0 withDataSource:dataSource];
    [self.tableView addItemToFirst:item withDataSource:dataSource];
}

- (void)addItemsToFirst:(NSArray *)items withDataSource:(NSMutableArray *)dataSource {
//    [self addItems:items beginWithIndex:0 withDataSource:dataSource];
    [self.tableView addItemsToFirst:items withDataSource:dataSource];
}

- (void)addItemToLast:(id)item withDataSource:(NSMutableArray *)dataSource {
//    [self addItems:[NSArray arrayWithObject:item]
//    beginWithIndex:[dataSource count]
//    withDataSource:dataSource];
    [self.tableView addItemToLast:item withDataSource:dataSource];

}

- (void)addItemsToLast:(NSArray *)items withDataSource:(NSMutableArray *)dataSource {
//    [self addItems:items
//    beginWithIndex:[dataSource count]
//    withDataSource:dataSource];
    [self.tableView addItemsToLast:items withDataSource:dataSource];
}

- (void)addItem:(id)item toIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource {
//    [self addItems:[NSArray arrayWithObject:item]
//    beginWithIndex:index
//    withDataSource:dataSource];
    [self.tableView addItem:item toIndex:index withDataSource:dataSource];
}

- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource {
    
    [self.tableView addItems:items beginWithIndex:index withDataSource:dataSource];
    
//    if (dataSource==nil || items==nil) {
//        return ;
//    }
    /*
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)];
    
    [dataSource insertObjects:items atIndexes:indexSet];
    
    dispatch_queue_t queue = dispatch_queue_create("insertTableViewRows", 0);
    
    dispatch_async(queue, ^{
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = nil;
        for (int i=0; i<[items count]; i++) {
            indexPath = [NSIndexPath indexPathForRow:index+i inSection:0];
            [indexPaths addObject:indexPath];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView beginUpdates];
            [self.tableView insertRowsAtIndexPaths:indexPaths
                                  withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
            [indexPaths release];
        });
    });
    
    dispatch_release(queue);
     */
    
//    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)];
//    
//    [dataSource insertObjects:items atIndexes:indexSet];
//    
//    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
//    NSIndexPath *indexPath = nil;
//    for (int i=0; i<[items count]; i++) {
//        indexPath = [NSIndexPath indexPathForRow:index+i inSection:0];
//        [indexPaths addObject:indexPath];
//    }
//    
//    [self.tableView beginUpdates];
//    [self.tableView insertRowsAtIndexPaths:indexPaths
//                          withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView endUpdates];
//    [indexPaths release];
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath withDataSource:(NSMutableArray *)dataSource {
    [self.tableView removeItemAtIndexPath:indexPath withDataSource:dataSource];
}

@end