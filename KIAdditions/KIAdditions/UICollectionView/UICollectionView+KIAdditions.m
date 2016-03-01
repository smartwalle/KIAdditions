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


@end
