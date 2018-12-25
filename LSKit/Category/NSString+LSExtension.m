//
//  NSString+LSExtension.m
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "NSString+LSExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (LSExtension)

/** 判断字符串是否为空*/
+ (BOOL)ls_isEmptyOrNull:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

- (BOOL)ls_isEmptyOrNull {
    return [NSString ls_isEmptyOrNull:self];
}

/** 检查字符串是否是纯数字*/
+ (BOOL)ls_checkStringIsOnlyDigital:(NSString *)str
{
    if ([NSString ls_isEmptyOrNull:str]) {
        return NO;
    }
    NSString *string = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length >0)
    {
        return NO;
    }else return YES;
}

/** 判断字符串中包含汉字*/
- (BOOL)ls_checkStringIsContainerChineseCharacter
{
    for (int i = 0; i < self.length; i++)
    {
        int a = [self characterAtIndex:i];
        if (a >= 0x4e00 && a <= 0x9fff) {
            return YES;
        }
    }
    return NO;
}

/** 过滤特殊字符串*/
- (NSString *)ls_filterSpecialString
{
    NSCharacterSet *dontWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+,.;':|/@!? "];
    //stringByTrimmingCharactersInSet只能去掉首尾的特殊字符串
    return [[[self componentsSeparatedByCharactersInSet:dontWant] componentsJoinedByString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

#pragma mark- 字符串校验

/** 检查是否为正确手机号码*/
- (BOOL)ls_checkPhoneNumber {
    if (self.length != 11)
    {
        return NO;
    }
    
    NSString *mobileNo = @"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNo];
    if ([regexMobile evaluateWithObject:self] == YES) {
        return YES;
    } else {
        return NO;
    }
}

/** 检查邮箱地址格式*/
- (BOOL)ls_checkEmailAddress
{
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    //先把NSString转换为小写
    NSString *lowerString       = self.lowercaseString;
    
    return [regExPredicate evaluateWithObject:lowerString] ;
}

/** 判断身份证是否合法*/
- (BOOL)ls_checkIdentityNumber
{
    {
        //必须满足以下规则
        //1. 长度必须是18位或者15位，前17位必须是数字，第十八位可以是数字或X
        //2. 前两位必须是以下情形中的一种：11,12,13,14,15,21,22,23,31,32,33,34,35,36,37,41,42,43,44,45,46,50,51,52,53,54,61,62,63,64,65,71,81,82,91
        //3. 第7到第14位出生年月日。第7到第10位为出生年份；11到12位表示月份，范围为01-12；13到14位为合法的日期
        //4. 第17位表示性别，双数表示女，单数表示男
        //5. 第18位为前17位的校验位
        //算法如下：
        //（1）校验和 = (n1 + n11) * 7 + (n2 + n12) * 9 + (n3 + n13) * 10 + (n4 + n14) * 5 + (n5 + n15) * 8 + (n6 + n16) * 4 + (n7 + n17) * 2 + n8 + n9 * 6 + n10 * 3，其中n数值，表示第几位的数字
        //（2）余数 ＝ 校验和 % 11
        //（3）如果余数为0，校验位应为1，余数为1到10校验位应为字符串“0X98765432”(不包括分号)的第余数位的值（比如余数等于3，校验位应为9）
        //6. 出生年份的前两位必须是19或20
        NSString *number = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        number = number.ls_filterSpecialString;
        // 1.判断位数
        if (number.length != 15 && number.length != 18) {
            return NO;
        }
        // 2.将15位身份证转为18位
        NSMutableString *mString = [NSMutableString stringWithString:number];
        if (number.length == 15) {
            //出生日期加上年的开头
            [mString insertString:@"19" atIndex:6];
            //最后一位加上校验码
            [mString insertString:[mString ls_getLastIdentifyNumberForIdentifyNumber] atIndex:[mString length]];
            number = mString;
        }
        // 3.开始判断
        NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
        NSString *leapMmdd = @"0229";
        NSString *year = @"(19|20)[0-9]{2}";
        NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
        NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
        NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
        NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
        //区域
        NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
        NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
        NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        
        if (![regexTest evaluateWithObject:number]) {
            return NO;
        }
        // 4.验证校验码
        return [[number ls_getLastIdentifyNumberForIdentifyNumber] isEqualToString:[number substringWithRange:NSMakeRange(17, 1)]];
    }
}

/// 判断是否包含表情
- (BOOL)ls_containEmoji {
    NSUInteger len = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    if (len < 3) {// 大于2个字符需要验证Emoji(有些Emoji仅三个字符)
        return NO;
    }// 仅考虑字节长度为3的字符,大于此范围的全部做Emoji处理
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];Byte *bts = (Byte *)[data bytes];
    Byte bt;
    short v;
    for (NSUInteger i = 0; i < len; i++) {
        bt = bts[i];
        
        if ((bt | 0x7F) == 0x7F) {// 0xxxxxxxASIIC编码
            continue;
        }
        if ((bt | 0x1F) == 0xDF) {// 110xxxxx两个字节的字符
            i += 1;
            continue;
        }
        if ((bt | 0x0F) == 0xEF) {// 1110xxxx三个字节的字符(重点过滤项目)
            // 计算Unicode下标
            v = bt & 0x0F;
            v = v << 6;
            v |= bts[i + 1] & 0x3F;
            v = v << 6;
            v |= bts[i + 2] & 0x3F;
            
            // NSLog(@"%02X%02X", (Byte)(v >> 8), (Byte)(v & 0xFF));
            if ([self ls_emojiInSoftBankUnicode:v] || [self ls_emojiInUnicode:v]) {
                return YES;
            }
            
            i += 2;
            continue;
        }
        if ((bt | 0x3F) == 0xBF) {// 10xxxxxx10开头,为数据字节,直接过滤
            continue;
        }
        return YES; // 不是以上情况的字符全部超过三个字节,做Emoji处理
    }
    return NO;
}

/// 判断是不是表情符号
- (BOOL)ls_emojiInUnicode:(short)code
{
    if (code == 0x0023
        || code == 0x002A
        || (code >= 0x0030 && code <= 0x0039)
        || code == 0x00A9
        || code == 0x00AE
        || code == 0x203C
        || code == 0x2049
        || code == 0x2122
        || code == 0x2139
        || (code >= 0x2194 && code <= 0x2199)
        || code == 0x21A9 || code == 0x21AA
        || code == 0x231A || code == 0x231B
        || code == 0x2328
        || code == 0x23CF
        || (code >= 0x23E9 && code <= 0x23F3)
        || (code >= 0x23F8 && code <= 0x23FA)
        || code == 0x24C2
        || code == 0x25AA || code == 0x25AB
        || code == 0x25B6
        || code == 0x25C0
        || (code >= 0x25FB && code <= 0x25FE)
        || (code >= 0x2600 && code <= 0x2604)
        || code == 0x260E
        || code == 0x2611
        || code == 0x2614 || code == 0x2615
        || code == 0x2618
        || code == 0x261D
        || code == 0x2620
        || code == 0x2622 || code == 0x2623
        || code == 0x2626
        || code == 0x262A
        || code == 0x262E || code == 0x262F
        || (code >= 0x2638 && code <= 0x263A)
        || (code >= 0x2648 && code <= 0x2653)
        || code == 0x2660
        || code == 0x2663
        || code == 0x2665 || code == 0x2666
        || code == 0x2668
        || code == 0x267B
        || code == 0x267F
        || (code >= 0x2692 && code <= 0x2694)
        || code == 0x2696 || code == 0x2697
        || code == 0x2699
        || code == 0x269B || code == 0x269C
        || code == 0x26A0 || code == 0x26A1
        || code == 0x26AA || code == 0x26AB
        || code == 0x26B0 || code == 0x26B1
        || code == 0x26BD || code == 0x26BE
        || code == 0x26C4 || code == 0x26C5
        || code == 0x26C8
        || code == 0x26CE
        || code == 0x26CF
        || code == 0x26D1
        || code == 0x26D3 || code == 0x26D4
        || code == 0x26E9 || code == 0x26EA
        || (code >= 0x26F0 && code <= 0x26F5)
        || (code >= 0x26F7 && code <= 0x26FA)
        || code == 0x26FD
        || code == 0x2702
        || code == 0x2705
        || (code >= 0x2708 && code <= 0x270D)
        || code == 0x270F
        || code == 0x2712
        || code == 0x2714
        || code == 0x2716
        || code == 0x271D
        || code == 0x2721
        || code == 0x2728
        || code == 0x2733 || code == 0x2734
        || code == 0x2744
        || code == 0x2747
        || code == 0x274C
        || code == 0x274E
        || (code >= 0x2753 && code <= 0x2755)
        || code == 0x2757
        || code == 0x2763 || code == 0x2764
        || (code >= 0x2795 && code <= 0x2797)
        || code == 0x27A1
        || code == 0x27B0
        || code == 0x27BF
        || code == 0x2934 || code == 0x2935
        || (code >= 0x2B05 && code <= 0x2B07)
        || code == 0x2B1B || code == 0x2B1C
        || code == 0x2B50
        || code == 0x2B55
        || code == 0x3030
        || code == 0x303D
        || code == 0x3297
        || code == 0x3299
        // 第二段
        || code == 0x23F0) {
        return YES;
    }
    return NO;
}

/// 判断包不包含表情
- (BOOL)ls_emojiInSoftBankUnicode:(short)code
{
    return ((code >> 8) >= 0xE0 && (code >> 8) <= 0xE5 && (Byte)(code & 0xFF) < 0x60);
}

#pragma mark- 根据身份证号获取相关信息
/** 从身份证里面获取性别man 或者 woman 不正确的身份证返回nil*/
- (NSString *)ls_getGenderFromIdentityNumber
{
    if (self.ls_checkIdentityNumber) {
        NSString *number = self.ls_filterSpecialString;
        NSInteger i = [[number substringWithRange:NSMakeRange(number.length - 2, 1)] integerValue];
        if (i % 2 == 1) {
            return @"man";
        } else {
            return @"woman";
        }
    } else {
        return nil;
    }
}

/** 从身份证获取生日,身份证格式不正确返回nil,正确返回:1990年01月01日*/
- (NSString *)ls_getBirthdayFromIdentityNumber
{
    if (self.ls_checkIdentityNumber) {
        NSString *number = self.ls_filterSpecialString;
        if (number.length == 18) {
            return [NSString stringWithFormat:@"%@年%@月%@日",[number substringWithRange:NSMakeRange(6,4)], [number substringWithRange:NSMakeRange(10,2)], [number substringWithRange:NSMakeRange(12,2)]];
        }
        if (number.length == 15) {
            return [NSString stringWithFormat:@"19%@年%@月%@日",[number substringWithRange:NSMakeRange(6,2)], [number substringWithRange:NSMakeRange(8,2)], [number substringWithRange:NSMakeRange(10,2)]];
        };
        return nil;
    } else {
        return nil;
    }
}

#pragma mark- 计算字符串尺寸
/** 计算字符串尺寸*/
+ (CGSize)ls_sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)size
{
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [string boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size;
}

#pragma mark- 进制转字符串

+ (NSString *)ls_hexStringFromData:(NSData *)data
{
    Byte *bytes = (Byte *)[data bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[data length];i++){
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]== 1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}

#pragma mark- 富文本处理
/** 添加中划线*/
- (NSMutableAttributedString *)ls_addCenterLine
{
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attributeStr;
}

/** 添加下划线*/
- (NSMutableAttributedString *)ls_addDownLine
{
    
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attributeStr;
}

#pragma mark- 加密处理
- (NSString *)ls_md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];//字符串数组
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest);// This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            digest[0], digest[1], digest[2], digest[3],
            digest[4], digest[5], digest[6], digest[7],
            digest[8], digest[9], digest[10], digest[11],
            digest[12], digest[13], digest[14], digest[15]
            ]; //%02x表示以16进制输出，02表示位数不够左端补0;
}

