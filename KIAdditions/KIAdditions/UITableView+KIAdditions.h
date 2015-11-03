//
//  UITableView+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-3-27.
//  Copyright (c) 2013年 杨 烽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (KIAdditions)

- (void)setBackgroundImage:(UIImage *)image;

- (void)setBackgroundColor:(UIColor *)color;

- (void)setSeparatorImage:(UIImage *)image;

- (void)addItemToFirst:(id)item withDataSource:(NSMutableArray *)dataSource;

- (void)addItemsToFirst:(NSArray *)items withDataSource:(NSMutableArray *)dataSource;

- (void)addItemToLast:(id)item withDataSource:(NSMutableArray *)dataSource;

- (void)addItemsToLast:(NSArray *)items withDataSource:(NSMutableArray *)dataSource;

- (void)addItem:(id)item toIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource;

- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index withDataSource:(NSMutableArray *)dataSource;

- (void)addItems:(NSArray *)items beginWithIndex:(NSUInteger)index itemCountInRow:(NSUInteger)itemCountInRow withDataSource:(NSMutableArray *)dataSource;

- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath withDataSource:(NSMutableArray *)dataSource;

- (void)removeItemsAtIndexPaths:(NSArray *)indexPaths withDataSource:(NSMutableArray *)dataSource;

@end
