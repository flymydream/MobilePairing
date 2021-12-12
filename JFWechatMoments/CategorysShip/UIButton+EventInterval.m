//
//  UIButton+EventInterval.m
//  Driver
//
//  Created by caesar on 2020/4/2.
//  Copyright © 2020 caesar. All rights reserved.
//

#import "UIButton+EventInterval.h"
#import <objc/runtime.h>
static NSUInteger const indicatorViewSize = 20;
static NSUInteger const indicatorViewTag  = 999;

@interface UIButton()


@end


@implementation UIButton (EventInterval)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(mySendAction:to:forEvent:);
        Method methodA =   class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
       BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            method_exchangeImplementations(methodA, methodB);
        }
    });
}
- (NSTimeInterval)timeInterval
{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
    objc_setAssociatedObject(self, @selector(timeInterval), @(timeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (void)resetState{

  [self setIsIgnoreEvent:NO];
}

- (void)mySendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    // 如果是点击相机拍照按钮事件则不判断是否连续点击
    //点击拍照：_handleShutterButtonPressed: 切换摄像头：_handleFlipButtonTouchDown:
    if ([NSStringFromSelector(action) isEqualToString:@"_handleShutterButtonPressed:"] || [NSStringFromSelector(action) isEqualToString:@"_handleFlipButtonTouchDown:"]) {
        [self mySendAction:action to:target forEvent:event];
        return;
    }
    if([NSStringFromClass(self.superclass)isEqualToString:@"UIButton"] || [NSStringFromClass(self.class)isEqualToString:@"UIButton"]) {
        
       self.timeInterval = self.timeInterval == 0 ? defaultInterval:self.timeInterval;
       if(self.isIgnoreEvent){
         return;
       }else if(self.timeInterval > 0 ){
        
         [self performSelector:@selector(resetState) withObject:nil afterDelay:self.timeInterval];
       }
   }
    //此处methodA和methodB方法IMP互换了，实际上执行sendAction；所以不会死循环
     self.isIgnoreEvent = YES;
    [self mySendAction:action to:target forEvent:event];
}
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)startButtonActivityIndicatorView
{
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:1];
//    self.enabled = NO;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame = CGRectMake(self.bounds.size.width/2 - indicatorViewSize/2, self.bounds.size.height/2 - indicatorViewSize/2, indicatorViewSize, indicatorViewSize);
    indicatorView.tag = indicatorViewTag;
    indicatorView.hidesWhenStopped = YES;
    [self addSubview:indicatorView];
    [indicatorView startAnimating];
}

- (void)endButtonActivityIndicatorView
{
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)[self viewWithTag:indicatorViewTag];
    [indicatorView removeFromSuperview];
//    self.enabled = YES;
    self.backgroundColor = [self.backgroundColor colorWithAlphaComponent:0.4*(5/2)];
}

@end
