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

@interface WPMyCotroller()


@property(nonatomic, strong) UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *getButton;
@property (weak, nonatomic) IBOutlet UIButton *postButton;



@end


@implementation WPMyCotroller

- (void)viewDidLoad{
    [super viewDidLoad];
    
   
//    [self testArray];
//    [self testButton];
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

}









@end
