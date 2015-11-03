//
//  UITableView+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-3-27.
//  Copyright (c) 2013年 杨 烽. All rights reserved.
//

#import "UITableView+KIAdditions.h"

@implementation UITableView (KIAdditions)

- (void)setBackgroundImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [imageView setImage:image];
    [self setBackgroundView:imageView];
}

- (void)setBackgroundColor:(UIColor *)color {
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [backgroundView setBackgroundColor:color];
    [self setBackgroundView:backgroundView];
}

- (void)setSeparatorImage:(UIImage *)image {
    UIColor *separatorColor = [UIColor colorWithPatternImage:image];
    [self setSeparatorColor:separatorColor];
}

- (void)addItemToFirst:(id)item withDataSource:(NSMutableArray *)dataSource {
    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:0 withDataSource:dataSource];
}

- (void)addItemsToFirst:(NSArray *)items withDataSource:(NSMutableArray *)dataSource {
    [self addItems:items beginWithIndex:0 withDataSource:dataSource];
}

- (void)addItemToLast:(id)item withDataSource:(NSMutableArray *)dataSource {
    [self addItems:[NSArray arrayWithObject:item]
    beginWithIndex:[dataSource count]
    withDataSource:dataSource];
}

- (void)addItemsToLast:(NSArray *)items withDataSource:(NSMutableArray *)dataSource {
    [self addItems:items
    beginWithIndex:[dataSource count]
    withDataSource:dataSource];
}

- (void)addItem:(id)item toIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource {
    [self addItems:[NSArray arrayWithObject:item]
    beginWithIndex:index
    withDataSource:dataSource];
}

- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource {
    [self addItems:items beginWithIndex:index itemCountInRow:1 withDataSource:dataSource];
}

- (void)addItems:(NSArray *)items
  beginWithIndex:(NSUInteger)index
    itemCountInRow:(NSUInteger)itemCountInRow
  withDataSource:(NSMutableArray *)dataSource {
    if (dataSource==nil || items==nil || [items isKindOfClass:[NSNull class]]) {
        return ;
    }
    
    /*当前列表有多少条数据*/
    NSUInteger dataSourceCount = dataSource.count;
    
    /*当前列表最后一行数据量*/
    NSUInteger dataSourceRemainder = dataSourceCount % itemCountInRow;
    
    /*需要添加的数据量*/
    NSUInteger itmesCount = items.count + dataSourceRemainder;
    
    NSUInteger remainder = (itmesCount % itemCountInRow);
    
    /*需要添加的行数*/
    NSUInteger count = items.count / itemCountInRow + remainder;
    
    if (dataSourceRemainder) {
        count--;
    }
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index*itemCountInRow, items.count)];
    
    [dataSource insertObjects:items atIndexes:indexSet];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = nil;
    for (int i=0; i<count; i++) {
        indexPath = [NSIndexPath indexPathForRow:index+i inSection:0];
        [indexPaths addObject:indexPath];
    }
    [self beginUpdates];
    [self insertRowsAtIndexPaths:indexPaths
                withRowAnimation:UITableViewRowAnimationFade];
//    if (dataSourceRemainder) {
//        NSIndexPath *last = [NSIndexPath indexPathForRow:index-1 inSection:0];
//        [self reloadRowsAtIndexPaths:[NSArray arrayWithObjects:last, nil]
//                    withRowAnimation:UITableViewRowAnimationFade];
//    }
    [self endUpdates];
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath withDataSource:(NSMutableArray *)dataSource {
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    [indexPaths addObject:indexPath];
    [dataSource removeObjectAtIndex:indexPath.row];
    
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
}

- (void)removeItemsAtIndexPaths:(NSArray *)indexPaths withDataSource:(NSMutableArray *)dataSource {
    NSArray *newIndexPaths = [indexPaths sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSIndexPath *indexPath1 = (NSIndexPath *)obj1;
        NSIndexPath *indexPath2 = (NSIndexPath *)obj2;
        
        if (indexPath1.row > indexPath2.row) {
            return NSOrderedAscending;
        } else if (indexPath1.row < indexPath2.row) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    for (NSIndexPath *indexPath in newIndexPaths) {
        [dataSource removeObjectAtIndex:indexPath.row];
    }
    
    [self beginUpdates];
    [self deleteRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [self endUpdates];
}

@end
