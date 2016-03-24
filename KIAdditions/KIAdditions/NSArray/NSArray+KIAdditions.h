//
//  NSArray+KIAdditions.h
//  KIAdditions
//
//  Created by apple on 16/3/24.
//  Copyright © 2016年 smartwalle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (KIAdditions)

@end

@interface NSObject (Array)

/*判断是否为NSArray*/
- (BOOL)isArray;

/*判断是否为不为空的NSArray*/
- (BOOL)isEmptyArray;

- (BOOL)isNotEmptyArray;

@end