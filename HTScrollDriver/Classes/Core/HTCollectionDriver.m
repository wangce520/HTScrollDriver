//
//  HTCollectionDriver.m
//  hunter
//
//  Created by zzzz on 2021/11/22.
//  Copyright © 2021 zhuanzhuan. All rights reserved.
//

#import "HTCollectionDriver.h"
#import "HTScrollDef.h"
#import "HTDriverData.h"

@interface HTCollectionDriver ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@end

@implementation HTCollectionDriver

- (void)setOwnerView:(UIScrollView *)ownerView{
    [super setOwnerView:ownerView];
    UICollectionView *collectionView = (UICollectionView *)ownerView;
    collectionView.delegate = self;
    collectionView.dataSource = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataCenter.scrollViewData.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    HTCommonSectionViewModel *sectionViewModel = self.dataCenter.scrollViewData[section];
    return sectionViewModel.cellViewModels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HTCommonItemViewModel *cellViewModel = [self cellViewModelWithIndexPath:indexPath];
    UICollectionViewCell <HTCommonViewLayoutProtocol>*cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellViewModel.viewClassName forIndexPath:indexPath];
    // 配置数据
    [self configItemView:cell viewModel:cellViewModel indexPath:indexPath];
    return cell;
}

#pragma mark - UICollectioViewDelegate

/// itemSize
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HTCommonItemViewModel *cellViewModel = [self cellViewModelWithIndexPath:indexPath];
    if(self.ownerView.superview){ // 事件冒泡
        [self.ownerView.superview eventBubbleWithName:HTScrollCellSelectAction params:@{
            @"model":cellViewModel.viewData,
            @"indexPath":indexPath
        }];
    }
}

#pragma mark - UICollectionViewFlowDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    HTCommonItemViewModel *cellViewModel = [self cellViewModelWithIndexPath:indexPath];
    return [self viewSizeWithItemViewClass:NSClassFromString(cellViewModel.viewClassName) viewModel:cellViewModel];
}
    
#pragma mark - Helper

/// 获取 itemView 的高度
- (CGSize)viewSizeWithItemViewClass:(Class <HTCommonViewLayoutProtocol>)class viewModel:(HTCommonItemViewModel *)viewModel{
    CGSize viewSize = CGSizeMake(0, 0);
    if (class && [class respondsToSelector:@selector(viewSizeWithDataModel:)]) {
        viewSize = [class viewSizeWithDataModel:viewModel.viewData];
    }
    return viewSize;
}

@end
