//
//  UIButton+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 12-11-23.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KIAdditions)

- (void)setTitle:(NSString *)title;

- (void)setImage:(UIImage *)normal;

- (void)setImage:(UIImage *)normal
     highlighted:(UIImage *)highlighted
        disabled:(UIImage *)disabled
        selected:(UIImage *)selected;

- (void)setBackgroundImage:(UIImage *)normal;

- (void)setBackgroundImage:(UIImage *)normal
               highlighted:(UIImage *)highlighted
                  disabled:(UIImage *)disabled
                  selected:(UIImage *)selected;

- (void)setTitleColor:(UIColor *)normal;

- (void)setTitleColor:(UIColor *)normal
          highlighted:(UIColor *)highlighted
             disabled:(UIColor *)disabled
             selected:(UIColor *)selected;

@end
