//
//  NSDate+LSExtension.h
//  LSUtilsDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LSExtension)

/**
 *  获取当前日期
 *
 *  @return 格式为：yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)ls_getCurrentDate;

/**
 *  获取当前日期
 *
 *  @return 格式为：yyyy-MM-dd
 */
+ (NSString *)ls_getCurrentDateNoTime;

/**
 * 根据时间戳获取星期几
 */
+ (NSString *)ls_getWeekDay:(NSTimeInterval)time;

/**
 *  判断 date 与当前日期的间隔
 *
 *  @param date 需要比较的日期
 *
 *  @return 今天、昨天、xxxx-xx-xx
 */
+ (NSString *)ls_getDateCompareToday:(NSDate *)date;

/**
 是否在今天或今天之前
 */
- (BOOL)ls_isBeforToday;

/**
 上一天
 
 @return 上一天
 */
- (NSDate *)ls_lastDay;

/**
 第二天
 
 @return 第二天
 */
- (NSDate *)ls_nextDay;

/**
 上一月
 */
- (NSDate *)ls_lastMonth;

/**
 下一月
 */
- (NSDate *)ls_nextMonth;

/**
 * 是否是今年
 */
- (BOOL)ls_isThisYear;

/**
 * 是否为这月
 */
- (BOOL)ls_isThisMonth;

/**
 * 是否为今天
 */
- (BOOL)ls_isToday;

/**
 * 是否为昨天
 */
- (BOOL)ls_isYesterday;

/**
 * 是否为明天
 */
- (BOOL)ls_isTomorrow;

/**
 是否在date日期之前，只看日期，时分秒不算
 
 @param date 另一个日期
 @return yes是
 */
- (BOOL)ls_isBeforDayThenOtherDate:(NSDate *)date;

/**
 是否在另一个日期之后，只看日期，时分秒不算
 
 @param date 另一个日期
 @return yes or no
 */
- (BOOL)ls_isAfterDayThenOtherDate:(NSDate *)date;

/**
 是否和另一个日期是同一天，时分秒不看
 
 @param date 另一个日期
 @return yes or no
 */
- (BOOL)ls_isEqualDayThenOtherDate:(NSDate *)date;

/**
 是否和另一个日期是同一天或在另一个日期之前，时分秒不看
 
 @param date 另一个日期
 @return yes or no
 */
- (BOOL)ls_isBeforeOrEqualDayThenOtherDate:(NSDate *)date;

/**
 是否和另一个日期是同一天或在另一个日期之后，时分秒不看
 
 @param date 另一个日期
 @return yes or no
 */
- (BOOL)ls_isAfterOrEqualDayThenOtherDate:(NSDate *)date;

/**
 根据格式转换成时间字符串
 
 @param formatStr 格式
 @return 时间字符串
 */
- (NSString *)ls_formatDateAndTimeWithFormatStr:(NSString *)formatStr;

/**
 根据固定格式将字符串转换成date
 
 @param dateStr 时间字符串
 @param formatStr 格式
 @return date
 */
+ (NSDate *)ls_formatDateWithString:(NSString *)dateStr formatString:(NSString *)formatStr;
/**
 *获取当前日期时间戳
 */
+ (NSTimeInterval)ls_getCurrentTimestamp;

/**
 * 获取指定日期时间戳
 */
+ (NSTimeInterval)ls_getTimestampWithDate:(NSDate *)date;

/**
 * 根据时间戳转换为XXXX-XX-XX
 */
+ (NSString*)ls_format:(NSTimeInterval)time;

/**
 * 根据时间戳转化为XX:XX:XX
 */
+ (NSString*)ls_formatTime:(NSTimeInterval) time;

/**
 * 转化为XXXX-XX-XX XX:XX:XX
 */
+ (NSString *)ls_formatDateAndTime:(NSTimeInterval)time;

/**
 * 根据 format 转化时间戳
 */
+ (NSString *)ls_formatDateAndTime:(NSTimeInterval)time withFormat:(NSString *)format;

/**
 将 xxxx-xx-xx xx:xx:xx转换为时间戳
 
 @return 时间戳
 */
+ (NSTimeInterval)ls_formatDateAndTimeToIntervalWithDateStr:(NSString *)dateStr;

/**
 将 xxxx-xx-xx xx:xx:xx转换为xx-xx
 
 @param time 时间
 @return 月日
 */
+ (NSString *)ls_formatMonthAndDay:(NSString *)time;

/**
 将 xxxx-xx-xx xx:xx:xx转换为xx:xx
 
 @return 小时和分钟
 */
+ (NSString *)ls_formatHourAndMinute:(NSString *)time;

/**
 根据日期获取日历组件
 
 @param date 日期
 @return 日历组件
 */
+ (NSDateComponents *)ls_getComponentsWithDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
