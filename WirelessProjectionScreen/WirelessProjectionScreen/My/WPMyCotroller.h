//
//  WPMyCotroller.h
//  WirelessProjectionScreen
//
//  Created by tao on 2018/3/28.
//  Copyright © 2018年 tao1010.github.io. All rights reserved.
//

#import "WPBaseController.h"

@interface WPMyCotroller : WPBaseController

@property(nonatomic, assign) NSInteger count;
@property(nonatomic, assign) int number;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, strong) NSDictionary *dic;

@end
