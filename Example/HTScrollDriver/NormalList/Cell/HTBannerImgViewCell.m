//
//  HTBannerImgViewCell.m
//  HTScrollDriver_Example
//
//  Created by zzzz on 2021/11/25.
//  Copyright © 2021 wangce02. All rights reserved.
//

#import "HTBannerImgViewCell.h"

@interface HTBannerImgViewCell ()

@property (nonatomic, strong) UIImageView *imageV;

@end

@implementation HTBannerImgViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        self.imageV.layer.cornerRadius = 10;
        self.imageV.layer.masksToBounds = YES;
    }
    return self;
}

#pragma mark - HTCommonViewLayoutProtocol

+ (CGSize)viewSizeWithDataModel:(id)dataModel{
    return CGSizeMake(0, 200);
}

// 配置数据
- (void)configDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    [self.imageV yy_setImageWithURL:[NSURL URLWithString:dataModel] placeholder:nil];
}

@end
