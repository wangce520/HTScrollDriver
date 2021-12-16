//
//  HTScrollDriver.h
//  hunter
//
//  Created by zzzz on 2021/11/22.
//  Copyright © 2021 zhuanzhuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTDriverData.h"
#import "UIResponder+EventBubble.h"

/**
 对于section\cell等model进行的操作不会触发view的刷新，需要业务手动触发。
 */

/// cell选择的事件名称，viewController中可捕获事件名称去处理
FOUNDATION_EXPORT NSString * _Nullable const HTScrollCellSelectAction;

NS_ASSUME_NONNULL_BEGIN

@interface HTScrollDriver : NSObject <UIScrollViewDelegate>

/// 只读的属性数据
@property (nonatomic, strong) HTDriverData *dataCenter;

/// 持有的scrollView，UITableView或者是UICollectionView
@property (nonatomic, strong) UIScrollView *ownerView;

/// scrollView的代理，如果需要的话
@property (nonatomic, weak) id <UIScrollViewDelegate> scrollViewDelegate;

/// 清除所有的sectionModel数据
- (void)clearAll;

/// 获取整个scrollView的高度，cellHeight + headerHeight + footerHeight
- (CGFloat)ownerViewTotalHeight;

#pragma mark - Section Methods

/// 添加一个指定tag的section
- (void)addSectionWithTag:(NSInteger)tag;

/// 移除指定 tag 的section
- (void)removeSectionWithTag:(NSInteger)tag;

#pragma mark - Cell Methods

/// 添加一个cell，没有tag
- (void)addCell:(NSString *)cellClassName cellData:(id)cellData toSection:(NSInteger)sectionTag;

/// 添加一个带Tag的cell
- (void)addCell:(NSString *)cellClassName cellData:(id)cellData cellTag:(NSInteger)cellTag toSection:(NSInteger)sectionTag;

/// 添加多个cell
- (void)addCell:(NSString *)cellClassName cellDatas:(NSArray *)cellDatas toSection:(NSInteger)sectionTag;

/// 获取指定cell的位置

#define mark - Header&Footer Methods

/// 添加一个 sectionViewHeader
- (void)addSectionHeader:(NSString *)headerClassName headerData:(id)headerData toSection:(NSInteger)sectionTag;

/// 添加一个 sectionViewFooter
- (void)addSectionFooter:(NSString *)footerClassName footerData:(id)footerData toSection:(NSInteger)sectionTag;

#pragma mark - 子类使用

/// 根据 indexPath 获取 cellViewModel
- (HTCommonItemViewModel *)cellViewModelWithIndexPath:(NSIndexPath *)indexPath;

/// 配置 view/cell 的数据和回调 action
- (void)configItemView:(UIView <HTCommonViewLayoutProtocol>*)itemView viewModel:(HTCommonItemViewModel *)viewModel indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
