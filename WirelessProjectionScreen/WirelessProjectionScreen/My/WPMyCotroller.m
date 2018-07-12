//
//  WPMyCotroller.m
//  WirelessProjectionScreen
//
//  Created by tao on 2018/3/28.
//  Copyright © 2018年 tao1010.github.io. All rights reserved.
//

#import "WPMyCotroller.h"
#import "AFNetworking.h"
#import "HYBHelperKit.h"
#import "DTCustomView.h"

#import "UIImage+XT.h"
#import "UIViewController+RunTime.h"
#import <objc/runtime.h>
//#import <objc/message.h>

@interface WPMyCotroller()


@property(nonatomic, strong) UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UIButton *postButton;



@end


@implementation WPMyCotroller

- (void)viewWillAppear:(BOOL)animated{
    
    NSLog(@"++++++");
}

- (void)viewDidLoad{
    [super viewDidLoad];
//#MARK -  TODO haha
   
//    [self testArray];
//    [self testButton];
    [self runtimeTest];
    
    //系统方法调用 自定义方法 xt_imageNamed(runtime 交换了方法)
    UIImage *image = [UIImage imageNamed:@"home"];
    NSDictionary *dic = @{@"k1":@"kkk",@"k2":@"kk"};
    
    NSString *hell = dic[@"hah"];
}


- (void)runtimeTest{
    
    //1.交换方法
    Method m1 = class_getClassMethod([WPMyCotroller class], @selector(method1));
    Method m2 = class_getClassMethod([WPMyCotroller class], @selector(method2));
    Method m3 = class_getInstanceMethod([WPMyCotroller class],@selector(configNetWorking));
    method_exchangeImplementations(m1, m2);//类方法 <--> 类方法
//    method_exchangeImplementations(m1, m3);//类方法 <--> 对象方法
    [WPMyCotroller method1]; //实际执行的是 m3对应的方法
    
    //2.添加类目属性
    /**
     
     */
    self.haha = @"测试一下";
    NSLog(@"runtime添加的分类:%@",self.haha);
    
    //3.获取类的所有成员变量
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([WPMyCotroller class], &outCount);
    //遍历成员变量
    for (int i = 0; i < outCount; i ++) {
        //取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        const char *type = ivar_getTypeEncoding(ivar);
        NSLog(@"成员变量:%s 成员变量类型:%s",name,type);
    }
    //释放内存
    free(ivars);
    
    
}

//重写归档解档方法
//设置不需要归档解档的属性
- (NSArray *)ignoredNames{
    return @[@"_aaa",@"_bbb",@"_ccc"];
}

//解档方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        unsigned int outCount = 0;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        //遍历成员变量
        for (int i = 0; i < outCount; i ++) {
            //取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            // 将每个成员变量名转换为NSString对象类型
            NSString *key = [NSString stringWithUTF8String:name];
            //忽略不需要归档属性
            if([[self ignoredNames] containsObject:key]){
                continue;
            }
            // 根据变量名解档取值(任意类型)
            id value = [aDecoder decodeObjectForKey:key];
            // 取出的值再设置给属性
            [self setValue:value forKey:key];
            // 取值赋值的过程<==> self.age = [aDecoder decodeObjectForKey:@"_age"]
        }
        //释放内存
        free(ivars);
    }
    return self;
}

//归档方法
- (void)encodeWithCoder:(NSCoder *)coder
{
    // 获取所有成员变量
    unsigned int outCount = 0;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        // 将每个成员变量名转换为NSString对象类型
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        
        // 忽略不需要归档的属性
        if ([[self ignoredNames] containsObject:key]) {
            continue;
        }
        
        // 通过成员变量名，取出成员变量的值
        id value = [self valueForKeyPath:key];
        // 再将值归档
        [coder encodeObject:value forKey:key];
        //取值归档的过程 <==> [coder encodeObject:@(self.age) forKey:@"_age"];
    }
    free(ivars);
}




+ (void)method1{
    
    NSLog(@"方法一");
}
+ (void)method2{
    
    NSLog(@"方法二");
}

+ (void)runtime{
    
    NSLog(@"runtime method...");
}

- (void)testArray{
    
    NSArray *array = @[@10,@23,@43,@54,@17,@5];
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
}


- (void)testButton{
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(50, 100, 300, 60);
    _button.layer.borderColor = [UIColor redColor].CGColor;
    _button.layer.borderWidth = 0.6;
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_button addObserver:self forKeyPath:@"titleName" options:NSKeyValueChangeNewKey context:nil];
    [self.view addSubview:_button];
}

- (void)clickButton:(UIButton *)sender{
    
    NSLog(@"点击按钮:%@\n",sender);
    NSLog(@"点击按钮:%@\n",sender.nextResponder);
    NSLog(@"点击按钮:%@\n",sender.nextResponder.nextResponder);
    NSLog(@"点击按钮:%@\n",sender.nextResponder.nextResponder.nextResponder);
    NSLog(@"点击按钮:%@\n",sender.nextResponder.nextResponder.nextResponder.nextResponder);
    NSLog(@"点击按钮:%@\n",sender.nextResponder.nextResponder.nextResponder.nextResponder.nextResponder);
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 将事件传递给 nextResponder
//    id theNextResponder = [self nextResponder];
//    [theNextResponder touchesBegan:touches withEvent:event];
    NSLog(@"++++++：%@",touches);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"------%@",NSStringFromCGPoint(point));
    
    
    return self.button;
}


- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context{
    
    if ([keyPath isEqualToString:@"titleName"]) {
        
        
    }
    NSLog(@"KVO");
}

#pragma mark - ConfigNetworking
- (NSString *)encodingWithString:(NSString *)string{
    
//    [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    
//    return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)unicodeWithString:(NSString *)string{
    
    return [string stringByRemovingPercentEncoding];
}

- (void)configNetWorking{
    
    NSString *api_url = @"http://op.juhe.cn/onebox/weather/query";
    NSString *api_key = @"69e9d363d843b615bb95efed68c14fd0";
    NSDictionary *paramDic = @{@"cityname":@"成都",
                               @"dtype":@"json",
                               @"key":api_key};
    NSLog(@"请求参数:%@",paramDic);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:api_url parameters:paramDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"获取进度:%.2lld,已完成:%lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功:%@,提示信息:%@",responseObject,[self unicodeWithString:responseObject[@"reason"]]);
        NSLog(@"请求成功:%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error.description);
    }];
}
- (IBAction)getAction:(id)sender {
    
    [self configNetWorking];
    
}
- (IBAction)postAction:(id)sender {

    [DTCustomView showView];
}









@end
