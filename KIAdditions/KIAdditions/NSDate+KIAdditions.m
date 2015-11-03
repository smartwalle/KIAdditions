//
//  NSDate+KIDate.m
//  Kitalker
//
//  Created by 杨 烽 on 12-8-30.
//
//

#import "NSDate+KIAdditions.h"

@implementation NSDateFormatter (KIAdditions)

+ (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    return [dateFormatter dateFromString:string withFormat:format];
}

- (NSString *)weekday:(NSDate *)date {
    [self setDateFormat:@"c"];
    return [self stringFromDate:date];
}

- (NSString *)day:(NSDate *)date {
    [self setDateFormat:@"d"];
    return [self stringFromDate:date];
}

- (NSString *)month:(NSDate *)date {
    [self setDateFormat:@"M"];
    return [self stringFromDate:date];
}

- (NSString *)year:(NSDate *)date {
    [self setDateFormat:@"y"];
    return [self stringFromDate:date];
}

- (NSString *)dateStringFromDate:(NSDate *)date withFormat:(NSString *)format {
    [self setDateFormat:format];
    return [self stringFromDate:date];
}

- (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    [self setDateFormat:format];
    return [self dateFromString:string];
}

@end

@implementation NSDate (KIAdditions)

+ (NSDate *)now {
    NSDate *date = [NSDate date];
    return date;
}

+ (NSDate *)dateWithTimeInterval:(NSTimeInterval)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
//    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
//    NSInteger seconds = [timeZone secondsFromGMTForDate:date];
//    date = [date dateByAddingTimeInterval:seconds];
    return date;
}

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSUInteger)second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:year];
    [dateComponents setMonth:month];
    [dateComponents setDay:day];
    [dateComponents setHour:hour];
    [dateComponents setMinute:minute];
    [dateComponents setSecond:second];
    
    NSDate *date = [calendar dateFromComponents:dateComponents];
    
    return date;
}

+ (NSDate *)beginningDateOfYear:(NSInteger)year {
    return [NSDate dateWithYear:year month:1 day:1 hour:00 minute:00 second:00];
}

+ (NSDate *)endingDateOfYear:(NSInteger)year {
    return [NSDate dateWithYear:year month:12 day:31 hour:23 minute:59 second:59];
}

+ (NSDate *)beginningDateOfMonth:(NSInteger)month year:(NSInteger)year {
    return [NSDate dateWithYear:year month:month day:1 hour:00 minute:00 second:00];
}

+ (NSDate *)endingDateOfMonth:(NSInteger)month year:(NSInteger)year {
    NSInteger day = [NSDate numberOfDaysInMonth:month andYear:year];
    return [NSDate dateWithYear:year month:month day:day hour:23 minute:59 second:59];
}

+ (NSDate *)beginningDateOfDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year {
    return [NSDate dateWithYear:year month:month day:day hour:00 minute:00 second:00];
}

+ (NSDate *)endingDateOfDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year {
    return [NSDate dateWithYear:year month:month day:day hour:23 minute:59 second:59];
}


+ (NSUInteger)numberOfDaysInMonth:(NSUInteger)month andYear:(NSUInteger)year {
    NSUInteger number = 30;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12: {
            number = 31;
        }
            break;
        case 2: {
            if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
                number = 29;
            } else {
                number = 28;
            }
        }
            break;
        default:
            number = 30;
            break;
    }
    return number;
}


+ (NSDate *)yesterday {
    return [[NSDate today] previousDate];
}

+ (NSDate *)today {
    NSDate *date = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL ok = [calendar rangeOfUnit:NSDayCalendarUnit
                                 startDate:&date
                                  interval:NULL
                                   forDate:[NSDate date]];
    if (ok == NO) {
        date = nil;
    }
    return date;
}

+ (NSDate *)tomorrow {
    return [[NSDate today] nextDate];
}

- (NSString *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    return [dateFormatter day:self];
}

- (NSInteger)weekday {
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitWeekday fromDate:self];
    return components.weekday;
}

- (NSUInteger)second {
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitSecond fromDate:self];
    return components.second;
}

- (NSUInteger)minute {
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitMinute fromDate:self];
    return components.minute;
}

