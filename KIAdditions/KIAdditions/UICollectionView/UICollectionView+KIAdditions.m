//
//  UICollectionView+KIAdditions.m
//  KIAdditions
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import "UICollectionView+KIAdditions.h"

@implementation UICollectionView (KIAdditions)

- (void)addItemToFirst:(id)item withDataSource:(NSMutableArray *)dataSource {
    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:0 withDataSource:dataSource];
}

- (void)addItemToFirst:(id)item withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section {
    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:0 withDataSource:dataSource inSection:section];
}

- (void)addItemsToFirst:(NSArray *)items withDataSource:(NSMutableArray *)dataSource {
    [self addItems:items beginWithIndex:0 withDataSource:dataSource];
}

- (void)addItemsToFirst:(NSArray *)items withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section {
    [self addItems:items beginWithIndex:0 withDataSource:dataSource inSection:section];
}

- (void)addItemToLast:(id)item withDataSource:(NSMutableArray *)dataSource {
    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:[dataSource count] withDataSource:dataSource];
}

- (void)addItemToLast:(id)item withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section {
    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:[dataSource count] withDataSource:dataSource inSection:section];
}

- (void)addItemsToLast:(NSArray *)items withDataSource:(NSMutableArray *)dataSource {
    [self addItems:items beginWithIndex:[dataSource count] withDataSource:dataSource];
}

- (void)addItemsToLast:(NSArray *)items withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section {
    [self addItems:items beginWithIndex:[dataSource count] withDataSource:dataSource inSection:section];
}

- (void)addItem:(id)item toIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource {
    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:index withDataSource:dataSource];
}

- (void)addItem:(id)item toIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section {
    [self addItems:[NSArray arrayWithObject:item] beginWithIndex:index withDataSource:dataSource inSection:section];
}

- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource {
    [self addItems:items beginWithIndex:index withDataSource:dataSource inSection:0];
}

- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)seciton {
    if (dataSource==nil || items==nil || [items isKindOfClass:[NSNull class]]) {
        return ;
    }
    NSUInteger itmesCount = items.count;
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, items.count)];
    
    [dataSource insertObjects:items atIndexes:indexSet];
    
    NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
    NSIndexPath *indexPath = nil;
    for (int i=0; i<itmesCount; i++) {
        indexPath = [NSIndexPath indexPathForRow:index+i inSection:seciton];
        [indexPaths addObject:indexPath];
    }
    
    [self insertItemsAtIndexPaths:indexPaths];
}

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath withDataSource:(NSMutableArray *)dataSource {
    [dataSource removeObjectAtIndex:indexPath.row];
    [self deleteItemsAtIndexPaths:@[indexPath]];
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
    
    [self deleteItemsAtIndexPaths:newIndexPaths];
}

@end
