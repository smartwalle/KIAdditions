//
//  NSDictionary+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 12-11-28.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KIAdditions)

- (BOOL)boolValueForKey:(id)key;

- (int)intValueForKey:(id)key;

- (NSInteger)integerValueForKey:(id)key;

- (float)floatValueForKey:(id)key;

- (double)doubleValueForKey:(id)key;

- (NSString *)stringValueForKey:(id)key;

- (id)valueForKey:(NSString *)key defaultValue:(id)defaultValue;

@end


@interface NSObject (Dictionary)

/*判断是否为NSDictionary*/
- (BOOL)isDictionary;

/*判断是否为不为空的NSDictionary*/
- (BOOL)isNotEmptyDictionary;

@end