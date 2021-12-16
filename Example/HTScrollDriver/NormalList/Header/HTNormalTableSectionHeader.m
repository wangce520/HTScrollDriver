//
//  HTNormalTableSectionHeader.m
//  HTScrollDriver_Example
//
//  Created by zzzz on 2021/11/25.
//  Copyright © 2021 wangce02. All rights reserved.
//

#import "HTNormalTableSectionHeader.h"

@interface HTNormalTableSectionHeader ()

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation HTNormalTableSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
        self.backgroundView.backgroundColor = UIColor.whiteColor;
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)creatSubViews{
    self.titleLab = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark - HTCommonViewLayoutProtocol

+ (CGSize)viewSizeWithDataModel:(id)dataModel{
    return CGSizeMake(0, 50);
}

// 配置数据
- (void)configDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    self.titleLab.text = dataModel;
}

@end
