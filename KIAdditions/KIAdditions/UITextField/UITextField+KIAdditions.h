//
//  UITextField+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-4-12.
//
//

#import <UIKit/UIKit.h>

@interface UITextField (KIAdditions)

- (void)setPlaceholderColor:(UIColor *)color;

- (void)setBackgroundImage:(UIImage *)image;

- (void)setBackgroundImage:(UIImage *)image stretchWithX:(NSInteger)x stretchWithY:(NSInteger)y;

- (void)setDisabledBackgroundImage:(UIImage *)image stretchWithX:(NSInteger)x stretchWithY:(NSInteger)y;

- (void)setLeftLabelTitle:(NSString *)text textColor:(UIColor *)textColor width:(CGFloat)width;

- (void)setLeftLabelTitle:(NSString *)text
                textColor:(UIColor *)textColor
                 textFont:(UIFont *)font
                    width:(CGFloat)width
          backgroundColor:(UIColor *)backgroundColor;

@end
