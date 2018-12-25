//
//  UITextField+LSExtension.m
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "UITextField+SAExtension.h"
#import <objc/runtime.h>

@implementation UITextField (SAExtension)

+ (void)load
{
    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method sa_setPlaceholder = class_getInstanceMethod(self, @selector(sa_setPlaceholder:));
    method_exchangeImplementations(setPlaceholder, sa_setPlaceholder);
}

// 设置占位文字，设置占位文字颜色
- (void)sa_setPlaceholder:(NSString *)placeholder
{
    // 设置占位文字
    [self sa_setPlaceholder:placeholder];
    
    if (self.sa_placeholderColor) {
        self.sa_placeholderColor = self.sa_placeholderColor;
    }
    if (self.sa_placeholderFont) {
        self.sa_placeholderFont = self.sa_placeholderFont;
    }
}

/// 设置占位文字颜色
- (void)setSa_placeholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @selector(sa_placeholderColor), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 设置占位颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = self.sa_placeholderColor;
    
}
- (UIColor *)sa_placeholderColor
{
    return objc_getAssociatedObject(self, _cmd);
}

/// 设置占位文字字体
- (void)setSa_placeholderFont:(UIFont *)placeholderFont {
    objc_setAssociatedObject(self, @selector(sa_placeholderFont), placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 设置占位颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.font = self.sa_placeholderFont;
}
- (UIFont *)sa_placeholderFont
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
