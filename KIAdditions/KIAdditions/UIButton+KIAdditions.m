//
//  UIButton+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 12-11-23.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "UIButton+KIAdditions.h"

@implementation UIButton (KIAdditions)

- (void)setTitle:(NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setImage:(UIImage *)normal; {
    [self setImage:normal highlighted:nil disabled:nil selected:nil];
}

- (void)setImage:(UIImage *)normal
     highlighted:(UIImage *)highlighted
        disabled:(UIImage *)disabled
        selected:(UIImage *)selected {
    
    [self setImage:normal forState:UIControlStateNormal];
    if (highlighted != nil) {
        [self setImage:highlighted forState:UIControlStateHighlighted];
    }
    if (disabled != nil) {
        [self setImage:disabled forState:UIControlStateDisabled];
    }
    if (selected != nil) {
        [self setImage:selected forState:UIControlStateSelected];
    }
}

- (void)setBackgroundImage:(UIImage *)normal {
    [self setBackgroundImage:normal highlighted:nil disabled:nil selected:nil];
}

- (void)setBackgroundImage:(UIImage *)normal
               highlighted:(UIImage *)highlighted
                  disabled:(UIImage *)disabled
                  selected:(UIImage *)selected {
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    if (highlighted != nil) {
        [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    }
    if (disabled != nil) {
        [self setBackgroundImage:disabled forState:UIControlStateDisabled];
    }
    if (selected != nil) {
        [self setBackgroundImage:selected forState:UIControlStateSelected];
    }
}

- (void)setTitleColor:(UIColor *)normal {
    [self setTitleColor:normal highlighted:nil disabled:nil selected:nil];
}

- (void)setTitleColor:(UIColor *)normal
          highlighted:(UIColor *)highlighted
             disabled:(UIColor *)disabled
             selected:(UIColor *)selected {
    [self setTitleColor:normal forState:UIControlStateNormal];
    if (highlighted != nil) {
        [self setTitleColor:highlighted forState:UIControlStateHighlighted];
    }
    if (disabled != nil) {
        [self setTitleColor:disabled forState:UIControlStateDisabled];
    }
    if (selected != nil) {
        [self setTitleColor:selected forState:UIControlStateSelected];
    }
}

@end
