//
//  UINavigationBar+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-11-6.
//  Copyright (c) 2013年 杨 烽. All rights reserved.
//

#import "UINavigationBar+KIAdditions.h"
#import "UIDevice+KIAdditions.h"

@implementation UINavigationBar (KIAdditions)

- (void)setBarShadowImage:(UIImage *)image {
    if (KI_IOS_6_OR_LATER) {
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

@end