#pragma mark- hex string to byte

- (NSData *)ls_hexToData {
    if (self.length == 0 || self.length % 2 != 0) {
        return nil;
    }
    int j=0;
    Byte bytes[self.length];
    for(int i=0;i<self.length;i++)
    {
        int int_ch;  /// 两位16进制数转化后的10进制数
        unichar hex_char1 = [self characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            int_ch1 = (hex_char1-87)*16; //// a 的Ascll - 97
        i++;
        unichar hex_char2 = [self characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            int_ch2 = hex_char2-87; //// a 的Ascll - 97
        
        int_ch = int_ch1+int_ch2;
        bytes[j] = int_ch;  ///将转化后的数放入Byte数组里
        j++;
    }
    NSData *newData = [[NSData alloc] initWithBytes:bytes length:self.length/2];
    return newData;
}

/// 复制到粘贴板
- (void)ls_copyToPasteBoard {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self;
}

#pragma mark- Private

/** 验证身份证校验码*/
- (NSString *)ls_getLastIdentifyNumberForIdentifyNumber {
    //位数不小于17
    if (self.length < 17) {
        return nil;
    }
    //加权因子
    int R[] = {7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2};
    //校验码
    unsigned char sChecker[11] = {'1','0','X','9','8','7','6','5','4','3','2'};
    long p =0;
    for (int i =0; i<=16; i++){
        NSString * s = [self substringWithRange:NSMakeRange(i, 1)];
        p += [s intValue]*R[i];
    }
    //校验位
    int o = p%11;
    NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
    return string_content;
}



@end
