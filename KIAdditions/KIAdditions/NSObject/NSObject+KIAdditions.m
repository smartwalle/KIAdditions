//
//  NSObject+KIAddition.m
//  Kitalker
//
//  Created by 杨 烽 on 12-10-24.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "NSObject+KIAdditions.h"

@implementation NSObject (KIAdditions)

- (void)observeNotification:(NSString *)name {
    [self observeNotification:name selector:@selector(ki_handleNotification:)];
}

- (void)observeNotification:(NSString *)name selector:(SEL)selector {
    [self observeNotification:name selector:selector object:nil];
}

- (void)observeNotification:(NSString *)name selector:(SEL)selector object:(id)object {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:object];
}

- (id)observeNotification:(NSString *)name block:(void (^)(NSNotification *noti))block {
    return [self observeNotification:name queue:[NSOperationQueue mainQueue] block:block];
}

- (id)observeNotification:(NSString *)name queue:(NSOperationQueue *)queue block:(void (^)(NSNotification *noti))block {
    return [self observeNotification:name object:nil queue:queue block:block];
}

- (id)observeNotification:(NSString *)name
                     object:(id)object
                      queue:(NSOperationQueue *)queue
                      block:(void (^)(NSNotification *note))block {
    return [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                             object:object
                                                              queue:queue
                                                         usingBlock:block];
}

- (void)unobserveNotification:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:name
                                                  object:nil];
}

- (void)unobserveAllNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)postNotification:(NSString *)name {
    [self postNotification:name object:nil userInfo:nil];
}

- (void)postNotification:(NSString *)name withObject:(id)object {
    if (object == nil) {
        object = @"";
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:object forKey:kNotificationObject];
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:nil
                                                      userInfo:userInfo];
}

- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [self postNotification:name object:nil userInfo:userInfo];
}

- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:object
                                                      userInfo:userInfo];
}

- (void)ki_handleNotification:(NSNotification *)noti {
    if ([self respondsToSelector:@selector(handleNotification:object:userInfo:)]) {
        [self handleNotification:noti.name object:noti.object userInfo:noti.userInfo];
    } else if ([self respondsToSelector:@selector(handleNotification:withObject:)]) {
        [self handleNotification:noti.name withObject:[noti.userInfo objectForKey:kNotificationObject]];
    }
}

- (void)handleNotification:(NSString *)name withObject:(id)object {
    
}

- (void)handleNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    
}

//键盘
- (void)observeKeyboardWillChangeNotification {
    [self observeNotification:UIKeyboardWillShowNotification selector:@selector(ki_keyboardWillShow:)];
    [self observeNotification:UIKeyboardWillHideNotification selector:@selector(ki_keyboardWillHide:)];
    [self observeNotification:UIKeyboardWillChangeFrameNotification selector:@selector(ki_keyboardWillShow:)];
}

- (void)unobserveKeyboardWillChangeNotification {
    [self unobserveNotification:UIKeyboardWillShowNotification];
    [self unobserveNotification:UIKeyboardWillHideNotification];
    [self unobserveNotification:UIKeyboardWillChangeFrameNotification];
}

- (void)ki_keyboardWillShow:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self changeKeyboardHeight:CGRectGetHeight(keyboardRect) animationDuration:animationDuration];
}

- (void)ki_keyboardWillHide:(NSNotification *)noti {
    NSDictionary *userInfo = [noti userInfo];
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    [self changeKeyboardHeight:0.0 animationDuration:animationDuration];
}

- (void)changeKeyboardHeight:(CGFloat)height animationDuration:(NSTimeInterval)duration {
    
}

- (void)observeApplicationWillTerminateNotification {
    [self observeNotification:UIApplicationWillTerminateNotification
                     selector:@selector(ki_applicationWillTerminateNotification:)];
}

- (void)unobserveApplicationWillTerminateNotification {
    [self unobserveNotification:UIApplicationWillTerminateNotification];
}

- (void)ki_applicationWillTerminateNotification:(NSNotification *)noti {
    UIApplication *application = [UIApplication sharedApplication];
    [self applicationWillTerminate:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (BOOL)isString {
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

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

- (dispatch_source_t)createTimer:(dispatch_queue_t)queue
                        interval:(int)interval
                           block:(void(^)(NSUInteger count))block {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    __block NSUInteger totalTime = 0;
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval*NSEC_PER_MSEC, NSEC_PER_MSEC);
        dispatch_source_set_event_handler(timer, ^{
            block(totalTime);
            totalTime++;
        });
        dispatch_resume(timer);
    }
    return timer;
}

- (dispatch_source_t)createCountDownTimer:(dispatch_queue_t)queue
                                    total:(int)total
                                 interval:(int)interval
                                    block:(void(^)(int countDown))block {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    __block int totalTime = total;
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), interval*NSEC_PER_SEC, NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (totalTime >= 0) {
                block(totalTime);
                totalTime -= interval;
            } else {
                dispatch_source_cancel(timer);
            }
        });
        dispatch_resume(timer);
    }
    return timer;
}

@end
