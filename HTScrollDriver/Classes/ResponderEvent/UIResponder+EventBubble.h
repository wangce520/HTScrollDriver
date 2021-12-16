//
//  UIResponder+EventBubble.h
//  EasyTableView
//
//  Created by 王策 on 2021/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
  使用方法：
  1. 在controller 或者要捕获方法的视图中，配置eventBubbleHandlers，key值为约定好的事件名称，value为已经实现方法的名称，比如：
  ```
  self.eventBubbleHandlers = @{@"eventName":NSStringFromSelector(test:)};
  ```
 
  然后，重写eventBubbleWithName:params:方法:
  ```
  - (void)eventBubbleWithName:(NSString *)name params:(NSDictionary *)params{
     [self handleEventWithName:name params:params];
     
     // 如果不想事件继续传递，下面的代码可不写
     [self.nextResponder eventBubbleWithName:name params:params];
  }
  ```
 
  2. 在要触发事件的子view中，去将事件冒泡
  ```
  [self eventBubbleWithName:@"eventName" params:@{@"value":@"1"}];
  ```
 */

@interface UIResponder (EventBubble)

/// 事件处理 {"约定的事件 id": "已经实现的方法 selName，只允许带一个参数"}
@property (nonatomic, copy) NSDictionary *eventBubbleHandlers;

/// 事件向上传递
- (void)eventBubbleWithName:(NSString *)name params:(NSDictionary *)params;

/// 使用预先配置的 actionHandlers 处理事件
- (void)handleEventWithName:(NSString *)name params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
