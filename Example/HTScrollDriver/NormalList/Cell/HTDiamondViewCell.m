//
//  HTDiamondViewCell.m
//  HTScrollDriver_Example
//
//  Created by zzzz on 2021/11/25.
//  Copyright © 2021 wangce02. All rights reserved.
//

#import "HTDiamondViewCell.h"

@interface HTDiamondViewCell ()

@property (nonatomic, strong) NSMutableArray *itemArr;

@end

@implementation HTDiamondViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.itemArr = [NSMutableArray array];
    }
    return self;
}

#pragma mark - HTCommonViewLayoutProtocol

+ (CGSize)viewSizeWithDataModel:(id)dataModel{
    return CGSizeMake(0, 100);
}

// 配置数据
- (void)configDataModel:(id)dataModel indexPath:(NSIndexPath *)indexPath{
    [self.itemArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray *array = (NSArray *)dataModel;
    CGFloat itemWidth = SCREEN_WIDTH / array.count;
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict = array[i];
        UIView *view = [self creatItemViewWithTitle:dict[@"title"] image:dict[@"image"]];
        [self.contentView addSubview:view];
        [self.itemArr addObject:view];
        view.frame = CGRectMake(itemWidth * i, 0, itemWidth, 100);
    }
}

- (UIView *)creatItemViewWithTitle:(NSString *)title image:(NSString *)image{
    UIView *view = [[UIView alloc] init];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:11];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.bottom.mas_equalTo(-15);
    }];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [view addSubview:imageV];
    [imageV yy_setImageWithURL:[NSURL URLWithString:image] placeholder:nil];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.mas_equalTo(15);
        make.height.width.mas_equalTo(45);
    }];
    return view;
}


@end
