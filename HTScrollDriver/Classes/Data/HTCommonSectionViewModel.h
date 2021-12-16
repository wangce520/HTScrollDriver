//
//  HTCommonSectionViewModel.h
//  EasyTableView
//
//  Created by 王策 on 2021/11/12.
//

#import <Foundation/Foundation.h>


/**
 section 对应的 viewModel
 */

@class HTCommonItemViewModel;
NS_ASSUME_NONNULL_BEGIN

@interface HTCommonSectionViewModel : NSObject

/// 存储 cell 对应的 model 数组
@property (nonatomic, strong) NSMutableArray <HTCommonItemViewModel *>*cellViewModels;

/// 对应的 tag
@property (nonatomic, assign) NSInteger tag;

/// 对应的HeaderViewModel
@property (nonatomic, strong) HTCommonItemViewModel *headerViewModel;

/// 对应的FooterViewModel
@property (nonatomic, strong) HTCommonItemViewModel *footerViewModel;

/// 获取总的section高度
- (CGFloat)getSectionHeight;

@end

NS_ASSUME_NONNULL_END