- (NSInteger)hour {
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitHour fromDate:self];
    return components.hour;
}

- (NSInteger)day {
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitDay fromDate:self];
    return components.day;
}

- (NSInteger)month {
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)year {
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitYear fromDate:self];
    return components.year;
}

- (NSCalendar *)calendar {
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    [calendar setTimeZone:[NSTimeZone systemTimeZone]];
    return calendar;
}

- (NSUInteger)numberOfDaysInMonth {
    return [[self calendar] rangeOfUnit:NSDayCalendarUnit
                                 inUnit:NSMonthCalendarUnit
                                forDate:self].length;
}

- (NSUInteger)weeksOfMonth {
    return [[self calendar] rangeOfUnit:NSWeekCalendarUnit
                                 inUnit:NSMonthCalendarUnit
                                forDate:self].length;
}

- (NSDate *)previousDate {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setDay:-1];
    return [[self calendar] dateByAddingComponents:dateComp
                                            toDate:self
                                           options:0];
}

- (NSDate *)nextDate {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setDay:1];
    return [[self calendar] dateByAddingComponents:dateComp
                                            toDate:self
                                           options:0];
}

- (NSDate *)firstDateOfWeek {
    NSDate *date = nil;
    BOOL ok = [[self calendar] rangeOfUnit:NSWeekCalendarUnit
                                              startDate:&date
                                               interval:NULL
                                                forDate:self];
    if (ok == NO) {
        date = nil;
    }
    return date;
}

- (NSDate *)lastDateOfWeek {
    return [[self firstDateOfNextWeek] previousDate];
}

- (NSDate *)firstDateOfLastWeek {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setWeek:-1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] firstDateOfWeek];
}

- (NSDate *)lastDateOfLastWeek {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setWeek:-1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] lastDateOfWeek];
}

- (NSDate *)firstDateOfNextWeek {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setWeek:1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] firstDateOfWeek];
}

- (NSDate *)lastDateOfNextWeek {
    return [[self firstDateOfNextWeek] lastDateOfWeek];
}

- (NSDate *)firstDateOfMonth {
    NSDate *date = nil;
    BOOL ok = [[self calendar] rangeOfUnit:NSMonthCalendarUnit
                                 startDate:&date
                                  interval:NULL
                                   forDate:self];
    if (ok == NO) {
        date = nil;
    }
    return date;
}

- (NSDate *)lastDateOfMonth {
    NSDate *date = nil;
    date = [[self firstDateOfNextMonth] previousDate];
    return date;
}

- (NSString *)weekdayOfFirstDateInMonth {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    return [dateFormatter weekday:[self firstDateOfMonth]];
}

- (NSDate *)firstDateOfLastMonth {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:-1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] firstDateOfMonth];
}

- (NSDate *)lastDateOfLastMonth {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:-1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] lastDateOfMonth];
}

- (NSDate *)firstDateOfNextMonth {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] firstDateOfMonth];
}

- (NSDate *)lastDateOfNextMonth {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] lastDateOfMonth];
}

- (NSDate *)firstDateOfQuarter {
    NSDate *date = nil;
    BOOL ok = [[self calendar] rangeOfUnit:NSQuarterCalendarUnit
                                 startDate:&date
                                  interval:NULL
                                   forDate:self];
    if (ok == NO) {
        date = nil;
    }
    return date;
}

- (NSDate *)lastDateOfQuarter {
    NSDate *firstDateOfQuarter = [self firstDateOfQuarter];
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:2];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:firstDateOfQuarter
                                            options:0] lastDateOfMonth];
}

- (NSDate *)firstDateOfYear {
    NSDate *date = nil;
    BOOL ok = [[self calendar] rangeOfUnit:NSYearCalendarUnit
                                 startDate:&date
                                  interval:NULL
                                   forDate:self];
    if (ok == NO) {
        date = nil;
    }
    return date;
}

- (NSDate *)lastDateOfYear {
    NSDate *firstDateOfYear = [self firstDateOfYear];
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setMonth:11];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:firstDateOfYear
                                            options:0] lastDateOfMonth];
}



