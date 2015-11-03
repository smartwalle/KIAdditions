//
//  NSString+KIString.m
//  Kitalker
//
//  Created by 杨 烽 on 12-7-6.
//  Copyright (c) 2012年 杨 烽. All rights reserved.
//

#import "NSString+KIAdditions.h"

@implementation NSString (KIAdditions)

+ (BOOL)isEmptyString:(NSString *)string {
    if (string != nil && (id)string != [NSNull null]) {
        return ![string isNotEmptyString];
    }
    return YES;
}

+ (BOOL)isNotEmptyString:(NSString *)string {
    return ![NSString isEmptyString:string];
}

+ (NSString *)fromInt:(int)value {
	return [NSString stringWithFormat:@"%d", value];
}

+ (NSString *)fromInteger:(NSInteger)value {
	return [NSString stringWithFormat:@"%ld", (long)value];
}

+ (NSString *)fromUInteger:(NSUInteger)value {
	return [NSString stringWithFormat:@"%lu", (unsigned long)value];
}

+ (NSString *)fromFloat:(float)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromDouble:(double)value {
	return [NSString stringWithFormat:@"%f", value];
}

+ (NSString *)fromBool:(BOOL)value {
	return [NSString stringWithFormat:@"%d", value];
}

- (NSString *)md5 {
    if (!self) {
        return nil;
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSMutableString *outString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    
    for(int i=0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [outString appendFormat:@"%02x", result[i]];
    }
    return outString;
}

- (NSString *)sha1 {
    if (!self) {
        return nil;
    }
    const char *cStr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *outString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    
    for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [outString appendFormat:@"%02x", digest[i]];
    }
    return outString;
}

- (NSData *)hmacsha1WithSecret:(NSString *)secret {
    
    const char *cKey  = [secret cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [self cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    
    return HMAC;
}

- (NSString *)base64Encoded {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64Encoded];
}

- (NSString *)base64Decoded {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [[NSString alloc] initWithData:[data base64Decoded] encoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncodedString {
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR(":/?#[]@!$&'()*+,;="),
                                                                           kCFStringEncodingUTF8));
	return result;
}

- (NSString *)URLDecodedString {
	NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(":/?#[]@!$&'()*+,;="),
																						   kCFStringEncodingUTF8));
	return result;
}

- (BOOL)isNotEmptyString {
    if (self != nil
        && ![self isKindOfClass:[NSNull class]]
        && (id)self != [NSNull null]
        && [[self trimWhitespace] length]>0) {
        return YES;
    }
    return NO;
}

- (NSUInteger)actualLength {
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [self dataUsingEncoding:encoding];
    return [data length];
}

- (NSString *)trimWhitespace {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimLeftAndRightWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimHTMLTag {
    NSString *html = self;
    
    NSScanner *scanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while (![scanner isAtEnd]) {
        [scanner scanUpToString:@"<" intoString:NULL];
        [scanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    return [html trimWhitespace];
}

- (BOOL)isWhitespace {
    if (self != nil
        && ![self isKindOfClass:[NSNull class]]
        && (id)self != [NSNull null]
        && [[self trimWhitespace] length]>0) {
        return NO;
    }
    return YES;
}

- (BOOL)isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isEmail {
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [emailTest evaluateWithObject:self];
}

- (NSString *)URLPattern {
    static NSString *urlPattern = @"(?i)\\b((?:[a-z][\\w-]+:(?:/{1,3}|[a-z0-9%])|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:\'\".,<>?«»“”‘’]))";
    return urlPattern;
}

- (BOOL)isURL {
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", [self URLPattern]];
    return [urlTest evaluateWithObject:self];
}

- (NSArray *)URLList {
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:[self URLPattern]
                                                                         options:NSRegularExpressionAnchorsMatchLines|NSRegularExpressionDotMatchesLineSeparators
                                                                           error:nil];
    NSArray *matches = [reg matchesInString:self
                                    options:NSMatchingReportCompletion
                                      range:NSMakeRange(0, self.length)];
    
    NSMutableArray *URLs = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *result in matches) {
        [URLs addObject:[self substringWithRange:result.range]];
    }
    return URLs;
}

//- (BOOL)isIP {
//    NSString *ipRegex = @"((^1([0-9]\\d{0,2}))|(^2([0-5\\d{0,2}])))";
//    NSPredicate *ipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", ipRegex];
//    return [ipTest evaluateWithObject:self];
//}

- (BOOL)isCellPhoneNumber {
    NSString *cellPhoneRegEx = @"^1(3[0-9]|4[0-9]|5[0-9]|8[0-9])\\d{8}$";
    NSPredicate *cellPhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", cellPhoneRegEx];
    return [cellPhoneTest evaluateWithObject:self];
}

- (BOOL)isPhoneNumber {
    NSString *phoneRegEx= @"((^0(10|2[0-9]|\\d{2,3})){0,1}-{0,1}(\\d{6,8}|\\d{6,8})$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegEx];
    return [phoneTest evaluateWithObject:self];
}

- (BOOL)isZipCode {
    NSString *zipCodeRegEx = @"[1-9]\\d{5}$";
    NSPredicate *zipCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", zipCodeRegEx];
    return [zipCodeTest evaluateWithObject:self];
}

- (id)jsonObject:(NSError **)error {
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                           options:NSJSONReadingMutableContainers
                                             error:error];
}

