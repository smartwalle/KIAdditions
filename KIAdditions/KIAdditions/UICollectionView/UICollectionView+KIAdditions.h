//
//  UICollectionView+KIAdditions.h
//  KIAdditions
//
//  Created by apple on 16/3/1.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (KIAdditions)

- (void)addItemToFirst:(id)item withDataSource:(NSMutableArray *)dataSource;
- (void)addItemToFirst:(id)item withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section;

- (void)addItemsToFirst:(NSArray *)items withDataSource:(NSMutableArray *)dataSource;
- (void)addItemsToFirst:(NSArray *)items withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section;

- (void)addItemToLast:(id)item withDataSource:(NSMutableArray *)dataSource;
- (void)addItemToLast:(id)item withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section;

- (void)addItemsToLast:(NSArray *)items withDataSource:(NSMutableArray *)dataSource;
- (void)addItemsToLast:(NSArray *)items withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section;

- (void)addItem:(id)item toIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource;
- (void)addItem:(id)item toIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)section;

- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource;
- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource inSection:(NSInteger)seciton;

@end
