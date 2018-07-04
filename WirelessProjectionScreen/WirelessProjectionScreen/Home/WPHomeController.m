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
    
    NSMutableArray *buttonArray = [NSMutableArray arrayWithCapacity:4];
    CGSize size = self.view.frame.size;
    
    CGFloat width = 100;
    CGFloat space = (size.width - width * 2) / 3;
    
    for (int i = 0; i < 6; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat oringin_x = space;
        if (i == 1 || i == 3 || i == 5) {
            
            oringin_x = space * 2 + width;
        }
        CGFloat oringin_y = size.height / 2 - width / 2;
        if (i == 0 || i==1) {
            
            oringin_y = size.height / 2 - width / 2 - space - width;
        }
        if (i == 4 || i == 5) {
            
            oringin_y = size.height / 2 + width / 2 + space;
        }
        
        NSString *title = [NSString stringWithFormat:@"按钮%d",i +1];
        button.frame = CGRectMake(oringin_x, oringin_y, 100, 100);
        button.backgroundColor = [UIColor lightGrayColor];
        button.titleLabel.backgroundColor = [UIColor yellowColor];
        button.imageView.backgroundColor = [UIColor blueColor];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        if (i == 4) {
            if ( arc4random() % 2) {
                
                [button setTitle:title forState:UIControlStateNormal];
            }else{
                [button setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
            }
        }else{
            
            [button setTitle:title forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
        }
        [self.view addSubview:button];
        [buttonArray addObject:button];
    }
    /**
     *  UIEdgeInsets insets = {top, left, bottom, right};
     *  正数就是距相应的边的距离增加，负数就是距相应的距离减少
     *  button2.currentImage.size.height
     *  button2.currentImage.size.width
     *  button2.titleLabel.intrinsicContentSize.height
     *  button2.titleLabel.intrinsicContentSize.width
     */
    
    //1.图左文右 - 默认
    UIButton *button1 = [buttonArray objectAtIndex:0];
    [button1 setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0,0,0,0)];
    NSLog(@"image：%@    titleLabel:%@\n",NSStringFromCGSize(button1.currentImage.size),NSStringFromCGSize(button1.titleLabel.intrinsicContentSize));
    
    //2.图文居中
    UIButton *button2 = [buttonArray objectAtIndex:1];
    [button2 setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-button2.titleLabel.intrinsicContentSize.width)];
    [button2 setTitleEdgeInsets:UIEdgeInsetsMake(0,-button2.currentImage.size.width,0,0)];
    
    NSLog(@"image：%@    titleLabel:%@\n",NSStringFromCGSize(button2.currentImage.size),NSStringFromCGSize(button2.titleLabel.intrinsicContentSize));
    
    //3.图右文左
    UIButton *button3 = [buttonArray objectAtIndex:2];
    [button3 setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-button3.titleLabel.intrinsicContentSize.width * 2)];
    [button3 setTitleEdgeInsets:UIEdgeInsetsMake(0,-button3.currentImage.size.width * 2,0,0)];
    NSLog(@"image：%@    titleLabel:%@\n",NSStringFromCGSize(button3.currentImage.size),NSStringFromCGSize(button3.titleLabel.intrinsicContentSize));
    
    
    //4.图上文下
    UIButton *button4 = [buttonArray objectAtIndex:3];
    [button4 setImageEdgeInsets:UIEdgeInsetsMake(-button4.titleLabel.intrinsicContentSize.height,0,0,-button4.titleLabel.intrinsicContentSize.width)];
    [button4 setTitleEdgeInsets:UIEdgeInsetsMake(0,-button4.currentImage.size.width,-button4.currentImage.size.height,0)];
    NSLog(@"image：%@    titleLabel:%@\n",NSStringFromCGSize(button4.currentImage.size),NSStringFromCGSize(button4.titleLabel.intrinsicContentSize));
   
    //5.图文显示其一
    UIButton *button5 = [buttonArray objectAtIndex:4];
    NSLog(@"image：%@    titleLabel:%@\n",NSStringFromCGSize(button5.currentImage.size),NSStringFromCGSize(button5.titleLabel.intrinsicContentSize));
    
    //6.图下 文上
    UIButton *button6 = [buttonArray objectAtIndex:5];
    [button6 setImageEdgeInsets:UIEdgeInsetsMake(0,0,-button6.titleLabel.intrinsicContentSize.height,-button6.titleLabel.intrinsicContentSize.width)];
    [button6 setTitleEdgeInsets:UIEdgeInsetsMake(-button6.currentImage.size.height,-button6.currentImage.size.width,0,0)];
    NSLog(@"image：%@    titleLabel:%@\n",NSStringFromCGSize(button6.currentImage.size),NSStringFromCGSize(button6.titleLabel.intrinsicContentSize));
    
    
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
