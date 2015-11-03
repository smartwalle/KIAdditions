//
//  UIView+KIView.h
//  Kitalker
//
//  Created by 杨 烽 on 12-7-6.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define KIViewWithTarget(target, tag) ((id)[target viewWithTag:tag])

@interface UIView (KIAdditions)

@property (nonatomic, assign) id userInfo;

/*size*/
- (CGSize)size;
- (void)setSize:(CGSize)size;

/*x*/
- (CGFloat)x;
- (void)setX:(CGFloat)x;

/*y*/
- (CGFloat)y;
- (void)setY:(CGFloat)y;

/*width*/
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

/*height*/
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

/*top*/
- (CGFloat)top;
- (void)setTop:(CGFloat)top;

/*bottom*/
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

/*left*/
- (CGFloat)left;
- (void)setLeft:(CGFloat)left;

/*right*/
- (CGFloat)right;
- (void)setRight:(CGFloat)right;

/*快照*/
- (UIImage *)snapshot;

/*清除背景颜色*/
- (void)clearBackgroundColor;

/*设置背景图片*/
- (void)setBackgroundImage:(UIImage *)image;

/*设置View层顺序*/
- (void)setIndex:(NSInteger)index;

/*设置为最顶层View*/
- (void)bringToFront;

/*设置为最底层View*/
- (void)sendToBack;

- (void)registEndEditing;

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)radius;

/*设置边框颜色 和 边框宽度*/
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;

/*设置圆角*/
- (void)setCornerRadius:(CGFloat)radius;

/*设置外阴影*/
- (void)setShadowColor:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius;

- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target selector:(SEL)selector;

- (UIActivityIndicatorView *)activityIndicatorView;

- (UIViewController *)viewController;

@end
