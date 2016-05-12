//
//  UISearchBar+KIAdditions.h
//  KISearchBar
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSUInteger (^KISearchBarNumberOfSectionsBlock)            (UITableView *tableView);
typedef NSString *(^KISearchBarTitleForHeaderInSectionBlock)      (UITableView *tableView, NSInteger section);
typedef NSInteger (^KISearchBarNumberOfRowsInSectionBlock)        (UITableView *tableView, NSInteger section);
typedef CGFloat (^KISearchBarHeightForRowAtIndexPathBlock)        (UITableView *tableView, NSIndexPath *indexPath);
typedef UITableViewCell *(^KISearchBarCellForRowAtIndexPathBlock) (UITableView *tableView, NSIndexPath *indexPath);
typedef void(^KISearchBarDidSelectedItemBlock)                    (UITableView *tableView, NSIndexPath *indexPath);

@interface UISearchBar (KIAdditions)

@property (nonatomic) NSArray *dataSource;

- (UIView *)contextView;

- (UITableView *)tableView;

- (void)showTableView;
- (void)hideTableView;

- (void)setNumberOfSectionsBlock:(KISearchBarNumberOfSectionsBlock)block;
- (void)setTitleForHeaderInSectionBlock:(KISearchBarTitleForHeaderInSectionBlock)block;
- (void)setNumberOfRowsInSectionBlock:(KISearchBarNumberOfRowsInSectionBlock)block;
- (void)setHeightForRowAtIndexPathBlock:(KISearchBarHeightForRowAtIndexPathBlock)block;
- (void)setCellForRowAtIndexPathBlock:(KISearchBarCellForRowAtIndexPathBlock)block;
- (void)setDidSelectedItemBlock:(KISearchBarDidSelectedItemBlock)block;
@end
