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

- (BOOL)isCellPhoneNumber {
    NSString *cellPhoneRegEx = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
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
    }
    return [leftString caseInsensitiveCompare:rightString];
}

@end

@implementation NSObject (String)

- (BOOL)isString {
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

@end
