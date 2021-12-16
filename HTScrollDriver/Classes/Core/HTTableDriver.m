//
//  HTTableDriver.m
//  EasyTableView
//
//  Created by 王策 on 2021/11/12.
//

#import "HTTableDriver.h"
#import "HTScrollDef.h"
#import "HTDriverData.h"

CGFloat const HTHeaderFooterMinHeight = CGFLOAT_MIN;

@interface HTTableDriver () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HTTableDriver

- (void)setOwnerView:(UIScrollView *)ownerView{
    [super setOwnerView:ownerView];
    UITableView *tableView = (UITableView *)ownerView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.estimatedSectionFooterHeight = 0;
    if (@available(iOS 15.0, *)) {
        tableView.sectionHeaderTopPadding = 0;
    }
}

#pragma mark - Public Methods

/// 总的高度
- (CGFloat)ownerViewTotalHeight{
    CGFloat totalHeight = [super ownerViewTotalHeight];
    if ([(UITableView *)self.ownerView tableHeaderView]) {
        totalHeight += [(UITableView *)self.ownerView tableHeaderView].bounds.size.height;
    }
    if ([(UITableView *)self.ownerView tableFooterView]) {
        totalHeight += [(UITableView *)self.ownerView tableFooterView].bounds.size.height;
    }
    return totalHeight;
}

/// 添加tableHeaderView
- (void)addTableViewHeader:(NSString *)headerClassName headerData:(id)headerData{
    UIView <HTCommonViewLayoutProtocol>*headerView = [[NSClassFromString(headerClassName) alloc] init];
    if (![headerView conformsToProtocol:@protocol(HTCommonViewLayoutProtocol)]) {
        return;
    }
    [headerView configDataModel:headerData indexPath:nil];
    CGSize headerSize = [headerView.class viewSizeWithDataModel:headerData];
    headerView.frame = CGRectMake(0, 0, headerSize.width, headerSize.height);
    [(UITableView *)self.ownerView setTableHeaderView:headerView];
}

/// 添加tableFooterView
- (void)addTableViewFooter:(NSString *)footerClassName footerData:(id)footerData{
    UIView <HTCommonViewLayoutProtocol>*footerView = [[NSClassFromString(footerClassName) alloc] init];
    if (![footerView conformsToProtocol:@protocol(HTCommonViewLayoutProtocol)]) {
        return;
    }
    [footerView configDataModel:footerData indexPath:nil];
    CGSize footerSize = [footerView.class viewSizeWithDataModel:footerData];
    footerView.frame = CGRectMake(0, 0, footerSize.width, footerSize.height);
    [(UITableView *)self.ownerView setTableFooterView:footerView];
}

/// 移除tableHeaderView
- (void)removeTableViewHeader{
    [(UITableView *)self.ownerView setTableHeaderView:nil];
}

/// 移除tableFooterView
- (void)removeTableViewFooter{
    [(UITableView *)self.ownerView setTableHeaderView:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataCenter.scrollViewData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HTCommonSectionViewModel *sectionViewModel = self.dataCenter.scrollViewData[section];
    return sectionViewModel.cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HTCommonItemViewModel *cellViewModel = [self cellViewModelWithIndexPath:indexPath];
    UITableViewCell <HTCommonViewLayoutProtocol>*cell = [tableView dequeueReusableCellWithIdentifier:cellViewModel.viewClassName forIndexPath:indexPath];
    // 配置数据
    [self configItemView:cell viewModel:cellViewModel indexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HTCommonItemViewModel *cellViewModel = [self cellViewModelWithIndexPath:indexPath];
    // 返回配置的高度
    return [cellViewModel getViewHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HTCommonItemViewModel *cellViewModel = [self cellViewModelWithIndexPath:indexPath];
    if(self.ownerView.superview){ // 事件冒泡
        [self.ownerView.superview eventBubbleWithName:HTScrollCellSelectAction params:@{
            @"model":cellViewModel.viewData,
            @"indexPath":indexPath
        }];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    HTCommonSectionViewModel *sectionViewModel = self.dataCenter.scrollViewData[section];
    HTCommonItemViewModel *headerViewModel = sectionViewModel.headerViewModel;
    if (!headerViewModel) {
        return HTHeaderFooterMinHeight;
    }
    return [headerViewModel getViewHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HTCommonSectionViewModel *sectionViewModel = self.dataCenter.scrollViewData[section];
    HTCommonItemViewModel *headerViewModel = sectionViewModel.headerViewModel;
    if (!headerViewModel) {
        return nil;
    }
    UITableViewHeaderFooterView <HTCommonViewLayoutProtocol>*headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionViewModel.headerViewModel.viewClassName];
    [self configItemView:headerView viewModel:headerViewModel indexPath:nil];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    HTCommonSectionViewModel *sectionViewModel = self.dataCenter.scrollViewData[section];
    HTCommonItemViewModel *footerViewModel = sectionViewModel.footerViewModel;
    if (!footerViewModel) {
        return HTHeaderFooterMinHeight;
    }
    return [footerViewModel getViewHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    HTCommonSectionViewModel *sectionViewModel = self.dataCenter.scrollViewData[section];
    HTCommonItemViewModel *footerViewModel = sectionViewModel.footerViewModel;
    if (!footerViewModel) {
        return nil;
    }
    UITableViewHeaderFooterView <HTCommonViewLayoutProtocol>*footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionViewModel.footerViewModel.viewClassName];
    [self configItemView:footerView viewModel:footerViewModel indexPath:nil];
    return footerView;
}

#pragma mark - Helper


@end
