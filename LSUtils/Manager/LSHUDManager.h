//
//  LSHUDManager.h
//  LSUtilsDemo
//
//  Created by 刘帅 on 2018/12/29.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSHUDManager : NSObject

/**
 * 展示一个成功的提示
 */
+ (void)showSVHUDSuccessWithMessage:(NSString *)message;

/**
 展示一个成功的提示，不会自动消失
 
 @param message 展示的消息
 */
+ (void)showSVHUDSuccessNODissmissWithMessage:(NSString *)message;

/**
 * 显示固定样式的错误信息，自动消失
 */
+ (void)showSVHUDErrorWithMessage:(NSString *)message;

/**
 展示一个错误消息，不会自动消失
 */
+ (void)showSVHUDErrorNoDissmissWithMessage:(NSString *)message;

/**
 * 展示一个纯文本信息
 */
+ (void)showSVHUDMessage:(NSString *)message;

/**
 * 展示一个正在加载的信息
 */
+ (void)showSVHUDLoadingMessage:(NSString *)message;

/**
 * 展示一个提示信息，自动消失
 */
+ (void)showSVHUDAlertMessage:(NSString *)message;

/**
 *  使 HUD 消失
 */
+ (void)dissmissSVHUD;

/**
 使 HUD 消失

 @param completion 消失后回调
 */
+ (void)dissmissSVHUDWithCompletion:(void(^)(void))completion;

/**
 使 HUD 消失
 
 @param time time秒后消失
 @param completion 完成回调
 */
+ (void)dissmissSVHUDAfterTime:(NSTimeInterval)time completion:(void(^)(void))completion;
@end
