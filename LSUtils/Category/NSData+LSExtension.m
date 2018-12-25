//
//  NSData+LSExtension.m
//  LSUtilsDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "NSData+LSExtension.h"

@implementation NSData (LSExtension)

/// 提取字节值放到字符串内
- (NSString *)ls_toHexString {
    static const char hexdigits[] = "0123456789ABCDEF";
    const size_t numBytes = self.length;
    const unsigned char* bytes = self.bytes;
    char *strbuf = (char *)malloc(numBytes * 2 + 1);
    char *hex = strbuf;
    NSString *hexBytes = nil;
    for (int i = 0; i<numBytes; ++i) {
        const unsigned char c = *bytes++;
        *hex++ = hexdigits[(c >> 4) & 0xF];
        *hex++ = hexdigits[(c ) & 0xF];
    }
    
    *hex = 0;
    hexBytes = [NSString stringWithUTF8String:strbuf];
    
    free(strbuf);
    return hexBytes;
}
@end
