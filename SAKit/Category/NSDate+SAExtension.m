//
//  NSDate+LSExtension.m
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "NSDate+SAExtension.h"

@implementation NSDate (SAExtension)

/** 获取当前日期*/
+ (NSString *)sa_getCurrentDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/** 获取当前日期*/
+ (NSString *)sa_getCurrentDateNoTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/** 获取星期几*/
+ (NSString *)sa_getWeekDay:(NSTimeInterval)time
{
    //创建一个星期数组
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    //将时间戳转换成日期
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

/** 今天、昨天、xxxx-xx-xx*/
+ (NSString *)sa_getDateCompareToday:(NSDate *)date {
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *yearsterDay =  [[NSDate alloc] initWithTimeIntervalSinceNow:-secondsPerDay];
    NSDateComponents* cmp3 = [calendar components:unitFlags fromDate:yearsterDay];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 year] == [cmp2 year]&&[cmp1 month] == [cmp2 month]&&[cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天";
    } else if (cmp1.year == cmp3.year && cmp1.month == cmp3.month && cmp1.day == cmp3.day) { // 今年
        formatter.dateFormat = @"昨天";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd";
    }
    NSString *time = [formatter stringFromDate:date];
    return time;
}

/// 是否在今天或今天之前
- (BOOL)sa_isBeforToday {
    NSDate *todayDate = [NSDate date];
    NSDateComponents *todayComponents = [NSDate sa_getComponentsWithDate:todayDate];
    NSDateComponents *selfComponents = [NSDate sa_getComponentsWithDate:self];
    if (todayComponents.year > selfComponents.year) {
        return YES;
    } else if (todayComponents.year < selfComponents.year) {
        return NO;
    } else {
        if (todayComponents.month > selfComponents.month) {
            return YES;
        } else if (todayComponents.month < selfComponents.month) {
            return NO;
        } else {
            if (todayComponents.day >= selfComponents.day) {
                return YES;
            } else {
                return NO;
            }
        }
    }
}

/** 是否为今年*/
- (BOOL)sa_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获得年
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

/** 是否为这月*/
- (BOOL)sa_isThisMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获得年
    NSInteger nowMonth = [calendar component:NSCalendarUnitMonth fromDate:[NSDate date]];
    NSInteger selfMonth = [calendar component:NSCalendarUnitMonth fromDate:self];
    
    return nowMonth == selfMonth;
}

/** 是否为今天*/
- (BOOL)sa_isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year
    && nowCmps.month == selfCmps.month
    && nowCmps.day == selfCmps.day;
}

/** 是否为昨天*/
- (BOOL)sa_isYesterday
{
    // now : 2015-02-01 00:01:05 -->  2015-02-01
    // self : 2015-01-31 23:59:10 --> 2015-01-31
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 1;
}

/** 是否为明天*/
- (BOOL)sa_isTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == -1;
}

- (NSString *)sa_formatDateAndTimeWithFormatStr:(NSString *)formatStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatStr];
    NSString *dateAndTime = [formatter stringFromDate:self];
    return dateAndTime;
}

