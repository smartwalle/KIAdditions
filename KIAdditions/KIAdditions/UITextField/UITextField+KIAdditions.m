//
//  UITextField+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-4-12.
//
//

#import "UITextField+KIAdditions.h"

@implementation UITextField (KIAdditions)

- (void)setPlaceholderColor:(UIColor *)color {
    if (color == nil) {
        color = [UIColor grayColor];
    }
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setBackgroundImage:(UIImage *)image {
    [self setBackgroundImage:image stretchWithX:0 stretchWithY:0];
}

- (void)setBackgroundImage:(UIImage *)image stretchWithX:(NSInteger)x stretchWithY:(NSInteger)y{
    [self setBorderStyle:UITextBorderStyleNone];
    [self setBackground:[image stretchableImageWithLeftCapWidth:x topCapHeight:y]];
}

- (void)setDisabledBackgroundImage:(UIImage *)image stretchWithX:(NSInteger)x stretchWithY:(NSInteger)y {
    [self setBorderStyle:UITextBorderStyleNone];
    [self setDisabledBackground:[image stretchableImageWithLeftCapWidth:x topCapHeight:y]];
}

- (void)setLeftLabelTitle:(NSString *)text textColor:(UIColor *)textColor width:(CGFloat)width {
    [self setLeftLabelTitle:text
                  textColor:textColor
                   textFont:nil
                      width:width
            backgroundColor:nil];
}

- (void)setLeftLabelTitle:(NSString *)text
                textColor:(UIColor *)textColor
                 textFont:(UIFont *)font
                    width:(CGFloat)width
          backgroundColor:(UIColor *)backgroundColor {
    [self labelWithText:text
                 isLeft:YES
              textColor:textColor
               textFont:font
                  width:width
        backgroundColor:backgroundColor];
}

- (void)setRightLabelTitle:(NSString *)text
                 textColor:(UIColor *)textColor
                  textFont:(UIFont *)font
                     width:(CGFloat)width
           backgroundColor:(UIColor *)backgroundColor {
    [self labelWithText:text
                 isLeft:NO
              textColor:textColor
               textFont:font
                  width:width
        backgroundColor:backgroundColor];
}

- (UILabel *)labelWithText:(NSString *)text
                   isLeft:(BOOL)isLeft
                textColor:(UIColor *)textColor
                 textFont:(UIFont *)font
                    width:(CGFloat)width
          backgroundColor:(UIColor *)backgroundColor {
    static NSUInteger leftLabelTag = 0;
    static NSUInteger rightLabelTag = 0;
    if (leftLabelTag == 0) {
        leftLabelTag = [self hash]+1;
    }
    if (rightLabelTag == 0) {
        rightLabelTag = [self hash]+2;
    }
    
    NSUInteger tag = rightLabelTag;
    
    if (isLeft) {
        tag = leftLabelTag;
    }
    
    UILabel *label = (UILabel *)[self viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        [label setTag:tag];
        if (isLeft) {
            [self setLeftViewMode:UITextFieldViewModeAlways];
            [self setLeftView:label];
        } else {
            [self setRightViewMode:UITextFieldViewModeAlways];
            [self setRightView:label];
        }
        
        [label setAutoresizingMask:UIViewAutoresizingFlexibleWidth
                                    |UIViewAutoresizingFlexibleLeftMargin
                                    |UIViewAutoresizingFlexibleRightMargin];
        
    }
    
    if (font == nil) {
        font = self.font;
    }
    
    if (textColor == nil) {
        textColor = self.textColor;
    }
    
    if (backgroundColor == nil) {
        backgroundColor = [UIColor clearColor];
    }
    
    [label setFrame:CGRectMake(0, 0, width, CGRectGetHeight(self.bounds))];
    [label setTextAlignment:NSTextAlignmentRight];
    [label setFont:font];
    [label setTextColor:textColor];
    [label setBackgroundColor:backgroundColor];
    [label setText:text];
    
    return label;
}

@end
