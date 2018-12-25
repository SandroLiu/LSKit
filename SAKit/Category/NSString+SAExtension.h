//
//  NSString+LSExtension.h
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SAExtension)

/**
 * 检查字符串是否为空
 */
+ (BOOL)sa_isEmptyOrNull:(NSString *)string;

/**
 * 检查字符串是否为空
 */
- (BOOL)sa_isEmptyOrNull;

/**
 * 检查字符串是否是纯数字
 */
+ (BOOL)sa_checkStringIsOnlyDigital:(NSString *)st;

/**
 * 检查字符串中包含汉字
 */
- (BOOL)sa_checkStringIsContainerChineseCharacter;

/**
 * 过滤特殊字符
 */
- (NSString *)sa_filterSpecialString;

/**
 * 检查是否为正确手机号码
 */
- (BOOL)sa_checkPhoneNumber;

/**
 * 检查邮箱地址格式
 */
- (BOOL)sa_checkEmailAddress;

/**
 * 判断身份证是否合法
 */
- (BOOL)sa_checkIdentityNumber;

/**
 是否包含表情
 
 @return YES为包含
 */
- (BOOL)sa_containEmoji;

/**
 * 从身份证里面获取性别man 或者 woman 不正确的身份证返回nil
 */
- (NSString *)sa_getGenderFromIdentityNumber;

/**
 * 从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 */
- (NSString *)sa_getBirthdayFromIdentityNumber;

/**
 * 计算字符串尺寸
 */
+ (CGSize)sa_sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;

/**
 * md5加密
 */
- (NSString *)sa_md5;

/**
 *  将 data 转成16进制字符串
 *
 *  @return 16进制字符串
 */
+ (NSString *)sa_hexStringFromData:(NSData *)data;

/**
 * 添加中划线
 */
- (NSMutableAttributedString *)sa_addCenterLine;
/**
 * 添加下划线
 */
- (NSMutableAttributedString *)sa_addDownLine;

/**
 提取字符串里的十六进制转成data
 @return 字节值
 */
- (NSData *)sa_hexToData;

/**
 复制到粘贴板
 */
- (void)sa_copyToPasteBoard;
@end

NS_ASSUME_NONNULL_END
