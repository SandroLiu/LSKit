//
//  UIImage+LSExtension.h
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LSExtension)

/**
 * 取消系统渲染
 */
+ (UIImage *_Nullable)ls_imageWithOriginalRendering:(NSString *_Nonnull)imageName;

/**
 * 从颜色生成图片
 */
+ (UIImage *_Nullable)ls_imageFromUIColor:(UIColor *_Nonnull)color;

/**
 * 缩放图片按照给定的大小
 */
+ (UIImage *_Nullable)ls_image:(UIImage *_Nonnull)image scaleToSize:(CGSize)size;
/**
 * 缩放图片按照比例
 */
+ (UIImage *_Nullable)ls_image:(UIImage *_Nonnull)image scaleWithRatio:(CGFloat)ratio;
/**
 * 压缩后返回图片 小于1M
 */
+ (UIImage *_Nullable)ls_compressImage:(UIImage *_Nonnull)image;
/**
 * 压缩后返回二进制文件 小于1M
 */
+ (NSData *_Nullable)ls_compressImageToData:(UIImage *_Nonnull)image;

/**
 *压缩图片返回图片
 */
- (UIImage *_Nullable)ls_imageCompressQualityWithMaxLength:(NSInteger)maxLength;

/**
 *压缩图片返回二进制文件
 */
- (NSData *_Nullable)ls_compressQualityWithMaxLength:(NSInteger)maxLength;

/**
 * 给图片添加水印
 */
+ (UIImage *_Nullable)ls_image:(UIImage *_Nonnull)img addLogo:(UIImage *_Nonnull)logo;

/**
 * 屏幕截图有状态栏
 */
+ (UIImage *_Nullable)ls_imageWithScreenshot;
/**
 * 屏幕截图没有状态栏
 */
+ (UIImage *_Nullable)ls_imageWithScreenshotNoStatusBar;
/**
 * 给一个view截图
 */
+ (UIImage *_Nullable)ls_imageForView:(UIView * _Nonnull )view;
/**
 * 截取图片的一部分
 */
- (UIImage *_Nullable)ls_cutImageWithRect:(CGRect)cutRect;
/**
 * 不带边框的圆形图片
 */
+ (instancetype _Nullable )ls_circleImageNamed:(NSString *_Nonnull)name;
/**
 *不带边框的圆形图片
 */
- (instancetype _Nullable )ls_circleImage;
/**
 *带边框的圆形图片
 */
+ (instancetype _Nullable )ls_circleWithEdgeImageNamed:(NSString *_Nonnull)named ;
/**
 *带边框的圆形图片
 */
- (instancetype _Nullable )ls_circleWithEdge ;
/**
 缩放到指定大小
 
 @param size 指定大小的尺寸
 @return 缩放后的图片
 */
- (UIImage *_Nullable)ls_scaleToSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