- (NSString *)getDecimalFromHex {
    int sum = 0;
    for (int i = 0; i < self.length; i++) {
        sum *= 16;
        char c = [self characterAtIndex:i] ;
        if (c >= 'A') {
            sum += c - 'A' + 10;
        }else{
            sum += c - '0';
        }
    }
    return [NSString stringWithFormat:@"%d",sum];
}

- (NSString *)getHexFromDecimal {
    int num = [self intValue];
    NSMutableString * result = [[NSMutableString alloc] init];
    while (num > 0) {
        int a = num % 16;
        char c;
        if (a > 9) {
            c = 'A' + (a - 10);
        }else{
            c = '0' + a;
        }
        NSString * reminder = [NSString stringWithFormat:@"%c",c];
        [result insertString:reminder atIndex:0];
        num = num / 16;
    }
    return result;
}

- (NSString *)getDecimalFromBinary {
    int sum = 0;
    for (int i = 0; i < self.length; i++) {
        sum *= 2;
        char c = [self characterAtIndex:i];
        sum += c - '0';
    }
    return [NSString stringWithFormat:@"%d",sum];
}

- (NSString *)getBinaryFromDecimal {
    int num = [self intValue];
    NSMutableString * result = [[NSMutableString alloc] init];
    while (num > 0) {
        NSString * reminder = [NSString stringWithFormat:@"%d",num % 2];
        [result insertString:reminder atIndex:0];
        num = num / 2;
    }
    return result;
}

- (NSComparisonResult)numericCompare:(NSString *)string {
    NSString *leftString = self;
    NSString *rightString = string;
    
    NSScanner *leftScanner = [NSScanner scannerWithString:leftString];
    NSScanner *rightScanner = [NSScanner scannerWithString:rightString];
    
    NSInteger leftNumber, rightNumber;
    
    if ([leftScanner scanInteger:&leftNumber] && [rightScanner scanInteger:&rightNumber]) {
        if (leftNumber < rightNumber) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        
        leftString = [leftString substringFromIndex:[leftScanner scanLocation]];
        rightString = [rightString substringFromIndex:[rightScanner scanLocation]];
    }
    return [leftString caseInsensitiveCompare:rightString];
}

- (NSComparisonResult)floatCompare:(NSString *)string {
    NSString *leftString = self;
    NSString *rightString = string;
    
    NSScanner *leftScanner = [NSScanner scannerWithString:leftString];
    NSScanner *rightScanner = [NSScanner scannerWithString:rightString];
    
    double leftNumber, rightNumber;
    
    if ([leftScanner scanDouble:&leftNumber] && [rightScanner scanDouble:&rightNumber]) {
        if (leftNumber < rightNumber) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        
        leftString = [leftString substringFromIndex:[leftScanner scanLocation]];
        rightString = [rightString substringFromIndex:[rightScanner scanLocation]];
    }
    return [leftString caseInsensitiveCompare:rightString];
}

@end
