//
//  HTDataCenter.m
//  hunter
//
//  Created by zzzz on 2021/11/22.
//  Copyright © 2021 zhuanzhuan. All rights reserved.
//

#import "HTDriverData.h"

@implementation HTDriverData

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollViewData = [NSMutableArray array];
    }
    return self;
}

/// 清除所有的数据
- (void)clearAll{
    [self.scrollViewData removeAllObjects];
}

#pragma mark - Section Methods

/// 添加一个指定tag的section
- (void)addSectionWithTag:(NSInteger)tag{
    
    // 如果已经存在
    if ([self sectionViewModelWithTag:tag] != nil) {
        return;
    }
    
    HTCommonSectionViewModel *sectionViewModel = [[HTCommonSectionViewModel alloc] init];
    sectionViewModel.tag = tag;
    [self.scrollViewData addObject:sectionViewModel];
}

/// 移除指定 tag 的section
- (void)removeSectionWithTag:(NSInteger)tag{
    for (HTCommonSectionViewModel *sectionViewModel in self.scrollViewData) {
        if (sectionViewModel.tag == tag) {
            [self.scrollViewData removeObject:sectionViewModel];
            break;
        }
    }
}

#pragma mark - Cell Methods

/// 添加一个cell
- (void)addCellViewModel:(HTCommonItemViewModel *)cellViewModel toSection:(NSInteger)sectionTag{
    [self addCellViewModels:@[cellViewModel] toSection:sectionTag];
}

/// 添加多个cell
- (void)addCellViewModels:(NSArray<HTCommonItemViewModel *> *)cellViewModels toSection:(NSInteger)sectionTag{
    HTCommonSectionViewModel *sectionViewModel = [self sectionViewModelWithTag:sectionTag];
    [sectionViewModel.cellViewModels addObjectsFromArray:cellViewModels];
}

#pragma mark - Header&Footer Methods

/// 添加一个 sectionViewHeader
- (void)addSectionHeaderViewModel:(HTCommonItemViewModel *)headerViewModel toSection:(NSInteger)sectionTag{
    HTCommonSectionViewModel *sectionViewModel = [self sectionViewModelWithTag:sectionTag];
    sectionViewModel.headerViewModel = headerViewModel;
}

/// 添加一个 sectionViewFooter
- (void)addSectionFooterViewModel:(HTCommonItemViewModel *)footerViewModel toSection:(NSInteger)sectionTag{
    HTCommonSectionViewModel *sectionViewModel = [self sectionViewModelWithTag:sectionTag];
    sectionViewModel.footerViewModel = footerViewModel;
}

#pragma mark - Helper

/// 获取指定 tag 的 setionViewModel
- (HTCommonSectionViewModel *)sectionViewModelWithTag:(NSInteger)tag{
    
    for (HTCommonSectionViewModel *sectionViewModel in self.scrollViewData){
        if (sectionViewModel.tag == tag) {
            return sectionViewModel;
        }
    }
            
    return nil;
}
@end
