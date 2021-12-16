//
//  HTCommonCellViewModel.h
//  EasyTableView
//
//  Created by 王策 on 2021/11/12.
//

#import <UIKit/UIKit.h>
#import "HTCommonViewLayoutProtocol.h"

/**
 cell/sectionHeader/sectionFooter 对应的 model
 */

typedef enum : NSUInteger {
    HTCommonItemViewTypeCell,
    HTCommonItemViewTypeSectionHeader,
    HTCommonItemViewTypeSectionFooter,
} HTCommonItemViewType;

NS_ASSUME_NONNULL_BEGIN

@interface HTCommonItemViewModel : NSObject

/// view需要的真实的数据
@property (nonatomic, strong) id viewData;

/// 对应的view类名
@property (nonatomic, copy) NSString *viewClassName;

/// 对应的viewTag
@property (nonatomic, assign) NSInteger viewTag;

/// 所对应的indexPath
@property (nonatomic, strong) NSIndexPath *indexPath;

/// 当前的类型
@property (nonatomic, assign) HTCommonItemViewType viewType;

/// 构造方法
+ (instancetype)itemViewModelWithData:(id)viewData className:(NSString *)viewClassName viewTag:(NSInteger)viewTag viewType:(HTCommonItemViewType)viewType;

/// 获取自己对应的视图高度
- (CGFloat)getViewHeight;

/// 获取自己对应的视图大小
- (CGSize)getViewSize;


@end

NS_ASSUME_NONNULL_END
