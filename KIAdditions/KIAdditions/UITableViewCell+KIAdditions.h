//
//  UITableViewCell+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-4-13.
//
//

#import <UIKit/UIKit.h>

@protocol UITableViewCellDelegate <NSObject>
@optional
- (void)tableViewCell:(UITableViewCell *)tableViewCell didPostMessage:(NSString *)message object:(id)object;
@end

@interface UITableViewCell (KIAdditions)

@property (nonatomic, weak) id<UITableViewCellDelegate> cellDelegate;

//cell 中调用，用于向外部发送消息
- (void)postMessage:(NSString *)message object:(id)object;


- (NSIndexPath *)indexPath;

- (void)setBackgroundViewColor:(UIColor *)color;

- (void)setBackgroundViewImage:(UIImage *)image;

- (void)setSelectedBackgroundViewColor:(UIColor *)color;

- (void)setSelectedBackgroundViewImage:(UIImage *)image;

@end

@interface UIView (UITableViewCell)

- (UITableView *)tableView;

- (UITableViewCell *)cellWithTableView;

- (NSIndexPath *)indexPathWithTableView;

@end
