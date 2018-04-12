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
    [self josephQuestionWithNumber:2 allCount:5];
}

/**
 *  约瑟夫问题
 *  n 个人围成一圈报数，报到 m 的人出列，要求计算删除顺序，并找到最后剩下的那个人。
 *  number: 报到的数字
 *  allCount： 总人数
 */
- (void)josephQuestionWithNumber:(NSInteger)number allCount:(NSInteger)allCount{
    
    /**
     问题的关键有两点：
     
     一是围成了一个圈，那么报数的时候就要考虑到循环遍历。
     
     二是被删除的人的表示问题：①如果是数组实现的话，那么就应该是对删除的人做标记，表示其已经被删除，否则你就需要每删除一个人，就要将所有后面的人的位置都向前挪一位；②如果是链表实现的话，那么你删除的时候直接删除表示该人的节点就好。
     
     */
    
    NSInteger remain = allCount;//剩余人数
    NSMutableArray *allCountArray = [[NSMutableArray alloc] init];
    //每个人进行编号处理
    for (int i = 0; i < allCount; i ++) {
        
        [allCountArray addObject:@(i+1)];
    }
    //循环知道最后一位
    NSInteger count = 0;//依次计数 - 对比报到数据
    while (remain > 1) {
        
        for (int i = 0; i < allCount; i ++) {
            
            if (allCountArray[i] != 0) {
                
                count ++;
                if(count == number){
                    //将要删除的数据替换为0
                    
                    if (remain > 1) {
                        
                        [allCountArray replaceObjectAtIndex:i withObject:@(0)];
                        count = 0;
                        remain --;
                    }else{
                        for (int i = 0; i < allCount; i ++) {
                            
                            if ([allCountArray[i] integerValue] != 0) {
                                
                                NSLog(@"这就是最后留下的人的编号:%@",allCountArray[i]);
                                break;
                            }
                        }
                        return;
                    }
                }
            }
        }
    }
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
