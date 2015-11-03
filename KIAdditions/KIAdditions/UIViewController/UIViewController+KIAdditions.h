//
//  UIViewController+KIViewController.h
//  Kitalker
//
//  Created by 杨 烽 on 12-7-28.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KIAdditions)

- (void)pushViewController:(UIViewController *)viewController;

- (void)pushViewController:(UIViewController *)viewController withAnimated:(BOOL)animated;

- (void)popViewController;

- (void)presentViewController:(UIViewController *)viewController;

- (void)presentViewController:(UIViewController *)viewController withAnimated:(BOOL)animated;

- (void)dismissModalViewController;

- (void)presentWithNavigationController:(UIViewController *)viewController;

- (void)presentWithNavigationController:(UIViewController *)viewController withAnimated:(BOOL)animated;

- (void)close;

@end
