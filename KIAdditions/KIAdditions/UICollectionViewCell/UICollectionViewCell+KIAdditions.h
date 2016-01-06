//
//  UICollectionViewCell+KIAdditions.h
//  KIAdditions
//
//  Created by apple on 16/1/6.
//  Copyright (c) 2016年 smartwalle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UICollectionViewCellDelegate <NSObject>
@optional
- (void)collectionViewCell:(UICollectionViewCell *)cell didPostMessage:(NSString *)message object:(id)object;
@end

@interface UICollectionViewCell (KIAdditions)

@property (nonatomic, weak) id<UICollectionViewCellDelegate> cellDelegate;

//cell 中调用，用于向外部发送消息
- (void)postMessage:(NSString *)message object:(id)object;

- (NSIndexPath *)indexPath;

@end

@interface UIView (UICollectionViewCell)

- (UICollectionView *)collectionView;

- (UICollectionViewCell *)cellWithCollectionView;

- (NSIndexPath *)indexPathWithCollectionView;

@end
