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

@end

@implementation WPBlueToothCotroller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreenWidth, kScreenHeight - kTopHeight - kBottomHeight) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN)];
    [self.view addSubview:tableView];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        NSString *title = [NSString stringWithFormat:@"alloc : %d",indexPath.row + 1];
        NSLog(@"alloc : %d",indexPath.row + 1);
        [self.allocArray addObject:title];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%@行",self.allocArray.lastObject];
    
    return cell;
}


- (NSMutableArray *)allocArray{
    
    if (_allocArray == nil) {
        
        _allocArray = [NSMutableArray new];
    }
    return _allocArray;
}


@end
