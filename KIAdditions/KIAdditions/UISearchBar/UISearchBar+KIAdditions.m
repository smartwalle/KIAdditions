//
//  UISearchBar+KIAdditions.m
//  KISearchBar
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import "UISearchBar+KIAdditions.h"
#import <objc/runtime.h>

static char *KI_SEARCH_BAR_CONTEXT_VIEW_KEY = "KI_SEARCH_BAR_CONTEXT_VIEW_KEY";

#pragma mark - KISearchBarContextView
@interface KISearchBarContextView : UIView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray     *dataSource;

@property (nonatomic, copy) KISearchBarNumberOfSectionsBlock            _KISearchBarNumberOfSectionsBlock;
@property (nonatomic, copy) KISearchBarTitleForHeaderInSectionBlock     _KISearchBarTitleForHeaderInSectionBlock;
@property (nonatomic, copy) KISearchBarNumberOfRowsInSectionBlock       _KISearchBarNumberOfRowsInSectionBlock;
@property (nonatomic, copy) KISearchBarHeightForRowAtIndexPathBlock     _KISearchBarHeightForRowAtIndexPathBlock;
@property (nonatomic, copy) KISearchBarCellForRowAtIndexPathBlock       _KISearchBarCellForRowAtIndexPathBlock;
@property (nonatomic, copy) KISearchBarDidSelectedItemBlock             _KISearchBarDidSelectedItemBlock;
@end

@implementation KISearchBarContextView

- (void)layoutSubviews {
    [super layoutSubviews];
    [_tableView setFrame:self.bounds];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self.superview endEditing:YES];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self._KISearchBarNumberOfSectionsBlock != nil) {
        return self._KISearchBarNumberOfSectionsBlock(tableView);
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self._KISearchBarTitleForHeaderInSectionBlock != nil) {
        return self._KISearchBarTitleForHeaderInSectionBlock(tableView, section);
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self._KISearchBarNumberOfRowsInSectionBlock != nil) {
        return self._KISearchBarNumberOfRowsInSectionBlock(tableView, section);
    }
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self._KISearchBarHeightForRowAtIndexPathBlock != nil) {
        return self._KISearchBarHeightForRowAtIndexPathBlock(tableView, indexPath);
    }
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self._KISearchBarCellForRowAtIndexPathBlock != nil) {
        return self._KISearchBarCellForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    static NSString *CELL_IDENTIFIER = @"KISearchBarCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    NSString *text = [self.dataSource objectAtIndex:indexPath.row];
    [cell.textLabel setText:text];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self._KISearchBarDidSelectedItemBlock != nil) {
        self._KISearchBarDidSelectedItemBlock(tableView, indexPath);
    }
}

#pragma mark - Getters & Setters
- (void)setNumberOfSectionsBlock:(KISearchBarNumberOfSectionsBlock)block {
    [self set_KISearchBarNumberOfSectionsBlock:block];
}

- (void)setTitleForHeaderInSectionBlock:(KISearchBarTitleForHeaderInSectionBlock)block {
    [self set_KISearchBarTitleForHeaderInSectionBlock:block];
}

- (void)setNumberOfRowsInSectionBlock:(KISearchBarNumberOfRowsInSectionBlock)block {
    [self set_KISearchBarNumberOfRowsInSectionBlock:block];
}

- (void)setHeightForRowAtIndexPathBlock:(KISearchBarHeightForRowAtIndexPathBlock)block {
    [self set_KISearchBarHeightForRowAtIndexPathBlock:block];
}

- (void)setCellForRowAtIndexPathBlock:(KISearchBarCellForRowAtIndexPathBlock)block {
    [self set_KISearchBarCellForRowAtIndexPathBlock:block];
}

- (void)setDidSelectedItemBlock:(KISearchBarDidSelectedItemBlock)block {
    [self set_KISearchBarDidSelectedItemBlock:block];
}

#pragma mark - Methods
- (void)showTableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
    }
    [self addSubview:_tableView];
    [self bringSubviewToFront:_tableView];
    [_tableView reloadData];
}

- (void)hideTableView {
    [_tableView removeFromSuperview];
}

#pragma mark - Getters & Setters
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [_tableView reloadData];
}

@end

