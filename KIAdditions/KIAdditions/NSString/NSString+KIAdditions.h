//
//  NSString+KIString.h
//  Kitalker
//
//  Created by 杨 烽 on 12-7-6.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#import "NSData+KIAdditions.h"

#define KIString(xxx, ...) [NSString stringWithFormat:xxx, ##__VA_ARGS__]

@interface NSString (KIAdditions)

+ (BOOL)isEmptyString:(NSString *)string;

+ (BOOL)isNotEmptyString:(NSString *)string;

/*md5 加密*/
- (NSString *)md5;

/*sha1 加密*/
- (NSString *)sha1;

- (NSData *)hmacsha1WithSecret:(NSString *)secret;

/*base64 加密*/
- (NSString *)base64Encoded;

/*base64 加密*/
- (NSString *)base64Decoded;

/*URLEncoded*/
- (NSString *)URLEncodedString;

/*URLDecoded*/
- (NSString *)URLDecodedString;

/*判断是否为空或者nil*/
- (BOOL)isNotEmptyString;

/*返回实际的长度，一个中文字符算作两个长度*/
- (NSUInteger)actualLength;

/*去除空格*/
- (NSString *)trimWhitespace;

/*去除左右空格*/
- (NSString *)trimLeftAndRightWhitespace;

/*去除html标签*/
- (NSString *)trimHTMLTag;

/*判断是否为空白字符串*/
- (BOOL)isWhitespace;

/*判断是否匹配某个正则*/
- (BOOL)isMatchesRegularExp:(NSString *)regex;

/*判断是否为email*/
- (BOOL)isEmail;

/*返回URL的正则表达式*/
- (NSString *)URLPattern;

/*判断是否为URL*/
- (BOOL)isURL;

/*返回其中包含的URL列表*/
- (NSArray *)URLList;

/*判断是否为手机号码*/
- (BOOL)isCellPhoneNumber;

/*判断是否为电话号码*/
- (BOOL)isPhoneNumber;

/*判断是否为中国地区邮编*/
- (BOOL)isZipCode;

- (id)jsonObject:(NSError **)error;

/*转换为数值进行比较*/
- (NSComparisonResult)numericCompare:(NSString *)string;
- (NSComparisonResult)floatCompare:(NSString *)string;

@end
