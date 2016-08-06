//
//  UINavigationBar+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-11-6.
//  Copyright (c) 2013年 杨 烽. All rights reserved.
//

#import "UINavigationBar+KIAdditions.h"
#import "objc/runtime.h"

static char KI_NAVIGATION_BAR_HEIGHT;

@implementation UINavigationBar (KIAdditions)

- (void)setBarShadowImage:(UIImage *)image {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self setShadowImage:image];
    } else {
        static int SHADOW_IMAGE_VIEW_TAG = 979797;
        UIView *shadowView = [self viewWithTag:SHADOW_IMAGE_VIEW_TAG];
        
        if (shadowView == nil) {
            shadowView = [[UIView alloc] init];
            [self addSubview:shadowView];
        }
        [shadowView setFrame:CGRectMake(0,
                                        CGRectGetHeight(self.frame),
                                        CGRectGetWidth(self.frame),
                                        image.size.height)];
        [shadowView setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
}

- (void)setHeight:(CGFloat)height {
    objc_setAssociatedObject(self, &KI_NAVIGATION_BAR_HEIGHT, @(height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)height {
    NSNumber *h = objc_getAssociatedObject(self, &KI_NAVIGATION_BAR_HEIGHT);
    if (h) {
        return [h floatValue];
    }
    return CGRectGetHeight(self.frame);
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize;
    NSNumber *h = objc_getAssociatedObject(self, &KI_NAVIGATION_BAR_HEIGHT);
    if (h) {
        newSize = CGSizeMake(CGRectGetWidth(self.frame), [h floatValue]);
    } else {
        newSize = [super sizeThatFits:size];
    }
    
    return newSize;
}

@end
