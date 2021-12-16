//
//  HTViewController.m
//  HTScrollDriver
//
//  Created by wangce02 on 11/25/2021.
//  Copyright (c) 2021 wangce02. All rights reserved.
//

#import "HTViewController.h"

@interface HTViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation HTViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationController.title = @"首页";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.dataSource = @[
        @{@"title":@"多样式cell列表",@"vc":@"HTNormalListViewController"},
        @{@"title":@"22",@"vc":@""}
    ];
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSDictionary *dict = self.dataSource[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.dataSource[indexPath.row];
    UIViewController *vc = [NSClassFromString(dict[@"vc"]) new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
