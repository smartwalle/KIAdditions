//
//  UICollectionViewCell+KIAdditions.m
//  KIAdditions
//
//  Created by apple on 16/1/6.
//  Copyright (c) 2016年 smartwalle. All rights reserved.
//

#import "UICollectionViewCell+KIAdditions.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char KI_COLLECTION_VIEW_CELL_DELEGATE;

@implementation UICollectionViewCell (KIAdditions)

@dynamic cellDelegate;

- (void)setCellDelegate:(id<UICollectionViewCellDelegate>)delegate {
    objc_setAssociatedObject(self, &KI_COLLECTION_VIEW_CELL_DELEGATE, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UICollectionViewCellDelegate>)cellDelegate {
    return objc_getAssociatedObject(self, &KI_COLLECTION_VIEW_CELL_DELEGATE);
}

- (void)postMessage:(NSString *)message object:(id)object {
    if (self.cellDelegate != nil) {
        if ([self.cellDelegate respondsToSelector:@selector(collectionViewCell:didPostMessage:object:)]) {
            [self.cellDelegate collectionViewCell:self didPostMessage:message object:object];
        }
    }
}

- (NSIndexPath *)indexPath {
    return [self indexPathWithCollectionView];
}

@end

@implementation UIView (UICollectionViewCell)

- (UICollectionView *)collectionView {
    UICollectionView *collectionView = nil;
    UIView *superView = self.superview;
    if ([superView isKindOfClass:[UICollectionView class]]) {
        collectionView = (UICollectionView *)superView;
    } else {
        collectionView = [superView collectionView];
    }
    return collectionView;
}

- (UICollectionViewCell *)cellWithCollectionView {
    UICollectionViewCell *cell = nil;
    UICollectionView *collectionView = [self collectionView];
    if (collectionView != nil) {
        cell = [collectionView cellForItemAtIndexPath:[self indexPathWithCollectionView]];
    }
    return cell;
}

- (NSIndexPath *)indexPathWithCollectionView {
    NSIndexPath *indexPath = nil;
    UICollectionView *collectionView = [self collectionView];
    if (collectionView != nil) {
        CGPoint point = [collectionView convertPoint:self.frame.origin fromView:self.superview];
        indexPath = [collectionView indexPathForItemAtPoint:point];
    }
    return indexPath;
}


@end