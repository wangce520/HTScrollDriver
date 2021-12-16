//
//  UIResponder+EventBubble.m
//  EasyTableView
//
//  Created by 王策 on 2021/11/16.
//

#import "UIResponder+EventBubble.h"
#import <objc/message.h>

@implementation UIResponder (EventBubble)

- (void)eventBubbleWithName:(NSString *)name params:(NSDictionary *)params{
    
    if (!self.nextResponder) {
        return;
    }
    
    [self.nextResponder eventBubbleWithName:name params:params];
}

- (void)handleEventWithName:(NSString *)name params:(NSDictionary *)params{
    
    if (!self.eventBubbleHandlers.count || !self.eventBubbleHandlers[name]) {
        NSLog(@"还没有指定处理事件的 actionHandlers");
        return;
    }
    
    // 方法执行
    NSString *actionName = self.eventBubbleHandlers[name];
    SEL sel = NSSelectorFromString(actionName);
    IMP imp = [self methodForSelector:sel];
    void (*func)(id, SEL, NSDictionary *) = (void *)imp;
    func(self, sel, params);
}

- (void)setEventBubbleHandlers:(NSDictionary *)eventBubbleHandlers{
    
    if (!eventBubbleHandlers) {
        return;
    }
    
    objc_setAssociatedObject(self,  "__eventBubbleHandlers", eventBubbleHandlers, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)eventBubbleHandlers{
    return objc_getAssociatedObject(self, "__eventBubbleHandlers");
}

@end
