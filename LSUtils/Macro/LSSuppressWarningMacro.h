//
//  LSSuppressWarningMacro.h
//  Pods
//
//  Created by 刘帅 on 2019/1/4.
//

#ifndef LSSuppressWarningMacro_h
#define LSSuppressWarningMacro_h

/// 忽略PerformSelector警告
#define LS_SUPPRESS_PerformSelectorLeak_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/// 忽略未定义selector方法警告
#define  LS_SUPPRESS_Undeclaredselector_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wundeclared-selector\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/// 忽略过期API警告
#define LS_SUPPRESS_DEPRECATED_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wdeprecated-declarations\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/// 忽略未被使用的变量警告
#define LS_SUPPRESS_VARIABLE_WARNING(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wunused-variable\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* LSSuppressWarningMacro_h */