- (NSDate *)sa_lastDay {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)sa_nextDay {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)sa_lastMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)sa_nextMonth {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (BOOL)sa_isBeforDayThenOtherDate:(NSDate *)date {
    NSDateComponents *selfComponents = [NSDate sa_getComponentsWithDate:self];
    NSDateComponents *dateComponents = [NSDate sa_getComponentsWithDate:date];
    if (selfComponents.year < dateComponents.year) {
        return YES;
    } else if (selfComponents.year == dateComponents.year) {
        if (selfComponents.month < dateComponents.month) {
            return YES;
        } else if (selfComponents.month == dateComponents.month) {
            if (selfComponents.day < dateComponents.day) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)sa_isAfterDayThenOtherDate:(NSDate *)date {
    NSDateComponents *selfComponents = [NSDate sa_getComponentsWithDate:self];
    NSDateComponents *dateComponents = [NSDate sa_getComponentsWithDate:date];
    if (selfComponents.year > dateComponents.year) {
        return YES;
    } else if (selfComponents.year == dateComponents.year) {
        if (selfComponents.month > dateComponents.month) {
            return YES;
        } else if (selfComponents.month == dateComponents.month) {
            if (selfComponents.day > dateComponents.day) {
                return YES;
            }
        }
    }
    return NO;
}

- (BOOL)sa_isEqualDayThenOtherDate:(NSDate *)date {
    NSDateComponents *selfComponents = [NSDate sa_getComponentsWithDate:self];
    NSDateComponents *dateComponents = [NSDate sa_getComponentsWithDate:date];
    if (selfComponents.year == dateComponents.year && selfComponents.month == dateComponents.month && selfComponents.day == dateComponents.day) {
        return YES;
    }
    return NO;
}

- (BOOL)sa_isBeforeOrEqualDayThenOtherDate:(NSDate *)date {
    if ([self sa_isBeforDayThenOtherDate:date] || [self sa_isEqualDayThenOtherDate:date]) {
        return YES;
    }
    return NO;
}

- (BOOL)sa_isAfterOrEqualDayThenOtherDate:(NSDate *)date {
    if ([self sa_isAfterDayThenOtherDate:date] || [self sa_isEqualDayThenOtherDate:date]) {
        return YES;
    }
    return NO;
}
#pragma mark- 时间戳转换

/** 获取当前日期时间戳*/
+ (NSTimeInterval)sa_getCurrentTimestamp
{
    return [self sa_getTimestampWithDate:[NSDate date]];
}

/** 获取指定日期时间戳*/
+ (NSTimeInterval)sa_getTimestampWithDate:(NSDate *)date
{
    NSTimeInterval timestamp =  [date timeIntervalSince1970];
    return timestamp;
}

/** 转换为XXXX年XX月XX日*/
+ (NSString*)sa_format:(NSTimeInterval) time
{
    return [self sa_formatDateAndTime:time withFormat:@"yyyy-MM-dd"];
}

/** 转化为XX时XX分XX秒*/
+ (NSString*)sa_formatTime:(NSTimeInterval) time
{
    return [self sa_formatDateAndTime:time withFormat:@"HH:mm:ss"];
}

/** 转化为XXXX年XX月XX日XX时XX分XX秒*/
+ (NSString *)sa_formatDateAndTime:(NSTimeInterval)time
{
    return [self sa_formatDateAndTime:time withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

/** 根据 format 转化时间戳*/
+ (NSString *)sa_formatDateAndTime:(NSTimeInterval)time withFormat:(NSString *)format
{
    if (time < 0) {
        return @"";
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [formatter stringFromDate:date];
}

+ (NSTimeInterval)sa_formatDateAndTimeToInterval:(NSString *)dateStr withFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate *date = [formatter dateFromString:dateStr];
    return date.timeIntervalSince1970;
}

+ (NSTimeInterval)sa_formatDateAndTimeToIntervalWithDateStr:(NSString *)dateStr {
    return [self sa_formatDateAndTimeToInterval:dateStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)sa_formatMonthAndDay:(NSString *)time {
    NSTimeInterval timeInterval = [self sa_formatDateAndTimeToIntervalWithDateStr:time];
    return [self sa_formatDateAndTime:timeInterval withFormat:@"MM-dd"];
}

+ (NSString *)sa_formatHourAndMinute:(NSString *)time {
    NSTimeInterval timeInterval = [self sa_formatDateAndTimeToIntervalWithDateStr:time];
    return [self sa_formatDateAndTime:timeInterval withFormat:@"HH:mm"];
}

+ (NSDate *)sa_formatDateWithString:(NSString *)dateStr formatString:(NSString *)formatStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatStr];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}

+ (NSDateComponents *)sa_getComponentsWithDate:(NSDate *)date {
    NSCalendar * calendar = [NSCalendar currentCalendar];//当前用户的calendar
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth| NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond   fromDate:date];
    return components;
}
@end
