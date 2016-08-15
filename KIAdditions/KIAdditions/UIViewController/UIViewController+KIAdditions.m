//
//  UIViewController+KIViewController.m
//  Kitalker
//
//  Created by 杨 烽 on 12-7-28.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "UIViewController+KIAdditions.h"

@implementation UIViewController (KIAdditions)

- (void)pushViewController:(UIViewController *)viewController {
    [self pushViewController:viewController withAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self pushViewController:viewController animated:animated];
    } else if (self.navigationController != nil) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (void)popViewController {
    if ([self isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)self popViewControllerAnimated:YES];
    }
    if (self.navigationController != nil) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController withAnimated:YES];
}

- (void)presentViewController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    [self presentViewController:viewController animated:animated completion:^{
    }];
}

- (void)dismissModalViewController {
    if (self.navigationController != nil) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)presentWithNavigationController:(UIViewController *)viewController {
    [self presentWithNavigationController:viewController withAnimated:YES];
}

- (void)presentWithNavigationController:(UIViewController *)viewController withAnimated:(BOOL)animated {
    if (viewController != nil) {
        UINavigationController *navController = nil;
        if ([viewController isKindOfClass:[UINavigationController class]]) {
            navController = (UINavigationController *)viewController;
        } else {
            navController = [[UINavigationController alloc] initWithRootViewController:viewController];
        }
        [self presentViewController:navController withAnimated:animated];
        navController = nil;
    }
}

- (void)close {
    if (self.presentingViewController != nil) {
       [self dismissModalViewController];
    } else {
        [self popViewController];
    }
}

@end
