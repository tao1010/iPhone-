//
//  WPHomeController.m
//  WirelessProjectionScreen
//
//  Created by tao on 2018/3/28.
//  Copyright © 2018年 tao1010.github.io. All rights reserved.
//

#import "WPHomeController.h"

@interface WPHomeController()

@end

@implementation WPHomeController


- (void)viewDidLoad{
    
    [super viewDidLoad];
//    [self configNSThread];

}

- (void)invocationOperationAction:(NSObject *)object{
    
    NSLog(@"NSInvocationOperation包含的任务，没有加入队列====%@====%@",object,[NSThread currentThread]);

}


- (void)configNSThread{
    
    //方法一：对象方法,需要手动开启
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(startNSTreadAction:) object:@"NSThread_1"];
    //线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
    [thread1 start];
    
    //方法二：类方法，创建之后，自动开启
    [NSThread detachNewThreadSelector:@selector(startNSTread2Action:) toTarget:self withObject:@"NSThread_2"];
    
    //方法三：隐视创建，自动开启
    [self performSelectorInBackground:@selector(startNSTread3Action:) withObject:@"NSThread_3"];
    
    //当前线程 打印结果为：{number = 1,name = main} 表示主线程，其他表示子线程
    [NSThread currentThread];
    
    //阻塞主线程
    [NSThread sleepForTimeInterval:10.0];//时间
    [NSThread sleepUntilDate:[NSDate date]];//日期
    //退出线程
    [NSThread exit];
    //是否为主线程
    [NSThread isMainThread];
    //是否是多线程
    [NSThread isMultiThreaded];
    //主线程对象
    NSThread *thread = [NSThread mainThread];
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    // 并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
   
    
    // 同步执行任务
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        // 任务放在这个block里
        NSLog(@"我是同步执行的任务");
        
    });
    // 异步执行任务
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 任务放在这个block里
        NSLog(@"我是异步执行的任务");
        
    });
}





//MARK:Methods
- (void)startNSTreadAction:(NSObject *)object{
    
    NSLog(@"%@",object);
    NSLog(@"doSomething1：%@",[NSThread currentThread]);
}
- (void)startNSTread2Action:(NSObject *)object{
    
    NSLog(@"%@",object);
    NSLog(@"doSomething2：%@",[NSThread currentThread]);
}
- (void)startNSTread3Action:(NSObject *)object{
    
    NSLog(@"%@",object);
    NSLog(@"doSomething3：%@",[NSThread currentThread]);
}
- (void)startNSTread4Action:(NSObject *)object{
    
    NSLog(@"%@",object);
    NSLog(@"doSomething4：%@",[NSThread currentThread]);
}


@end
