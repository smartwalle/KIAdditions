//
//  NSData+KIData.h
//  Kitalker
//
//  Created by 杨 烽 on 12-9-21.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSData (KIAdditions)

/*md5 加密*/
- (NSString *)md5;

/*base64 加密*/
- (NSString *)base64Encoded;

/*base64 解密*/
- (NSData *)base64Decoded;

/*获取十六进制数据*/
- (NSString *)getHexValue;

/*utf-8*/
- (NSString *)getUTF8Value;

@end
