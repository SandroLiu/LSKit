//
//  UITextField+LSExtension.m
//  LSUtilsDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "UITextField+LSExtension.h"
#import <objc/runtime.h>

@implementation UITextField (LSExtension)

+ (void)load
{
    Method setPlaceholder = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method ls_setPlaceholder = class_getInstanceMethod(self, @selector(ls_setPlaceholder:));
    method_exchangeImplementations(setPlaceholder, ls_setPlaceholder);
}

// 设置占位文字，设置占位文字颜色
- (void)ls_setPlaceholder:(NSString *)placeholder
{
    // 设置占位文字
    [self ls_setPlaceholder:placeholder];
    
    if (self.ls_placeholderColor) {
        self.ls_placeholderColor = self.ls_placeholderColor;
    }
    if (self.ls_placeholderFont) {
        self.ls_placeholderFont = self.ls_placeholderFont;
    }
}

/// 设置占位文字颜色
- (void)setLs_placeholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, @selector(ls_placeholderColor), placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 设置占位颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = self.ls_placeholderColor;
    
}
- (UIColor *)ls_placeholderColor
{
    return objc_getAssociatedObject(self, _cmd);
}

/// 设置占位文字字体
- (void)setLs_placeholderFont:(UIFont *)placeholderFont {
    objc_setAssociatedObject(self, @selector(ls_placeholderFont), placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 设置占位颜色
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.font = self.ls_placeholderFont;
}
- (UIFont *)ls_placeholderFont
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
