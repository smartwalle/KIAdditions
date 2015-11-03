//
//  NSDate+KIDate.h
//  Kitalker
//
//  Created by 杨 烽 on 12-8-30.
//
//

/*
 
 a: AM/PM (上午/下午)
 
 A: 0~86399999 (一天的第A微秒)
 
 c/cc: 1~7 (一周的第一天, 周天为1)
 
 ccc: Sun/Mon/Tue/Wed/Thu/Fri/Sat (星期几简写)
 
 cccc: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday (星期几全拼)
 
 d: 1~31 (月份的第几天, 带0)
 
 D: 1~366 (年份的第几天,带0)
 
 e: 1~7 (一周的第几天, 带0)
 
 E~EEE: Sun/Mon/Tue/Wed/Thu/Fri/Sat (星期几简写)
 
 EEEE: Sunday/Monday/Tuesday/Wednesday/Thursday/Friday/Saturday (星期几全拼)
 
 F: 1~5 (每月的第几周, 一周的第一天为周一)
 
 g: Julian Day Number (number of days since 4713 BC January 1) 未知
 
 G~GGG: BC/AD (Era Designator Abbreviated) 未知
 
 GGGG: Before Christ/Anno Domini 未知
 
 h: 1~12 (0 padded Hour (12hr)) 带0的时, 12小时制
 
 H: 0~23 (0 padded Hour (24hr))  带0的时, 24小时制
 
 k: 1~24 (0 padded Hour (24hr) 带0的时, 24小时制
 
 K: 0~11 (0 padded Hour (12hr)) 带0的时, 12小时制
 
 L/LL: 1~12 (0 padded Month)  第几月
 
 LLL: Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec 月份简写
 
 LLLL: January/February/March/April/May/June/July/August/September/October/November/December 月份全称
 
 m: 0~59 (0 padded Minute) 分钟
 
 M/MM: 1~12 (0 padded Month) 第几月
 
 MMM: Jan/Feb/Mar/Apr/May/Jun/Jul/Aug/Sep/Oct/Nov/Dec
 
 MMMM: January/February/March/April/May/June/July/August/September/October/November/December
 
 q/qq: 1~4 (0 padded Quarter) 第几季度
 
 qqq: Q1/Q2/Q3/Q4 季度简写
 
 qqqq: 1st quarter/2nd quarter/3rd quarter/4th quarter 季度全拼
 
 Q/QQ: 1~4 (0 padded Quarter) 同小写
 
 QQQ: Q1/Q2/Q3/Q4 同小写
 
 QQQQ: 1st quarter/2nd quarter/3rd quarter/4th quarter 同小写
 
 s: 0~59 (0 padded Second) 秒数
 
 S: (rounded Sub-Second) 未知
 
 u: (0 padded Year) 未知
 
 v~vvv: (General GMT Timezone Abbreviation) 常规GMT时区的编写
 
 vvvv: (General GMT Timezone Name) 常规GMT时区的名称
 
 w: 1~53 (0 padded Week of Year, 1st day of week = Sunday, NB: 1st week of year starts from the last Sunday of last year) 一年的第几周, 一周的开始为周日,第一周从去年的最后一个周日起算
 
 W: 1~5 (0 padded Week of Month, 1st day of week = Sunday) 一个月的第几周
 
 y/yyyy: (Full Year) 完整的年份
 
 yy/yyy: (2 Digits Year)  2个数字的年份
 
 Y/YYYY: (Full Year, starting from the Sunday of the 1st week of year) 这个年份未知干嘛用的
 
 YY/YYY: (2 Digits Year, starting from the Sunday of the 1st week of year) 这个年份未知干嘛用的
 
 z~zzz: (Specific GMT Timezone Abbreviation) 指定GMT时区的编写
 
 zzzz: (Specific GMT Timezone Name) Z: +0000 (RFC 822 Timezone) 指定GMT时区的名称
 
 */

#import <Foundation/Foundation.h>

#define kDateFormatter01 @"yyyy-MM-dd HH:mm:ss:FFF"
#define KDateFormatter02 @"yyyy-MM-dd HH:mm:ss"
#define KDateFormatter03 @"yyyy-MM-dd HH:mm"
#define KDateFormatter04 @"yyyy-MM-dd HH"
#define KDateFormatter05 @"yyyy-MM-dd"
#define KDateFormatter06 @"yyyy-MM"
#define KDateFormatter07 @"MM-dd"
#define KDateFormatter08 @"HH:mm"

@interface NSDateFormatter (KIAdditions)

