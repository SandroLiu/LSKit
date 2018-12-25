//
//  UIView+LSFrame.h
//  LSKitDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (SAFrame)

/**
 *  x轴坐标
 */
@property (nonatomic, assign) CGFloat frame_x;
/**
 *  y轴坐标
 */
@property (nonatomic, assign) CGFloat frame_y;
/**
 *  x轴最大值 x+width
 */
@property (nonatomic, assign) CGFloat frame_maxX;
/**
 *  y轴最大值 y+height
 */
@property (nonatomic, assign) CGFloat frame_maxY;
/**
 *  原点
 */
@property (nonatomic, assign) CGPoint frame_origin;


/**
 *  中心点x
 */
@property (nonatomic, assign) CGFloat frame_centerX;
/**
 *  中心点y
 */
@property (nonatomic, assign) CGFloat frame_centerY;


/**
 *  宽
 */
@property (nonatomic, assign) CGFloat frame_width;
/**
 *  高
 */
@property (nonatomic, assign) CGFloat frame_height;
/**
 *  尺寸
 */
@property (nonatomic, assign) CGSize frame_size;
@end

NS_ASSUME_NONNULL_END
