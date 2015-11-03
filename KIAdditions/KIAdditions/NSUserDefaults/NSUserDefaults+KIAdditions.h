//
//  NSUserDefaults+KIAdditions.h
//  Kitalker
//
//  Created by 杨 烽 on 13-11-29.
//
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (KIAdditions)

+ (void)registerDefaultValue:(id)value                  forKey:(NSString *)key;
+ (void)registerDefaultString:(NSString *)value         forKey:(NSString *)key;
+ (void)registerDefaultArray:(NSArray *)value           forKey:(NSString *)key;
+ (void)registerDefaultDictionary:(NSDictionary *)value forKey:(NSString *)key;
+ (void)registerDefaultData:(NSData *)value             forKey:(NSString *)key;
+ (void)registerDefaultInteger:(NSInteger)value         forKey:(NSString *)key;
+ (void)registerDefaultFloat:(float)value               forKey:(NSString *)key;
+ (void)registerDefaultDouble:(double)value             forKey:(NSString *)key;
+ (void)registerDefaultBool:(BOOL)value                 forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;
+ (void)removeObjectForKey:(NSString *)defaultName;

+ (NSString *)stringForKey:(NSString *)defaultName;
+ (NSArray *)arrayForKey:(NSString *)defaultName;
+ (NSDictionary *)dictionaryForKey:(NSString *)defaultName;
+ (NSData *)dataForKey:(NSString *)defaultName;
+ (NSArray *)stringArrayForKey:(NSString *)defaultName;
+ (NSInteger)integerForKey:(NSString *)defaultName;
+ (float)floatForKey:(NSString *)defaultName;
+ (double)doubleForKey:(NSString *)defaultName;
+ (BOOL)boolForKey:(NSString *)defaultName;
+ (NSURL *)URLForKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);

+ (void)setInteger:(NSInteger)value forKey:(NSString *)defaultName;
+ (void)setFloat:(float)value forKey:(NSString *)defaultName;
+ (void)setDouble:(double)value forKey:(NSString *)defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
+ (void)setURL:(NSURL *)url forKey:(NSString *)defaultName NS_AVAILABLE(10_6, 4_0);

+ (BOOL)synchronize;

- (void)registerDefaultValue:(id)value                  forKey:(NSString *)key;
- (void)registerDefaultString:(NSString *)value         forKey:(NSString *)key;
- (void)registerDefaultArray:(NSArray *)value           forKey:(NSString *)key;
- (void)registerDefaultDictionary:(NSDictionary *)value forKey:(NSString *)key;
- (void)registerDefaultData:(NSData *)value             forKey:(NSString *)key;
- (void)registerDefaultInteger:(NSInteger)value         forKey:(NSString *)key;
- (void)registerDefaultFloat:(float)value               forKey:(NSString *)key;
- (void)registerDefaultDouble:(double)value             forKey:(NSString *)key;
- (void)registerDefaultBool:(BOOL)value                 forKey:(NSString *)key;

@end
