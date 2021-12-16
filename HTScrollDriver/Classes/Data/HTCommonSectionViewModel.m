//
//  HTCommonSectionViewModel.m
//  EasyTableView
//
//  Created by 王策 on 2021/11/12.
//

#import "HTCommonSectionViewModel.h"
#import "HTCommonItemViewModel.h"

@implementation HTCommonSectionViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellViewModels = [NSMutableArray array];
    }
    return self;
}

/// 获取总的section高度
- (CGFloat)getSectionHeight{
    CGFloat sectionHeight = 0;
    if (self.headerViewModel) {
        sectionHeight += [self.headerViewModel getViewHeight];
    }
    if (self.footerViewModel) {
        sectionHeight += [self.footerViewModel getViewHeight];
    }
    for (HTCommonItemViewModel *itemViewModel in self.cellViewModels) {
        sectionHeight += [itemViewModel getViewHeight];
    }
    return sectionHeight;
}

@end