#pragma mark - UISearchBar(KIAdditions)
@implementation UISearchBar (KIAdditions)

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self showContextView];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self hideContextView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark - Methods
- (void)showContextView {
    [self _observeKeyboardNotification];
    
    CGRect contextViewFrame = [self contextViewFrameWithKeyboardHeight:0];
    [[self _contextView] setFrame:contextViewFrame];
    [[self _contextView] setAlpha:0.0f];
    [self.window addSubview:[self _contextView]];
    
    [UIView animateKeyframesWithDuration:0.2
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction | UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  [[self _contextView] setAlpha:1.0f];
                              } completion:^(BOOL finished) {
                              }];
}

- (void)hideContextView {
    [self _unobserveKeyboardNotification];
    
    [UIView animateKeyframesWithDuration:0.2
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionAllowUserInteraction | UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{
                                  [[self _contextView] setAlpha:0.0f];
                              } completion:^(BOOL finished) {
                                  [[self _contextView] removeFromSuperview];
                              }];
}

- (void)showTableView {
    [[self _contextView] showTableView];
}

- (void)hideTableView {
    [[self _contextView] hideTableView];
}

#pragma mark - Keyboard
- (void)_observeKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)_unobserveKeyboardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)_keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self _changeKeyboardHeight:CGRectGetHeight(keyboardRect) animationDuration:animationDuration];
}

- (void)_keyboardWillHide:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self _changeKeyboardHeight:0.0 animationDuration:animationDuration];
}

- (void)_changeKeyboardHeight:(CGFloat)height animationDuration:(NSTimeInterval)duration {
    CGRect contextViewFrame = [self contextViewFrameWithKeyboardHeight:height];
    
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         [[self _contextView] setFrame:contextViewFrame];
                     } completion:^(BOOL finished) {
                     }];
}

#pragma mark - Getters & Setters
- (UIWindow *)window {
    return [[UIApplication sharedApplication] keyWindow];
}

- (CGRect)contextViewFrameWithKeyboardHeight:(CGFloat)height {
    CGRect windowBounds = self.window.bounds;
    CGRect rect = [self rectToWindow];
    CGRect contextViewFrame = CGRectMake(CGRectGetMinX(rect),
                                         CGRectGetMaxY(rect),
                                         CGRectGetWidth(rect),
                                         CGRectGetHeight(windowBounds) - CGRectGetMaxY(rect) - height);
    return contextViewFrame;
}

- (CGRect)rectToWindow {
    CGRect rect = [self.superview convertRect:self.frame toView:self.window];
    return rect;
}

- (KISearchBarContextView *)_contextView {
    KISearchBarContextView *mv = (KISearchBarContextView *)objc_getAssociatedObject(self, &KI_SEARCH_BAR_CONTEXT_VIEW_KEY);
    if (mv == nil) {
        mv = [[KISearchBarContextView alloc] init];
        [mv setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        objc_setAssociatedObject(self, &KI_SEARCH_BAR_CONTEXT_VIEW_KEY, mv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return mv;
}

- (UIView *)contextView {
    return [self _contextView];
}

- (UITableView *)tableView {
    return [[self _contextView] tableView];
}

- (NSArray *)dataSource {
    return [[self _contextView] dataSource];
}

- (void)setDataSource:(NSArray *)dataSource {
    [[self _contextView] setDataSource:dataSource];
}

- (void)setNumberOfSectionsBlock:(KISearchBarNumberOfSectionsBlock)block {
    [[self _contextView] setNumberOfSectionsBlock:block];
}

- (void)setTitleForHeaderInSectionBlock:(KISearchBarTitleForHeaderInSectionBlock)block {
    [[self _contextView] setTitleForHeaderInSectionBlock:block];
}

- (void)setNumberOfRowsInSectionBlock:(KISearchBarNumberOfRowsInSectionBlock)block {
    [[self _contextView] setNumberOfRowsInSectionBlock:block];
}

- (void)setHeightForRowAtIndexPathBlock:(KISearchBarHeightForRowAtIndexPathBlock)block {
    [[self _contextView] setHeightForRowAtIndexPathBlock:block];
}

- (void)setCellForRowAtIndexPathBlock:(KISearchBarCellForRowAtIndexPathBlock)block {
    [[self _contextView] setCellForRowAtIndexPathBlock:block];
}

- (void)setDidSelectedItemBlock:(KISearchBarDidSelectedItemBlock)block {
    [[self _contextView] setDidSelectedItemBlock:block];
}

@end
