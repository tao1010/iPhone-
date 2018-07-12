//
//  UIImage+XT.m
//  WirelessProjectionScreen
//
//  Created by tao on 2018/7/12.
//  Copyright © 2018年 tao1010.github.io. All rights reserved.
//

#import "UIImage+XT.h"
#import <objc/runtime.h>

@implementation UIImage (XT)

+ (UIImage *)xt_imageNamed:(NSString *)name{
    
    NSLog(@"runtime 重写系统方法...");
    //用自定义方法调用系统方法(在load中交换了方法) [UIImage xt_imageNamed:name]
    return [UIImage xt_imageNamed:name];
}

+ (void)load{
    
    //获取两个类的类方法
    Method method1 = class_getClassMethod([UIImage class],@selector(imageNamed:));
    Method method2 = class_getClassMethod([UIImage class], @selector(xt_imageNamed:));
    method_exchangeImplementations(method1, method2);
}


@end
