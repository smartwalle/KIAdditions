//
//  NSArray+KIAdditions.m
//  KIAdditions
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import "NSArray+KIAdditions.h"

@implementation NSArray (KIAdditions)

@end

@implementation NSObject (Array)

- (BOOL)isArray {
    if ([self isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isNotEmptyArray {
    if (self != nil && [self isArray] && [(NSArray *)self count] > 0) {
        return YES;
    }
    return NO;
}

@end