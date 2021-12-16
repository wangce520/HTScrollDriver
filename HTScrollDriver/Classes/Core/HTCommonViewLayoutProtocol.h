//
//  HTCommonViewLayoutProtocol.h
//  EasyTableView
//
//  Created by 王策 on 2021/11/13.
//

#import <Foundation/Foundation.h>


/// cell 或者 view 继承的协议
@protocol HTCommonViewLayoutProtocol <NSObject>

/// 配置数据
- (void)configDataModel:(id _Nullable)dataModel indexPath:(NSIndexPath * _Nullable)indexPath;

/// 返回cell的Size，UITableViewCell中，宽度可任意
+ (CGSize)viewSizeWithDataModel:(id _Nullable)dataModel;

@end

