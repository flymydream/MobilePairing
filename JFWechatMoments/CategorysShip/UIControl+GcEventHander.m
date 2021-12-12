//
//  UIControl+GcEventHander.m
//  Shipper
//
//  Created by caesar on 2020/1/9.
//  Copyright © 2020 huodada. All rights reserved.
//

#import "UIControl+GcEventHander.h"

#define IN_MASK(a, b) ((a & b) == b)

@implementation UIControl (GcEventHander)

static NSMutableDictionary *__controlActions;


#pragma mark - Public Methods

- (void)touchDown:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchDown selector:@selector(touchedDown:forEvent:)];
}

- (void)touchDownRepeat:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchDownRepeat selector:@selector(touchedDownRepeat:forEvent:)];
}

- (void)touchDragInside:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchDragInside selector:@selector(touchedDragInside:forEvent:)];
}

- (void)touchDragOutside:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchDragOutside selector:@selector(touchedDragOutside:forEvent:)];
}

- (void)touchDragEnter:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchDragEnter selector:@selector(touchedDragEnter:forEvent:)];
}

- (void)touchDragExit:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchDragExit selector:@selector(touchedDragExit:forEvent:)];
}

- (void)touchUpInside:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchUpInside selector:@selector(touchedUpInside:forEvent:)];
}

- (void)touchUpOutside:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchUpOutside selector:@selector(touchedUpOutside:forEvent:)];
}

- (void)touchCancel:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventTouchCancel selector:@selector(touchedCancel:forEvent:)];
}

- (void)valueChanged:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventValueChanged selector:@selector(touchedValueChanged:forEvent:)];
}

- (void)editingDidBegin:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventEditingDidBegin selector:@selector(touchedEditingDidBegin:forEvent:)];
}

- (void)editingChanged:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventEditingChanged selector:@selector(touchedEditingChanged:forEvent:)];
}

- (void)editingDidEnd:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventEditingDidEnd selector:@selector(touchedEditingDidEnd:forEvent:)];
}

- (void)editingDidEndOnExit:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventEditingDidEndOnExit selector:@selector(touchedEditingDidEndOnExit:forEvent:)];
}

- (void)allTouchEvents:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventAllTouchEvents selector:@selector(touchedAllTouchEvents:forEvent:)];
}

- (void)allEditingEvents:(GcEventHander)block
{
    [self addblock:block forEvent:UIControlEventAllEditingEvents selector:@selector(touchedAllEditingEvents:forEvent:)];
}

- (void)removeBlocksForControlEvents:(UIControlEvents)eventTypes;
{
    NSMutableArray *events = [__controlActions objectForKey:[self objectString]];
    for (NSDictionary *eventDict in [events copy]) {
        UIControlEvents controlEvent = [[eventDict objectForKey:@"Event"] intValue];
        if (IN_MASK(eventTypes, controlEvent)) {
            [events removeObject:eventDict];
        }
    }
}

#pragma mark - Private Methods

- (void)touchedDown:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchDown sender:sender event:event];
}

- (void)touchedDownRepeat:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchDownRepeat sender:sender event:event];
}

- (void)touchedDragInside:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchDragInside sender:sender event:event];
}

- (void)touchedDragOutside:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchDragOutside sender:sender event:event];
}

- (void)touchedDragEnter:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchDragEnter sender:sender event:event];
}

- (void)touchedDragExit:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchDragExit sender:sender event:event];
}

- (void)touchedUpInside:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchUpInside sender:sender event:event];
}

- (void)touchedUpOutside:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchUpOutside sender:sender event:event];
}

- (void)touchedCancel:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventTouchCancel sender:sender event:event];
}

- (void)touchedValueChanged:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventValueChanged sender:sender event:event];
}

- (void)touchedEditingDidBegin:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventEditingDidBegin sender:sender event:event];
}

- (void)touchedEditingChanged:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventEditingChanged sender:sender event:event];
}

- (void)touchedEditingDidEnd:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventEditingDidEnd sender:sender event:event];
}

- (void)touchedEditingDidEndOnExit:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventEditingDidEndOnExit sender:sender event:event];
}

- (void)touchedAllTouchEvents:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventAllTouchEvents sender:sender event:event];
}

- (void)touchedAllEditingEvents:(id)sender forEvent:(UIEvent *)event
{
    [self callBlocksForEventType:UIControlEventAllEditingEvents sender:sender event:event];
}




#pragma mark - Private Util Methods

- (void)addblock:(GcEventHander)block forEvent:(UIControlEvents)event selector:(SEL)selector
{
    if (!__controlActions) __controlActions = [NSMutableDictionary dictionary];
    
    NSMutableArray *events = [__controlActions objectForKey:[self objectString]];
    if (!events) events = [NSMutableArray array];
    
    NSDictionary *eventDict = @{ @"Block" : [block copy], @"Event" : @(event) };
    [events addObject:eventDict];
    [__controlActions setObject:events forKey:[self objectString]];
    
    [self addTarget:self action:selector forControlEvents:event];
}

- (void)callBlocksForEventType:(UIControlEvents)eventTypes sender:(id)sender event:(UIEvent *)event
{
    NSArray *events = [__controlActions objectForKey:[self objectString]];
    for (NSDictionary *eventDict in events) {
        UIControlEvents controlEvent = [[eventDict objectForKey:@"Event"] intValue];
        if (IN_MASK(eventTypes, controlEvent)) {
            GcEventHander block = [eventDict objectForKey:@"Block"];
            block(event);
        }
    }
}

- (NSString *)objectString
{
    NSString *desc = [self description];
    NSArray *parts = [desc componentsSeparatedByString:@";"];
    return [parts objectAtIndex:0];
}

@end
