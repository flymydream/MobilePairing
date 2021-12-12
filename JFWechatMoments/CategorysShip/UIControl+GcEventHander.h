//
//  UIControl+GcEventHander.h
//  Shipper
//
//  Created by caesar on 2020/1/9.
//  Copyright © 2020 huodada. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^GcEventHander)(UIEvent *event);
@interface UIControl (GcEventHander)

- (void)touchDown:(GcEventHander)block;
- (void)touchDownRepeat:(GcEventHander)block;
- (void)touchDragInside:(GcEventHander)block;
- (void)touchDragOutside:(GcEventHander)block;
- (void)touchDragEnter:(GcEventHander)block;
- (void)touchDragExit:(GcEventHander)block;
- (void)touchUpInside:(GcEventHander)block;
- (void)touchUpOutside:(GcEventHander)block;
- (void)touchCancel:(GcEventHander)block;
- (void)valueChanged:(GcEventHander)block;
- (void)editingDidBegin:(GcEventHander)block;
- (void)editingChanged:(GcEventHander)block;
- (void)editingDidEnd:(GcEventHander)block;
- (void)editingDidEndOnExit:(GcEventHander)block;
- (void)allTouchEvents:(GcEventHander)block;
- (void)allEditingEvents:(GcEventHander)block;
- (void)removeBlocksForControlEvents:(UIControlEvents)events;
@end

NS_ASSUME_NONNULL_END
