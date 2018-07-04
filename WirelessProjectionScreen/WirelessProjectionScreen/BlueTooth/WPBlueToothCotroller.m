//
//  WPBlueToothCotroller.m
//  WirelessProjectionScreen
//
//  Created by tao on 2018/3/28.
//  Copyright © 2018年 tao1010.github.io. All rights reserved.
//

#import "WPBlueToothCotroller.h"

@interface WPBlueToothCotroller()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *allocArray;
@property (nonatomic, assign) NSInteger  count;

@end

@implementation WPBlueToothCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.count = 0;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight + 20, kScreenWidth, kScreenHeight - kTopHeight - kBottomHeight - 100) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
//    tableView.rowHeight = 80;
//    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
//    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    [self.view addSubview:tableView];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSLog(@"11111");
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"55555");
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"8888");
    self.count ++;
    NSString *identifier = [NSString stringWithFormat:@"mycell%d%d",indexPath.row,indexPath.section];
    identifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSLog(@"8888");
        NSString *title = [NSString stringWithFormat:@"alloc : %d",indexPath.row + 1];
        [self.allocArray addObject:title];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else{
        
        NSLog(@"从重用池获取的数据");
    }
    NSLog(@"执行次数:%d visibleCells元素个数:%d",self.count,tableView.visibleCells.count);
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行",self.allocArray.lastObject];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"222222");
    return 50;
    //iPhone X 812
    /*
     rowheight = 100  rows = 6/15    执行次数:14 visibleCells元素个数:13
     rowheight = 50   rows = 12/15   执行次数:14 visibleCells元素个数:13
     rowheight = 50   rows = 12/150  执行次数:14 visibleCells元素个数:13
     rowheight = 50   rows = 8/8     执行次数:8 visibleCells元素个数:7
     */
    
    
    //iPhone SE 568
    /*
     rowheight = 100  rows = 4/15     执行次数:9 visibleCells元素个数:8
     rowheight = 50   rows = 8/15   执行次数:9 visibleCells元素个数:8
     rowheight = 50   rows = 8/150    执行次数:9 visibleCells元素个数:8
     rowheight = 50   rows = 8/8      执行次数:8 visibleCells元素个数:7
     */
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSLog(@"4444");
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSLog(@"3333");
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"6666");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSLog(@"77777");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    view.backgroundColor = [UIColor redColor];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"99999");
}

- (NSMutableArray *)allocArray{
    
    if (_allocArray == nil) {
        
        _allocArray = [NSMutableArray new];
    }
    return _allocArray;
}


@end
