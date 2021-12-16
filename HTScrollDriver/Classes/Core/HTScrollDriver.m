//
//  HTScrollDriver.m
//  hunter
//
//  Created by zzzz on 2021/11/22.
//  Copyright © 2021 zhuanzhuan. All rights reserved.
//

#import "HTScrollDriver.h"

/// 选择cell的事件
NSString *const HTScrollCellSelectAction = @"__ht_scrollCellSelectAction";

@interface HTScrollDriver ()

@end

@implementation HTScrollDriver

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataCenter = [[HTDriverData alloc] init];
    }
    return self;
}

#pragma mark - Public Methods

- (void)setOwnerView:(UIScrollView *)ownerView{
    _ownerView = ownerView;
}

/// 清除所有的sectionModel数据
- (void)clearAll{
    [self.dataCenter clearAll];
}

/// 获取总的高度
- (CGFloat)ownerViewTotalHeight{
    CGFloat totalHeight = 0;
    for (HTCommonSectionViewModel *sectionViewModel in self.dataCenter.scrollViewData) {
        // sectionHeader
        totalHeight += [sectionViewModel getSectionHeight];
    }
    return totalHeight;
}

#pragma mark - Section Methods

/// 添加一个指定tag的section
- (void)addSectionWithTag:(NSInteger)tag{
    [self.dataCenter addSectionWithTag:tag];
}

/// 移除指定 tag 的section
- (void)removeSectionWithTag:(NSInteger)tag{
    [self.dataCenter removeSectionWithTag:tag];
}

#pragma mark - Cell Methods

/// 添加一个cell
- (void)addCell:(NSString *)cellClassName cellData:(id)cellData toSection:(NSInteger)sectionTag{
    [self addCell:cellClassName cellData:cellData cellTag:0 toSection:sectionTag];
}

/// 添加一个带Tag的cell
- (void)addCell:(NSString *)cellClassName cellData:(id)cellData cellTag:(NSInteger)cellTag toSection:(NSInteger)sectionTag{
    HTCommonItemViewModel *cellViewModel = [HTCommonItemViewModel itemViewModelWithData:cellData className:cellClassName viewTag:cellTag viewType:HTCommonItemViewTypeCell];
    [self.dataCenter addCellViewModel:cellViewModel toSection:sectionTag];
    
    // 注册cell
    [self registerCellWithClass:cellClassName];
}

/// 添加多个cell
- (void)addCell:(NSString *)cellClassName cellDatas:(NSArray *)cellDatas toSection:(NSInteger)sectionTag{
    NSMutableArray <HTCommonItemViewModel *>*cellViewModels = [NSMutableArray array];
    
    for (id cellData in cellDatas) {
        HTCommonItemViewModel *cellViewModel = [HTCommonItemViewModel itemViewModelWithData:cellData className:cellClassName viewTag:0 viewType:HTCommonItemViewTypeCell];
        [cellViewModels addObject:cellViewModel];
    }
    [self.dataCenter addCellViewModels:cellViewModels toSection:sectionTag];
    
    // 注册cell
    [self registerCellWithClass:cellClassName];
}

#define mark - Header&Footer Methods

/// 添加一个 sectionViewHeader
- (void)addSectionHeader:(NSString *)headerClassName headerData:(id)headerData toSection:(NSInteger)sectionTag{
    HTCommonItemViewModel *headerViewModel = [HTCommonItemViewModel itemViewModelWithData:headerData className:headerClassName viewTag:0 viewType:HTCommonItemViewTypeSectionHeader];
    [self.dataCenter addSectionHeaderViewModel:headerViewModel toSection:sectionTag];
    
    // 注册
    [self registerSectionHeaderWithClass:headerClassName];
}

