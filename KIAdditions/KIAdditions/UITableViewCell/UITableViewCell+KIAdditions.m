//
//  UITableViewCell+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-4-13.
//
//

#import "UITableViewCell+KIAdditions.h"
#import <objc/runtime.h>
#import <objc/message.h>

static char KI_TABLE_VIEW_CELL_DELEGATE;

@implementation UITableViewCell (KIAdditions)

@dynamic cellDelegate;

- (void)setCellDelegate:(id<UITableViewCellDelegate>)delegate {
    objc_setAssociatedObject(self, &KI_TABLE_VIEW_CELL_DELEGATE, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UITableViewCellDelegate>)cellDelegate {
    return objc_getAssociatedObject(self, &KI_TABLE_VIEW_CELL_DELEGATE);
}

- (void)postMessage:(NSString *)message object:(id)object {
    if (self.cellDelegate != nil) {
        if ([self.cellDelegate respondsToSelector:@selector(tableViewCell:didPostMessage:object:)]) {
            [self.cellDelegate tableViewCell:self didPostMessage:message object:object];
        }
    }
}


- (NSIndexPath *)indexPath {
    return [self indexPathWithTableView];
}

- (void)setBackgroundImage:(UIImage *)image {
    [self setBackgroundViewImage:image];
}

- (void)setBackgroundViewColor:(UIColor *)color {
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    
    if (self.backgroundView == nil) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        [backgroundView setOpaque:YES];
        [self setBackgroundView:backgroundView];
        backgroundView = nil;
    }
    [self.backgroundView setBackgroundColor:color];
}

- (void)setBackgroundViewImage:(UIImage *)image  {
    if (image == nil) {
        [self setBackgroundViewColor:nil];
        return ;
    }
    
    if (![self.backgroundView isKindOfClass:[UIImageView class]]) {
        [self.backgroundView removeFromSuperview];
    }
    
    UIImageView *imageView = (UIImageView *)[self backgroundView];
    
    if (imageView == nil) {
        imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self setBackgroundView:imageView];
    }
    
    [imageView setImage:image];
}

- (void)setSelectedBackgroundViewColor:(UIColor *)color {
    if (color == nil) {
        color = [UIColor whiteColor];
    }
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    [selectedBackgroundView setOpaque:YES];
    [selectedBackgroundView setBackgroundColor:color];
    [self setSelectedBackgroundView:selectedBackgroundView];
    selectedBackgroundView = nil;
}

- (void)setSelectedBackgroundViewImage:(UIImage *)image {
    if (image == nil) {
        [self setSelectedBackgroundViewColor:nil];
        return ;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [imageView setImage:image];
    [self setSelectedBackgroundView:imageView];
    imageView = nil;
}

@end


@implementation UIView (UITableViewCell)

- (UITableView *)tableView {
    UITableView *tableView = nil;
    UIView *superView = self.superview;
    if ([superView isKindOfClass:[UITableView class]]) {
        tableView = (UITableView *)superView;
    } else {
        tableView = [superView tableView];
    }
    return tableView;
}

- (UITableViewCell *)cellWithTableView {
    UITableViewCell *cell = nil;
    UITableView *tableView = [self tableView];
    
    if (tableView != nil) {
        cell = [tableView cellForRowAtIndexPath:[self indexPathWithTableView]];
    }
    return cell;
}

- (NSIndexPath *)indexPathWithTableView {
    NSIndexPath *indexPath = nil;
    UITableView *tableView = [self tableView];
    
    if (tableView != nil) {
        CGPoint point = [tableView convertPoint:self.frame.origin fromView:self.superview];
        indexPath = [tableView indexPathForRowAtPoint:point];
    }
    
    return indexPath;
}

@end