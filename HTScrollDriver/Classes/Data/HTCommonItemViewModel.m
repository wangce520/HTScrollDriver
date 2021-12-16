//
//  HTCommonCellViewModel.m
//  EasyTableView
//
//  Created by 王策 on 2021/11/12.
//

#import "HTCommonItemViewModel.h"

@implementation HTCommonItemViewModel

+ (instancetype)itemViewModelWithData:(id)viewData className:(NSString *)viewClassName viewTag:(NSInteger)viewTag viewType:(HTCommonItemViewType)viewType{
    HTCommonItemViewModel *viewModel = [[HTCommonItemViewModel alloc] init];
    viewModel.viewData = viewData;
    viewModel.viewClassName = viewClassName;
    viewModel.viewTag = viewTag;
    viewModel.viewType = viewType;
    return viewModel;
}

/// 获取自己对应的视图高度
- (CGFloat)getViewHeight{
    return [self getViewSize].height;
}

/// 获取自己对应的视图大小
- (CGSize)getViewSize{
    Class class = NSClassFromString(self.viewClassName);
    CGSize viewSize = CGSizeZero;
    if (class && [class respondsToSelector:@selector(viewSizeWithDataModel:)]) {
        viewSize = [class viewSizeWithDataModel:self.viewData];
    }
    return viewSize;
}

@end