/// 添加一个 sectionViewFooter
- (void)addSectionFooter:(NSString *)footerClassName footerData:(id)footerData toSection:(NSInteger)sectionTag{
    HTCommonItemViewModel *footerViewModel = [HTCommonItemViewModel itemViewModelWithData:footerData className:footerClassName viewTag:0 viewType:HTCommonItemViewTypeSectionFooter];
    [self.dataCenter addSectionFooterViewModel:footerViewModel toSection:sectionTag];
    
    // 注册
    [self registerSectionFooterWithClass:footerClassName];
}

#pragma mark - Other

/// 根据 indexPath 获取 cellViewModel
- (HTCommonItemViewModel *)cellViewModelWithIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section >= self.dataCenter.scrollViewData.count) {
        return nil;
    }
    HTCommonSectionViewModel *sectionViewModel = self.dataCenter.scrollViewData[indexPath.section];
    
    if (indexPath.row >= sectionViewModel.cellViewModels.count) {
        return nil;
    }
    HTCommonItemViewModel *cellViewModel = sectionViewModel.cellViewModels[indexPath.row];
    return cellViewModel;
}

/// 配置 view/cell 的数据和回调 action
- (void)configItemView:(UIView <HTCommonViewLayoutProtocol>*)itemView viewModel:(HTCommonItemViewModel *)viewModel indexPath:(NSIndexPath *)indexPath{
    
    // 非 cell 时，indexPath 为 nil
    if (viewModel.viewType != HTCommonItemViewTypeCell) {
        indexPath = nil;
    }
    
    // 记录indexPath
    viewModel.indexPath = indexPath;
    
    // 设置tag
    itemView.tag = viewModel.viewTag;
    
    // 配置数据&回调Action
    if ([itemView respondsToSelector:@selector(configDataModel:indexPath:)]) {
        [itemView configDataModel:viewModel.viewData indexPath:indexPath];
    }
}

#pragma mark - 子类重写

/// 注册cell的方法
- (void)registerCellWithClass:(NSString *)cellClass{
    if([self.ownerView isKindOfClass:[UITableView class]]){
        [(UITableView *)self.ownerView registerClass:NSClassFromString(cellClass) forCellReuseIdentifier:cellClass];
    }else if ([self.ownerView isKindOfClass:[UICollectionView class]]){
        [(UICollectionView *)self.ownerView registerClass:NSClassFromString(cellClass) forCellWithReuseIdentifier:cellClass];
    }
}

/// 注册Header的方法
- (void)registerSectionHeaderWithClass:(NSString *)headerClass{
    if([self.ownerView isKindOfClass:[UITableView class]]){
        [(UITableView *)self.ownerView registerClass:NSClassFromString(headerClass) forHeaderFooterViewReuseIdentifier:headerClass];
    }else if ([self.ownerView isKindOfClass:[UICollectionView class]]){
        [(UICollectionView *)self.ownerView registerClass:NSClassFromString(headerClass) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerClass];
    }
}

/// 注册Footer的方法
- (void)registerSectionFooterWithClass:(NSString *)footerClass{
    if([self.ownerView isKindOfClass:[UITableView class]]){
        [(UITableView *)self.ownerView registerClass:NSClassFromString(footerClass) forHeaderFooterViewReuseIdentifier:footerClass];
    }else if ([self.ownerView isKindOfClass:[UICollectionView class]]){
        [(UICollectionView *)self.ownerView registerClass:NSClassFromString(footerClass) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerClass];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidZoom:)]) {
        [self.scrollViewDelegate scrollViewDidZoom:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.scrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset API_AVAILABLE(ios(5.0)){
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [self.scrollViewDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [self.scrollViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [self.scrollViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return [self.scrollViewDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [self.scrollViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [self.scrollViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return [self.scrollViewDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [self.scrollViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView API_AVAILABLE(ios(11.0), tvos(11.0)){
    if (self.scrollViewDelegate && [self.scrollViewDelegate respondsToSelector:@selector(scrollViewDidChangeAdjustedContentInset:)]) {
        [self.scrollViewDelegate scrollViewDidChangeAdjustedContentInset:scrollView];
    }
}

@end
