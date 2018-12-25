//
//  LSUtilsMacro.h
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#ifndef SAUtilsMacro_h
#define SAUtilsMacro_h

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// block 强弱引用转换
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak

/// 主线程异步回调
#define dispatch_main_async(block)\
dispatch_async(dispatch_get_main_queue(), block);
/// 后台串行队列
#define dispatch_background_async(block)\
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
/**
 * 自动提示宏
 宏的操作原理，每输入一个字母就直接拷贝，并且会自动补齐前面的内容
 #会自动把后面的参数变成c语言的字符串
 逗号表达式：只取最右边的值
 void代表返回值没用，否则会报objc.keyPath没有使用
 */
#define keyPath(objc, keyPath) @(((void)objc.keyPath, #keyPath))

#define PerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
//A better version of NSLog
#define NSLog(format, ...) do {                                                                          \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "====================================\n\n");                \
} while (0)
#else
#   define NSLog(...)   ((void)0)
#endif

// 打印位置
#ifdef DEBUG
#define NSLogFrame(frame) NSLog(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f]", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)
#else
#define NSLogFrame(frame) ((void)0)
#endif

// 方法输出
#define NSLogFunc NSLog(@"%s", __func__);
//=======================打印日志=====================

//-----------------------颜色设置宏-------------------
//带有RGB的颜色设置
#define KColor(R, G, B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
//带有 alpha 的颜色设置
#define KColorWithA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
//16进制颜色转化为RGB形式
#define KColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//=======================颜色设置宏=====================


#endif /* LSUtilsMacro_h */
