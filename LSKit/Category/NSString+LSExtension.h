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

@interface NSString (LSExtension)

/**
 * 检查字符串是否为空
 */
+ (BOOL)ls_isEmptyOrNull:(NSString *)string;

/**
 * 检查字符串是否为空
 */
- (BOOL)ls_isEmptyOrNull;

/**
 * 检查字符串是否是纯数字
 */
+ (BOOL)ls_checkStringIsOnlyDigital:(NSString *)st;

/**
 * 检查字符串中包含汉字
 */
- (BOOL)ls_checkStringIsContainerChineseCharacter;

/**
 * 过滤特殊字符
 */
- (NSString *)ls_filterSpecialString;

/**
 * 检查是否为正确手机号码
 */
- (BOOL)ls_checkPhoneNumber;

/**
 * 检查邮箱地址格式
 */
- (BOOL)ls_checkEmailAddress;

/**
 * 判断身份证是否合法
 */
- (BOOL)ls_checkIdentityNumber;

/**
 是否包含表情
 
 @return YES为包含
 */
- (BOOL)ls_containEmoji;

/**
 * 从身份证里面获取性别man 或者 woman 不正确的身份证返回nil
 */
- (NSString *)ls_getGenderFromIdentityNumber;

/**
 * 从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日
 */
- (NSString *)ls_getBirthdayFromIdentityNumber;

/**
 * 计算字符串尺寸
 */
+ (CGSize)ls_sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size;

/**
 * md5加密
 */
- (NSString *)ls_md5;

/**
 *  将 data 转成16进制字符串
 *
 *  @return 16进制字符串
 */
+ (NSString *)ls_hexStringFromData:(NSData *)data;

/**
 * 添加中划线
 */
- (NSMutableAttributedString *)ls_addCenterLine;
/**
 * 添加下划线
 */
- (NSMutableAttributedString *)ls_addDownLine;

/**
 提取字符串里的十六进制转成data
 @return 字节值
 */
- (NSData *)ls_hexToData;

/**
 复制到粘贴板
 */
- (void)ls_copyToPasteBoard;
@end

NS_ASSUME_NONNULL_END
