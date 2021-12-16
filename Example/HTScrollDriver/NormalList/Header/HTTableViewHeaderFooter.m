//
//  HTTableViewHeader.m
//  HTScrollDriver_Example
//
//  Created by zzzz on 2021/11/26.
//  Copyright © 2021 wangce02. All rights reserved.
//

#import "HTTableViewHeaderFooter.h"

@interface HTTableViewHeaderFooter ()

@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) UIButton *controlBtn;

@end

@implementation HTTableViewHeaderFooter

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.textLab = [[UILabel alloc] init];
        [self addSubview:self.textLab];
        self.textLab.textAlignment = NSTextAlignmentCenter;
        [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-15);
        }];
    }
    return self;
}

#pragma mark - HTCommonViewLayoutProtocol

+ (CGSize)viewSizeWithDataModel:(id)dataModel{
    return CGSizeMake(0, 150);
}

// 配置数据
- (void)configDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    // 计算数据
    self.textLab.text = dataModel;
}

@end
