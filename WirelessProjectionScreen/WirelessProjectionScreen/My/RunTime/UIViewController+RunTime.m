//
//  UIViewController+RunTime.m
//  WirelessProjectionScreen
//
//  Created by tao on 2018/7/12.
//  Copyright © 2018年 tao1010.github.io. All rights reserved.
//

#import "UIViewController+RunTime.h"
#import <objc/runtime.h>

char hahaKey;

@implementation UIViewController (RunTime)

-(void)setHaha:(NSString *)haha{
    // 将某个值跟某个对象关联起来，将某个值存储到某个对象中
    objc_setAssociatedObject(self, &hahaKey, haha, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)haha{
    return objc_getAssociatedObject(self, &hahaKey);
}

- (void)xx_viewWillAppear:(BOOL)animated{

    NSLog(@"xx_viewWillAppear");
}

+ (void)load{
    
    NSLog(@"-----------------");
    Method method1 = class_getClassMethod([UIViewController class], @selector(viewWillAppear:));
    Method method2 = class_getClassMethod([UIViewController class], @selector(xx_viewWillAppear:));
    method_exchangeImplementations(method1, method2);
}

@end