+ (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)format;

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

- (NSString *)weekday:(NSDate *)date;

- (NSString *)day:(NSDate *)date;

- (NSString *)month:(NSDate *)date;

- (NSString *)year:(NSDate *)date;

- (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)format;

- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

@end


@interface NSDate (KIAdditions)

+ (NSDate *)now;

+ (NSDate *)dateWithTimeInterval:(NSTimeInterval)timeInterval;

/*根据年、月、日、时、分、秒来创建一个日期*/
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSUInteger)second;

+ (NSDate *)beginningDateOfYear:(NSInteger)year;

+ (NSDate *)endingDateOfYear:(NSInteger)year;


+ (NSDate *)beginningDateOfMonth:(NSInteger)month year:(NSInteger)year;

+ (NSDate *)endingDateOfMonth:(NSInteger)month year:(NSInteger)year;


+ (NSDate *)beginningDateOfDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;

+ (NSDate *)endingDateOfDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;


/*昨天, 精确到天*/
+ (NSDate *)yesterday;

/*今天, 精确到天*/
+ (NSDate *)today;

/*明天, 精确到天*/
+ (NSDate *)tomorrow;

/*日期*/
- (NSString *)date;

/*星期几*/
- (NSInteger)weekday;

/*秒*/
- (NSUInteger)second;

/*分*/
- (NSUInteger)minute;

/*时*/
- (NSInteger)hour;

/*几号*/
- (NSInteger)day;

/*月份*/
- (NSInteger)month;

/*年份*/
- (NSInteger)year;

/*获取当前月有多少天*/
- (NSUInteger)numberOfDaysInMonth;

/*获取当前月有多少周*/
- (NSUInteger)weeksOfMonth;

/*获取前一天（昨天）*/
- (NSDate *)previousDate;

/*获取下一天（明天）*/
- (NSDate *)nextDate;

/*获取当前周的第一天*/
- (NSDate *)firstDateOfWeek;

/*获取当前周的最后一天*/
- (NSDate *)lastDateOfWeek;

/*获取上周的第一天*/
- (NSDate *)firstDateOfLastWeek;

/*获取上周的最后一天*/
- (NSDate *)lastDateOfLastWeek;

/*获取下周的第一天*/
- (NSDate *)firstDateOfNextWeek;

/*获取下周的最后一天*/
- (NSDate *)lastDateOfNextWeek;

/*获取当前月的第一天*/
- (NSDate *)firstDateOfMonth;

/*获取当前月的最后一天*/
- (NSDate *)lastDateOfMonth;

/*获取当前月的第一天是星期几*/
- (NSString *)weekdayOfFirstDateInMonth;

/*获取上月的第一天*/
- (NSDate *)firstDateOfLastMonth;

/*获取上月的最后一天*/
- (NSDate *)lastDateOfLastMonth;

/*获取下月的第一天*/
- (NSDate *)firstDateOfNextMonth;

/*获取下月的最后一天*/
- (NSDate *)lastDateOfNextMonth;

/*获取当前季度的第一天*/
- (NSDate *)firstDateOfQuarter;

/*获取当前季度的最后一天*/
- (NSDate *)lastDateOfQuarter;


/*获取当前年的第一天*/
- (NSDate *)firstDateOfYear;

/*获取当前年的最后一天*/
- (NSDate *)lastDateOfYear;

- (NSDate *)firstDateOfLastYear;

- (NSDate *)lastDateOfLastYear;

- (NSDate *)firstDateOfNextYear;

- (NSDate *)lastDateOfNextYear;

/*是否在某个日期之前*/
- (BOOL)isBefore:(NSDate *)date;

/*是否在某个日期之后*/
- (BOOL)isAfter:(NSDate *)date;


- (NSDate *)beginningDateOfYear;

- (NSDate *)endingDateOfYear;


- (NSDate *)beginningDateOfQuarter;

- (NSDate *)endingDateOfQuarter;


- (NSDate *)beginningDateOfMonth;

- (NSDate *)endingDateOfMonth;


- (NSDate *)beginningDateOfWeek;

- (NSDate *)endingDateOfWeek;


- (NSDate *)beginningDateOfToday;

- (NSDate *)endingDateOfToday;



/*获取完整的日期字符串*/
- (NSString *)fullDateString;

/*将日期以格式化的形式输出*/
- (NSString *)stringWithFormat:(NSString *)format;

/*短日期，比如：1个月前, 大于一年为年月日*/
- (NSString *)shortDateString;

@end
