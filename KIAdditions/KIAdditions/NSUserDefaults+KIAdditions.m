//
//  NSUserDefaults+KIAdditions.m
//  Kitalker
//
//  Created by 杨 烽 on 13-11-29.
//
//

#import "NSUserDefaults+KIAdditions.h"

@implementation NSUserDefaults (KIAdditions)

+ (void)registerDefaultValue:(id)value forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults registerDefaultValue:value forKey:key];
}

+ (void)registerDefaultString:(NSString *)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:value forKey:key];
}

+ (void)registerDefaultArray:(NSArray *)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:value forKey:key];
}

+ (void)registerDefaultDictionary:(NSDictionary *)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:value forKey:key];
}

+ (void)registerDefaultData:(NSData *)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:value forKey:key];
}

+ (void)registerDefaultInteger:(NSInteger)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:[NSNumber numberWithInteger:value] forKey:key];
}

+ (void)registerDefaultFloat:(float)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:[NSNumber numberWithFloat:value] forKey:key];
}

+ (void)registerDefaultDouble:(double)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:[NSNumber numberWithDouble:value] forKey:key];
}

+ (void)registerDefaultBool:(BOOL)value forKey:(NSString *)key {
    [NSUserDefaults registerDefaultValue:[NSNumber numberWithBool:value] forKey:key];
}


+ (id)objectForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}

+ (void)setObject:(id)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [NSUserDefaults synchronize];
}

+ (void)removeObjectForKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:defaultName];
}

+ (NSString *)stringForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:defaultName];
}

+ (NSArray *)arrayForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] arrayForKey:defaultName];
}

+ (NSDictionary *)dictionaryForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] dictionaryForKey:defaultName];
}

+ (NSData *)dataForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] dataForKey:defaultName];
}

+ (NSArray *)stringArrayForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] stringArrayForKey:defaultName];
}

+ (NSInteger)integerForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] integerForKey:defaultName];
}

+ (float)floatForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] floatForKey:defaultName];
}

+ (double)doubleForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:defaultName];
}

+ (BOOL)boolForKey:(NSString *)defaultName {
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}

+ (NSURL *)URLForKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0) {
    return [[NSUserDefaults standardUserDefaults] URLForKey:defaultName];
}


+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:defaultName];
    [NSUserDefaults synchronize];
}

+ (void)setFloat:(float)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:defaultName];
    [NSUserDefaults synchronize];
}

+ (void)setDouble:(double)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setDouble:value forKey:defaultName];
    [NSUserDefaults synchronize];
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:defaultName];
    [NSUserDefaults synchronize];
}

+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0) {
    [[NSUserDefaults standardUserDefaults] setURL:url forKey:defaultName];
    [NSUserDefaults synchronize];
}

+ (BOOL)synchronize{
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)registerDefaultValue:(id)value forKey:(NSString *)key {
    if (value && key) {
        [self registerDefaults:@{key:value}];
        [self synchronize];
    }
}

- (void)registerDefaultString:(NSString *)value forKey:(NSString *)key {
    [self registerDefaultValue:value forKey:key];
}

- (void)registerDefaultArray:(NSArray *)value forKey:(NSString *)key {
    [self registerDefaultValue:value forKey:key];
}

- (void)registerDefaultDictionary:(NSDictionary *)value forKey:(NSString *)key {
    [self registerDefaultValue:value forKey:key];
}

- (void)registerDefaultData:(NSData *)value forKey:(NSString *)key {
    [self registerDefaultValue:value forKey:key];
}

- (void)registerDefaultInteger:(NSInteger)value forKey:(NSString *)key {
    [self registerDefaultValue:[NSNumber numberWithInteger:value] forKey:key];
}

- (void)registerDefaultFloat:(float)value forKey:(NSString *)key {
    [self registerDefaultValue:[NSNumber numberWithFloat:value] forKey:key];
}

- (void)registerDefaultDouble:(double)value forKey:(NSString *)key {
    [self registerDefaultValue:[NSNumber numberWithDouble:value] forKey:key];
}

- (void)registerDefaultBool:(BOOL)value forKey:(NSString *)key {
    [self registerDefaultValue:[NSNumber numberWithBool:value] forKey:key];
}

@end
