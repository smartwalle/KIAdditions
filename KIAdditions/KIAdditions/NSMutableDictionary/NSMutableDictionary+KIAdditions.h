//
//  NSMutableDictionary+KIAdditions.h
//  HBNCW
//
//  Created by 杨 烽 on 13-10-24.
//  Copyright (c) 2013年 杨烽. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (KIAdditions)

- (void)setBoolValue:(BOOL)value forKey:(id)key;

- (void)setIntValue:(int)value forKey:(id)key;

- (void)setIntegerValue:(NSInteger)value forKey:(id)key;

- (void)setUIntegerValue:(NSUInteger)value forKey:(id)key;

- (void)setFloatValue:(float)value forKey:(id)key;

- (void)setDoubleValue:(double)value forKey:(id)key;

@end
