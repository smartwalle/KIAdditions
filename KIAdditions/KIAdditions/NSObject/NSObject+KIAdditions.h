//
//  NSObject+KIAddition.h
//  Kitalker
//
//  Created by 杨 烽 on 12-10-24.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kNotificationObject @"kNotificationObject"

#define KIWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface NSObject (KIAdditions)

/*md5 加密*/
- (NSString *)md5;

/*当前系统语言*/
- (NSString *)appleLanguages;

/**************************************************
 *【NSNotificationCenter 相关】
 **************************************************/
/*注册成为指定消息的观察者*/
- (void)observeNotification:(NSString *)name;

- (void)observeNotification:(NSString *)name selector:(SEL)selector;

- (void)observeNotification:(NSString *)name selector:(SEL)selector object:(id)object;

- (id)observeNotification:(NSString *)name block:(void (^)(NSNotification *noti))block;

- (id)observeNotification:(NSString *)name queue:(NSOperationQueue *)queue block:(void (^)(NSNotification *noti))block;

- (void)unobserveNotification:(NSString *)name;

- (void)unobserveAllNotification;

- (void)postNotification:(NSString *)name;

- (void)postNotification:(NSString *)name withObject:(id)object;

- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo;

- (void)postNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

/*重写这个方法，用于处理接收到的notification
 如果同时存在 handleNotification:withObject 和handleNotification:object:userInfo，将优先调用后者
 */
- (void)handleNotification:(NSString *)name withObject:(id)object;

- (void)handleNotification:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo;

/**************************************************
 *【键盘相关】
 **************************************************/
- (void)observeKeyboardWillChangeNotification;

- (void)unobserveKeyboardWillChangeNotification;

/*重写这个方法，用于处理键盘高度改变事件*/
- (void)changeKeyboardHeight:(CGFloat)height animationDuration:(NSTimeInterval)duration;

/**************************************************
 *【应用即将异常退出】
 **************************************************/
- (void)observeApplicationWillTerminateNotification;

- (void)unobserveApplicationWillTerminateNotification;

- (void)applicationWillTerminate:(UIApplication *)application;

/*判断是否为字符串*/
- (BOOL)isString;

/*判断是否为NSArray*/
- (BOOL)isArray;

/*判断是否为不为空的NSArray*/
- (BOOL)isEmptyArray;

- (BOOL)isNotEmptyArray;

/*判断是否为NSDictionary*/
- (BOOL)isDictionary;

/*判断是否为不为空的NSDictionary*/
- (BOOL)isNotEmptyDictionary;

/*打开一个URL*/
- (void)openURL:(NSURL *)url;

/*发送邮件*/
- (void)sendMail:(NSString *)mail;

/*发送短信*/
- (void)sendSMS:(NSString *)number;

/*打电话*/
- (void)callNumber:(NSString *)number;

/*创建一个定时器，不用的时候，需要手动释放返回的 dispatch_source_t,
 如果是arc，需要在class中保持返回的dispatch_source_对象
 interval 为毫秒
 */
- (dispatch_source_t)createTimer:(dispatch_queue_t)queue
                        interval:(int)interval
                           block:(void(^)(NSUInteger count))block;

/*倒计时器，不用的时候，需要手动释放返回的 dispatch_source_t。如果是计时器结束，则会自动释放
 如果是arc，需要在class中保持返回的dispatch_source_对象
 interval 为秒
 */
- (dispatch_source_t)createCountDownTimer:(dispatch_queue_t)queue
                                    total:(int)total
                                 interval:(int)interval
                                    block:(void(^)(int countDown))block;

@end
