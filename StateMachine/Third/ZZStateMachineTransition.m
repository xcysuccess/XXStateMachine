//
//  ZZStateMachineTransition.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/14.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "ZZStateMachineTransition.h"
#import "ZZNBAGame.h"
#import "ZZMacro.h"

@implementation ZZStateMachineTransition

- (instancetype)initWithState:(ZZStateMachineState)from
                           to:(ZZStateMachineState)to
                        event:(ZZStateMachineEvent)event
                       action:(ZZStateMachineAction)action{
    return [self initWithStates:@[@(from)] event:event to:to action:action];
}

- (instancetype)initWithStates:(NSArray<NSNumber *> *)from
                         event:(ZZStateMachineEvent)event
                            to:(ZZStateMachineState)to
                        action:(ZZStateMachineAction)action {
    self = [super init];
    if (self) {
        _from = from;
        _to = to;
        _event = event;
        _action = action;
    }
    return self;
}

- (instancetype)initWithAnnotation:(ZZStateMachineEvent)event, ...{
    va_list argList;
    va_start(argList, event);
    NSArray<NSNumber *> *from = va_arg(argList, NSArray<NSNumber *> *);
    ZZStateMachineState to = va_arg(argList, ZZStateMachineState);
    va_end(argList);
    return [self initWithStates:from event:event to:to action:nil];
}

- (BOOL)isValid:(ZZStateMachineTransition *)object {
    if (self.event == object.event) {
        NSSet *set1 = [NSSet setWithArray:self.from];
        NSSet *set2 = [NSSet setWithArray:object.from];
        BOOL isIntersect = [set1 intersectsSet:set2];
        if (isIntersect) {
            return NO;
        }
    }
    return YES;
}
@end
