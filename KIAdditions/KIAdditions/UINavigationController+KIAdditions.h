//
//  UINavigationController+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-3-28.
//  
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UINavigationController (KIAdditions)

- (void)popToViewControllerAtIndex:(NSUInteger)index;

- (void)appendViewControllers:(NSArray *)viewControllers;

@end
