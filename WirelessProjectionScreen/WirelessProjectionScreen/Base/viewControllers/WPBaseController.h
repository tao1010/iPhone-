//
//  WPBaseController.h
//  WirelessProjectionScreen
//
//  Created by tao on 2018/3/28.
//  Copyright © 2018年 tao1010.github.io. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNavBarHeight                   44.0

#define kStatusBarHeight                [[UIApplication sharedApplication] statusBarFrame].size.height

#define kTabBarHeight                   ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)

#define kTopHeight                      (kStatusBarHeight + kNavBarHeight)//状态栏+导航栏 = iPhoneX 44 + 44 | 其他 20 + 44
#define kBottomHeight                   ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? (83 - 49) : 0)//iPhoneX 底部需要34的手势区域
#define kScreenWidth                    [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight                   [[UIScreen mainScreen] bounds].size.height

@interface WPBaseController : UIViewController


@end
