//
//  UIView+LSFrame.m
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import "UIView+SAFrame.h"

@implementation UIView (SAFrame)

/**
 *  x轴坐标值
 */
- (CGFloat)frame_x
{
    return self.frame.origin.x;
}
- (void)setFrame_x:(CGFloat)frame_x
{
    CGRect frame = self.frame;
    frame.origin.x = frame_x;
    self.frame = frame;
}

/**
 *  y轴坐标值
 */
- (CGFloat)frame_y
{
    return self.frame.origin.y;
}
- (void)setFrame_y:(CGFloat)frame_y
{
    CGRect frame = self.frame;
    frame.origin.y = frame_y;
    self.frame = frame;
}


/**
 *  x轴坐标最大值
 */
- (CGFloat)frame_maxX
{
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setFrame_maxX:(CGFloat)frame_maxX
{
    CGRect frame = self.frame;
    frame.origin.x = frame_maxX - frame.size.width;
    self.frame = frame;
}

/**
 *  y轴坐标最大值
 */
- (CGFloat)frame_maxY
{
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setFrame_maxY:(CGFloat)frame_maxY
{
    CGRect frame = self.frame;
    frame.origin.y = frame_maxY - frame.size.height;
    self.frame = frame;
}


/**
 *  原点坐标值
 */
- (CGPoint)frame_origin
{
    return self.frame.origin;
}
- (void)setFrame_origin:(CGPoint)frame_origin
{
    CGRect frame = self.frame;
    frame.origin = frame_origin;
    self.frame = frame;
}


/**
 *  中心点x轴坐标值
 */
- (CGFloat)frame_centerX
{
    return self.center.x;
}
- (void)setFrame_centerX:(CGFloat)frame_centerX
{
    CGPoint center = self.center;
    center.x = frame_centerX;
    self.center = center;
}


/**
 *  中心点y轴坐标值
 */
- (CGFloat)frame_centerY
{
    return self.center.y;
}
- (void)setFrame_centerY:(CGFloat)frame_centerY
{
    CGPoint center = self.center;
    center.y = frame_centerY;
    self.center = center;
}


/**
 *  高度
 */
- (CGFloat)frame_height
{
    return self.frame.size.height;
}
- (void)setFrame_height:(CGFloat)frame_height
{
    CGRect frame = self.frame;
    frame.size.height = frame_height;
    self.frame = frame;
}


/**
 *  宽度
 */
- (CGFloat)frame_width
{
    return self.frame.size.width;
}
- (void)setFrame_width:(CGFloat)frame_width
{
    CGRect frame = self.frame;
    frame.size.width = frame_width;
    self.frame = frame;
}


/**
 *  尺寸
 */
- (CGSize)frame_size
{
    return self.frame.size;
}
- (void)setFrame_size:(CGSize)frame_size
{
    CGRect frame = self.frame;
    frame.size = frame_size;
    self.frame = frame;
}

@end
