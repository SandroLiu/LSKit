//
//  UIImage+LSExtension.m
//  LSUtilsDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "UIImage+LSExtension.h"

@implementation UIImage (LSExtension)

/** 取消系统渲染*/
+ (UIImage *)ls_imageWithOriginalRendering:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

/** 从颜色生成图片*/
+ (UIImage *)ls_imageFromUIColor:(UIColor *)color
{
    if (!color) {
        color = [UIColor clearColor];
    }
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 压缩图片
/** 缩放图片按照大小*/
+ (UIImage *)ls_image:(UIImage *)image scaleToSize:(CGSize)size
{
    CGImageRef imgRef = image.CGImage;
    CGSize originSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // 原始大小
    if (CGSizeEqualToSize(originSize, size)) {
        return image;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);            //[UIScreen mainScreen].scale
    CGContextRef context = UIGraphicsGetCurrentContext();
    /**
     *  设置CGContext集插值质量
     *  kCGInterpolationHigh 插值质量高
     */
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/** 缩放图片按照比例*/
+ (UIImage *)ls_image:(UIImage *)image scaleWithRatio:(CGFloat)ratio
{
    CGImageRef imgRef = image.CGImage;
    if (ratio > 1 || ratio <= 0) {
        return image;
    }
    CGSize size = CGSizeMake(CGImageGetWidth(imgRef) * ratio, CGImageGetHeight(imgRef) * ratio); // 缩放后大小
    return [self ls_image:image scaleToSize:size];
}

/** 压缩后返回图片*/
+ (UIImage *)ls_compressImage:(UIImage *)image
{
    NSData * data = [image ls_compressQualityWithMaxLength:1024*1024*1];
    return [UIImage imageWithData:data];
}

/** 压缩后返回二进制文件*/
+ (NSData *)ls_compressImageToData:(UIImage *)image
{
    return [image ls_compressQualityWithMaxLength:1024*1024*1];
}

/** 压缩图片返回图片*/
- (UIImage *)ls_imageCompressQualityWithMaxLength:(NSInteger)maxLength {
    NSData *data = [self ls_compressQualityWithMaxLength:maxLength];
    return [UIImage imageWithData:data];
}

/** 压缩图片返回二进制文件*/
- (NSData *)ls_compressQualityWithMaxLength:(NSInteger)maxLength {
    NSLog(@"压缩图片开始");
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        NSLog(@"Ratio = %.1f", ratio);
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}

#pragma mark - 添加水印
/** 给图片添加水印*/
+ (UIImage *)ls_image:(UIImage *)img addLogo:(UIImage *)logo
{
    if (logo == nil ) {
        return img;
    }
    if (img == nil) {
        return nil;
    }
    //get image width and height
    int w = img.size.width;
    int h = img.size.height;
    int logoWidth = logo.size.width;
    int logoHeight = logo.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //create a graphic context with CGBitmapContextCreate
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGContextDrawImage(context, CGRectMake(w-logoWidth-15, 10, logoWidth, logoHeight), [logo CGImage]);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return returnImage;
}

#pragma mark - 屏幕截图的几种方式

/** 屏幕截图有状态栏*/
+ (UIImage *)ls_imageWithScreenshot
{
    CGSize imageSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0);
    
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.screen == [UIScreen mainScreen]) {
            [window drawViewHierarchyInRect:[UIScreen mainScreen].bounds afterScreenUpdates:NO];
        }
    }
    UIView *statusBar = [[UIApplication sharedApplication] valueForKey:@"statusBar"];
    [statusBar drawViewHierarchyInRect:statusBar.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/** 屏幕截图没有状态栏*/
+ (UIImage *)ls_imageWithScreenshotNoStatusBar
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [UIApplication sharedApplication].windows)
    {
        if (window.screen == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, window.center.x, window.center.y);
            CGContextConcatCTM(context, window.transform);
            CGContextTranslateCTM(context, -window.bounds.size.width *window.layer.anchorPoint.x, -window.bounds.size.height *window.layer.anchorPoint.y);
            [window.layer renderInContext:context];
            CGContextRestoreGState(context);
        }
        
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

/** 给一个view截图*/
+ (UIImage *)ls_imageForView:(UIView * _Nonnull )view
{
    CGSize size = view.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

/** 截取部分图片*/
- (UIImage *)ls_cutImageWithRect:(CGRect)cutRect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, cutRect);
    UIGraphicsBeginImageContext(cutRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, cutRect, subImageRef);
    UIImage* cutedImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    if (subImageRef) {
        CFRelease(subImageRef);
    }
    return cutedImage;
}

#pragma mark- 圆形图片

/// 不带边框的圆形图片
+ (instancetype)ls_circleImageNamed:(NSString *)name {
    return [[self imageNamed:name] ls_circleImage];
}

/// 不带边框的圆形图片
- (instancetype)ls_circleImage {
    UIImage *image = nil;
    @autoreleasepool {
        // 1.开启图形上下文
        // 比例因素:当前点与像素比例
        UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
        // 2.描述裁剪区域
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
        // 3.设置裁剪区域;
        [path addClip];
        // 4.画图片
        [self drawAtPoint:CGPointZero];
        // 5.取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        // 6.关闭上下文
        UIGraphicsEndImageContext();
    }
    
    return image;
}

/// 带边框的圆形图片
+ (instancetype)ls_circleWithEdgeImageNamed:(NSString *)named {
    return [[self imageNamed:named] ls_circleWithEdge];
}

/// 带边框的圆形图片
- (instancetype)ls_circleWithEdge {
    // 1. 确定边框宽度
    CGFloat borderW = 1;
    // 2. 开启一个上下文
    CGSize size = CGSizeMake(self.size.width + 2 * borderW, self.size.height + 2 * borderW);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    // 3. 绘制大圆, 显示出来
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [[UIColor whiteColor] set];
    [path fill];
    // 4. 绘制小圆, 把小圆设置成裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, self.size.width, self.size.height)];
    [clipPath addClip];
    // 5. 把图片绘制到上下文当中
    [self drawAtPoint:CGPointMake(borderW, borderW)];
    // 6. 从上下文中取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 7. 关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)ls_scaleToSize:(CGSize)size {
    UIImage *scaledImage = [UIImage ls_image:self scaleToSize:size];
    return scaledImage;
}
@end
