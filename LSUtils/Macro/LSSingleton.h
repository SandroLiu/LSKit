//
//  LSSingleton.h
//  LSUtilsDemo
//
//  Created by 刘帅 on 2018/12/25.
//  Copyright © 2018年 刘帅. All rights reserved.
//

#ifndef LSSingleton_h
#define LSSingleton_h

//由于宏定义里有需要替换的内容所以定义一个变量className
//##用于分割、连接字符串
#define singleton_interface(className) +(className *_Nonnull)shared##className;

#pragma mark 实现.m
//\在代码中用于连接宏定义,以实现多行定义
#define singleton_implementation(className) \
static className *_instance;\
+(id)shared##className{\
static dispatch_once_t dispatchOnce;\
dispatch_once(&dispatchOnce, ^{\
_instance=[[self alloc]init];\
});\
return _instance;\
}\
+(id)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t dispatchOnce;\
dispatch_once(&dispatchOnce, ^{\
_instance=[super allocWithZone:zone];\
});\
return _instance;\
}

#endif /* LSSingleton_h */
