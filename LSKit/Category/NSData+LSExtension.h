//
//  NSData+LSExtension.h
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (LSExtension)

/**
 提取字节值放到字符串内
 
 @return 保存十六进制值的字符串
 */
- (NSString *)ls_toHexString;
@end

NS_ASSUME_NONNULL_END
