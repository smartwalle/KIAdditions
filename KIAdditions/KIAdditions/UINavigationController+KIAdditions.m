//
//  UINavigationController+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-3-28.
//
//

#import "UINavigationController+KIAdditions.h"

@implementation UINavigationController (KIAdditions)

- (void)popToViewControllerAtIndex:(NSUInteger)index {
    NSUInteger count = [self viewControllers].count;
    if (index >= count-1) {
        return ;
    }
    
    [self popToViewController:[[self viewControllers] objectAtIndex:index]
                     animated:YES];
}

- (void)appendViewControllers:(NSArray *)viewControllers {
    NSMutableArray *vcs = [[NSMutableArray alloc] initWithArray:self.viewControllers];
    [vcs addObjectsFromArray:viewControllers];
    [self setViewControllers:vcs animated:YES];
}

@end
