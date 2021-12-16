//
//  HTNormalListViewController.m
//  HTScrollDriver_Example
//
//  Created by zzzz on 2021/11/25.
//  Copyright © 2021 wangce02. All rights reserved.
//

#import "HTNormalListViewController.h"
#import "HTBannerImgViewCell.h"

typedef enum : NSUInteger {
    HTNormalListSectionTagTop,
    HTNormalListSectionTagGoodList
} HTNormalListSectionTag;

@interface HTNormalListViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HTTableDriver *tableDriver;

@end

@implementation HTNormalListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 视图
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    // 驱动
    self.tableDriver = [[HTTableDriver alloc] init];
    self.tableDriver.ownerView = self.tableView;
    self.tableDriver.scrollViewDelegate = self;
    
    // 加载页面数据
    [self loadPageData];
}

#pragma mark - 加载页面数据

- (void)loadPageData{
    
    NSString *bannerImg = @"https://pic2.zhuanstatic.com/zhuanzh/n_v2afb358befbca446fbbc31d01c74ac120.png";
    NSArray *diamondArr = @[
        @{@"image":@"https://pic2.zhuanstatic.com/zhuanzh/n_v2afb358befbca446fbbc31d01c74ac120.png",
          @"title":@"111"},
        @{@"image":@"https://pic2.zhuanstatic.com/zhuanzh/n_v2afb358befbca446fbbc31d01c74ac120.png",
          @"title":@"222"},
        @{@"image":@"https://pic2.zhuanstatic.com/zhuanzh/n_v2afb358befbca446fbbc31d01c74ac120.png",
          @"title":@"333"},
        @{@"image":@"https://pic2.zhuanstatic.com/zhuanzh/n_v2afb358befbca446fbbc31d01c74ac120.png",
          @"title":@"444"},
    ];
    
    // 构建顶部的headerView
    [self.tableDriver addTableViewHeader:@"HTTableViewHeaderFooter" headerData:@"这是tableViewHeader"];
    // 构建底部的footerView
    [self.tableDriver addTableViewFooter:@"HTTableViewHeaderFooter" footerData:@"这是tableViewFooter"];
    
    // 构建第一个section
    [self.tableDriver addSectionWithTag:HTNormalListSectionTagTop];
    // 轮播cell
    [self.tableDriver addCell:@"HTBannerImgViewCell" cellData:bannerImg toSection:HTNormalListSectionTagTop];
    // 2个金刚位cell
    [self.tableDriver addCell:@"HTDiamondViewCell" cellData:[diamondArr subarrayWithRange:NSMakeRange(0, 2)] toSection:HTNormalListSectionTagTop];
    // 4个金刚位cell
    [self.tableDriver addCell:@"HTDiamondViewCell" cellData:diamondArr cellTag:101 toSection:HTNormalListSectionTagTop];
    // 添加一个Footer
    [self.tableDriver addSectionFooter:@"HTNormalTableSectionHeader" footerData:@"这是sectionFooter" toSection:HTNormalListSectionTagTop];
    
    // 底部的商品列表
    [self.tableDriver addSectionWithTag:HTNormalListSectionTagGoodList];
    // 添加一个Header
    [self.tableDriver addSectionHeader:@"HTNormalTableSectionHeader" headerData:@"商品列表" toSection:HTNormalListSectionTagGoodList];
    // 添加很多个商品cell
    NSMutableArray *goods = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; i++) {
        [goods addObject:@"https://pic2.zhuanstatic.com/zhuanzh/n_v2afb358befbca446fbbc31d01c74ac120.png"];
    }
    [self.tableDriver addCell:@"HTNomalGoodListCell" cellDatas:goods toSection:HTNormalListSectionTagGoodList];
    
    // 刷新数据
    [self.tableView reloadData];
    
    // 获取总的高度
    CGFloat tableViewHeight = [self.tableDriver ownerViewTotalHeight];
    NSLog(@"总的tableView的高度%.2lf",tableViewHeight);
    
    // 获取101tag的高度
    UIView *view = [self.tableView viewWithTag:101];
    NSLog(@"%@",NSStringFromClass(view.class));
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark - Getter


@end
