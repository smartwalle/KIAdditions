//
//  NSDictionary+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 12-11-28.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "NSDictionary+KIAdditions.h"

@implementation NSDictionary (KIAdditions)

- (BOOL)boolValueForKey:(id)key {
    return [[self objectForKey:key] boolValue];
}

- (int)intValueForKey:(id)key {
    return [[self objectForKey:key] intValue];
}

- (NSInteger)integerValueForKey:(id)key {
    return [[self objectForKey:key] integerValue];
}

- (float)floatValueForKey:(id)key {
    return [[self objectForKey:key] floatValue];
}

- (double)doubleValueForKey:(id)key {
    return [[self objectForKey:key] doubleValue];
}

- (NSString *)stringValueForKey:(id)key {
    if (![self isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    
    id value = [self objectForKey:key];
    if (value == [NSNull null] || value == nil) {
        value = @"";
    }
    if (![value isKindOfClass:[NSString class]]) {
        value = [[NSString alloc] initWithFormat:@"%@", value];
    }
    return value;
}

- (id)valueForKey:(NSString *)key defaultValue:(id)defaultValue {
    id value = [self objectForKey:key];
    if (value == [NSNull null] || value == nil) {
        value = nil;
    }
    return value;
}

@end

@implementation NSObject (Dictionary)

- (BOOL)isDictionary {
    if ([self isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)isNotEmptyDictionary {
    if ([self isDictionary]) {
        NSDictionary *tempDict = (NSDictionary *)self;
        if ([tempDict count] > 0) {
            return YES;
        }
    }
    return NO;
}

@end