- (NSDate *)firstDateOfLastYear {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setYear:-1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] firstDateOfYear];
}

- (NSDate *)lastDateOfLastYear {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setYear:-1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] lastDateOfYear];
}

- (NSDate *)firstDateOfNextYear {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setYear:1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] firstDateOfYear];
}

- (NSDate *)lastDateOfNextYear {
    NSDateComponents *dateComp = [[NSDateComponents alloc] init];
    [dateComp setYear:1];
    return [[[self calendar] dateByAddingComponents:dateComp
                                             toDate:self
                                            options:0] lastDateOfYear];
}



- (BOOL)isBefore:(NSDate *)date {
    NSTimeInterval selfTimeInterval = [self timeIntervalSince1970];
    NSTimeInterval dateTimeInterval = [date timeIntervalSince1970];
    if (selfTimeInterval < dateTimeInterval) {
        return YES;
    }
    return NO;
}

- (BOOL)isAfter:(NSDate *)date {
    NSTimeInterval selfTimeInterval = [self timeIntervalSince1970];
    NSTimeInterval dateTimeInterval = [date timeIntervalSince1970];
    if (selfTimeInterval > dateTimeInterval) {
        return YES;
    }
    return NO;
}



- (NSDate *)beginningDateOfYear {
    NSUInteger year = [self year];
    return [NSDate beginningDateOfYear:year];
}

- (NSDate *)endingDateOfYear {
    NSUInteger year = [self year];
    return [NSDate endingDateOfYear:year];
}

- (NSDate *)beginningDateOfQuarter {
    NSDate *date = [self firstDateOfQuarter];
    return [NSDate beginningDateOfDay:[date day] month:[date month] year:[date year]];
}

- (NSDate *)endingDateOfQuarter {
    NSDate *date = [self lastDateOfQuarter];
    return [NSDate endingDateOfDay:[date day] month:[date month] year:[date year]];
}

- (NSDate *)beginningDateOfMonth {
    NSInteger year = [self year];
    NSInteger month = [self month];
    return [NSDate beginningDateOfMonth:month year:year];
}

- (NSDate *)endingDateOfMonth {
    NSInteger year = [self year];
    NSInteger month = [self month];
    return [NSDate endingDateOfMonth:month year:year];
}

- (NSDate *)beginningDateOfWeek {
    NSDate *date = [self firstDateOfWeek];
    return [NSDate beginningDateOfDay:[date day] month:[date month] year:[date year]];
}

- (NSDate *)endingDateOfWeek {
    NSDate *date = [self lastDateOfWeek];
    return [NSDate endingDateOfDay:[date day] month:[date month] year:[date year]];
}

- (NSDate *)beginningDateOfToday {
    return [NSDate beginningDateOfDay:[self day] month:[self month] year:[self year]];
}

- (NSDate *)endingDateOfToday {
    return [NSDate endingDateOfDay:[self day] month:[self month] year:[self year]];
}


- (NSString *)fullDateString {
    return [self stringWithFormat:kDateFormatter01];
}

- (NSString *)stringWithFormat:(NSString *)format {
    return [NSDateFormatter dateStringFromDate:self withFormat:format];
}

- (NSString *)shortDateString {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSSecondCalendarUnit
                                    |NSHourCalendarUnit
                                    |NSMinuteCalendarUnit
                                    |NSDayCalendarUnit
                                    |NSMonthCalendarUnit
                                    |NSYearCalendarUnit
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    if (components.month > 0) {
        return [NSDateFormatter dateStringFromDate:self withFormat:NSLocalizedString(@"yyyy年MM月dd日", nil)];
    } else if(components.day > 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"%d天前", nil), components.day];
    } else if(components.hour > 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"%d小时前", nil), components.hour];
    } else if(components.minute > 0) {
        return [NSString stringWithFormat:NSLocalizedString(@"%d分钟前", nil), components.minute];
    } else if(components.second >= 0) {
        if (components.second < 30) {
            return NSLocalizedString(@"刚刚", nil);
        } else {
            return [NSString stringWithFormat:NSLocalizedString(@"%d秒前", nil), components.second];
        }
    }
    return nil;
}

@end
