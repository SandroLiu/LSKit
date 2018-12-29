//
//  LSHUDManager.m
//  LSUtilsDemo
//
//  Created by 刘帅 on 2018/12/29.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "LSHUDManager.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation LSHUDManager

/**
 * SVProgressHUD 属性设置
 
 * defaultStyle: 设置 HUD本身的样式
 >1. SVProgressHUDStyleLight 默认样式，亮灰色
 >2. SVProgressHUDStyleDark 灰色
 >3. SVProgressHUDStyleCustom 使用自定义的背景色,和文字颜色
 > 使用 backgrongdColor 和 foregroundColor 设置，测试发现设置这两个,不管别的样式是什么都会覆盖别
 
 * defaultMaskType HUD遮挡的样式
 >1. SVProgressHUDMaskTypeNone 默认什么都没有，允许用户交互，其他都不允许用户交互
 >2. SVProgressHUDMaskTypeClear 透明样式
 >3. SVProgressHUDMaskTypeBlack 灰色
 >4. SVProgressHUDMaskTypeGradient 好像没用
 >5. SVProgressHUDMaskTypeCustom 自定义遮盖的颜色
 > 使用 backgroundLayerColor 设置
 
 * minimumDismissTimeInterval
 * maximumDismissTimeInterval
 > 自动消失状态下显示的最短-最长时间范围，综合字符串长度选出最合适时间
 
 * DefaultAnimationType:HUD 出现和消失的动画
 >1. SVProgressHUDAnimationTypeFlat 默认动画,平滑
 >2. SVProgressHUDAnimationTypeNative 突然出现，突然消失
 
 * minimumSize HUD 最小的尺寸
 
 * SVProgressHUD 显示方法
 * show 显示一个正在加载的动画，没有文字，不会自动消失
 * showWithStatus 显示一个正在加载的动画并且有文字，不会自动消失
 * showProgress 显示一个加载进度的图片，不会自动消失
 * showProgress:(float)progress status:(NSString*)status 显示一个进度图片，并且带有文字
 *   >进度可以修改
 * setStatus正在显示时修改文字
 * showInfoWithStatus设置一个提醒消息，图片是提醒图片，自动消失
 * showSuccessWithStatus 展示一个成功的提示，自动消失
 * showErrorWithStatus 展示一个错误的提示，自动消失
 * showImage:(UIImage*)image status:(NSString*)status 展示自定义图片和文字，如果图片为 nil 则不显示图片
 * dismissWithCompletion 是 HUD 消失，并且消失完成后会有回调
 */

/**
 *  初始加载，程序一启动就加载
 */
+ (void)load
{
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 100)];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}

+ (void)showSVHUDSuccessWithMessage:(NSString *)message
{
    [SVProgressHUD setMinimumDismissTimeInterval:0];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showSuccessWithStatus:message];
}

+ (void)showSVHUDSuccessNODissmissWithMessage:(NSString *)message {
    [SVProgressHUD setMinimumDismissTimeInterval:5];
    [SVProgressHUD setMaximumDismissTimeInterval:CGFLOAT_MAX];
    NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    //    UIImage* infoImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"info" ofType:@"png"]];
    UIImage* successImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"success" ofType:@"png"]];
    
    [SVProgressHUD showImage:successImage status:message];
}

+ (void)showSVHUDErrorWithMessage:(NSString *)message
{
    [SVProgressHUD setMinimumDismissTimeInterval:0];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showErrorWithStatus:message];
}

+ (void)showSVHUDErrorNoDissmissWithMessage:(NSString *)message {
    [SVProgressHUD setMinimumDismissTimeInterval:5];
    [SVProgressHUD setMaximumDismissTimeInterval:CGFLOAT_MAX];
    NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    UIImage* errorImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
    [SVProgressHUD showImage:errorImage status:message];
}

+ (void)showSVHUDMessage:(NSString *)message
{
    [SVProgressHUD setMinimumDismissTimeInterval:0];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showInfoWithStatus:message];
}

+ (void)showSVHUDLoadingMessage:(NSString *)message
{
    [SVProgressHUD showWithStatus:message];
}

+ (void)showSVHUDAlertMessage:(NSString *)message
{
    [SVProgressHUD setMinimumDismissTimeInterval:0];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD showInfoWithStatus:message];
}

+ (void)dissmissSVHUD
{
    [SVProgressHUD dismissWithCompletion:^{
        
    }];
}
+ (void)dissmissSVHUDWithCompletion:(void (^)(void))completion
{
    [SVProgressHUD dismissWithCompletion:^{
        if (completion) {
            completion();
        }
    }];
}

+ (void)dissmissSVHUDAfterTime:(NSTimeInterval)time completion:(void (^)(void))completion {
    [SVProgressHUD dismissWithDelay:time completion:completion];
}
@end
