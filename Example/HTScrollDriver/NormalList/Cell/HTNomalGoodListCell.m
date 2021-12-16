//
//  HTBannerImgViewCell.m
//  HTScrollDriver_Example
//
//  Created by zzzz on 2021/11/25.
//  Copyright © 2021 wangce02. All rights reserved.
//

#import "HTNomalGoodListCell.h"

@interface HTNomalGoodListCell ()

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation HTNomalGoodListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(50);
            make.left.mas_equalTo(15);
            make.centerY.equalTo(self);
        }];
        self.imageV.layer.cornerRadius = 4;
        self.imageV.layer.masksToBounds = YES;
        
        self.titleLab = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.imageV.mas_right).offset(15);
        }];
    }
    return self;
}

#pragma mark - HTCommonViewLayoutProtocol

+ (CGSize)viewSizeWithDataModel:(id)dataModel{
    return CGSizeMake(0, 70);
}

// 配置数据
- (void)configDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    [self.imageV yy_setImageWithURL:[NSURL URLWithString:dataModel] placeholder:nil];
    self.titleLab.text = [NSString stringWithFormat:@"第%ld个商品",indexPath.row];
}

@end

