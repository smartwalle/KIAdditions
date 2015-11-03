//
//  UINavigationController+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-3-28.
//  
//

#import <UIKit/UIKit.h>

@interface UINavigationController (KIAdditions)

- (void)popToViewControllerAtIndex:(NSUInteger)index;

- (void)appendViewControllers:(NSArray *)viewControllers;

@end
