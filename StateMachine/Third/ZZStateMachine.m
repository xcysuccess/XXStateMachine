//
//  ZZStateMachine.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/17.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "ZZStateMachine.h"
#import "ZZMacro.h"
#import "ZZNBAGame.h"
#import <objc/runtime.h>
#import "YYKit.h"

@interface ZZStateMachine()
{
    NSMutableArray<ZZStateMachineTransition *> *_transitions;
    NSMutableDictionary<NSNumber *, NSHashTable<ZZStateMachineTransition *> *> *_eventMap;
}
@end


@implementation ZZStateMachine

- (instancetype)init {
    return [self initWithInitialState:ZZStateMachineStateUnknown];
}

- (instancetype)initWithInitialState:(ZZStateMachineState)initialState {
    return [self initWithInitialState:initialState delegate:nil];
}

- (instancetype)initWithInitialState:(ZZStateMachineState)initialState delegate:(id<ZZStateMachineDelegate>)delegate {
    self = [super init];
    if (self) {
        _transitions = [[NSMutableArray alloc] init];
        _eventMap = [[NSMutableDictionary alloc] init];
        _currentState = initialState;
        _delegate = delegate;
        
        [self p_transitionAnnotation];
    }
    return self;
}


- (void)addTransition:(ZZStateMachineTransition *)transition {
    @synchronized (self) {
        [_transitions addObject:transition];
        if (![_eventMap containsObjectForKey:@(transition.event)]) {
            [_eventMap setObject:[NSHashTable weakObjectsHashTable] forKey:@(transition.event)];
        }
        for (ZZStateMachineTransition *existTransition in [_eventMap objectForKey:@(transition.event)]) {
            NSAssert([existTransition isValid:transition], @"添加状态转移冲突，from状态存在交集");
            //            QG_Error(MODULE_STATEMACHINE, @"添加状态转移冲突，from状态存在交集");
        }
        [[_eventMap objectForKey:@(transition.event)] addObject:transition];
    }
}

- (void)sendEvent:(ZZStateMachineEvent)event {
    @synchronized (self) {
        NSHashTable<ZZStateMachineTransition *> *transitions = [_eventMap objectForKey:@(event)];
        if (!transitions) {
            //            QG_Error(MODULE_STATEMACHINE, @"未找到event:%@对应的transaction", @(event));
            return;
        }
        for (ZZStateMachineTransition *transition in transitions) {
            for (NSNumber *from in transition.from) {
                if (from.integerValue == self.currentState) {
                    //                    QG_Event(MODULE_STATEMACHINE, @"状态转移 event:%@ current state:%@ from:%@ -> to:%@", @(event), @(self.currentState), from, @(transition.to));
                    self.currentState = transition.to;
                    if (transition.action) {
                        transition.action(from.integerValue, transition.to);
                    }
                    return;
                }
            }
        }
    }
}
- (void)setCurrentState:(ZZStateMachineState)newState {
    if (_currentState == newState) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(stateDidChangedFrom:To:)]) {
        [self.delegate stateDidChangedFrom:_currentState To:newState];
    }
    
    _currentState = newState;
}

- (void)p_transitionAnnotation {
    Class clz = [self.delegate class];
    uint methodCount = 0;
    Method *methods = class_copyMethodList(clz, &methodCount);
    
    for (uint i = 0; i < methodCount; i++) {
        Method method = methods[i];
        NSString *name = [NSString stringWithCString:sel_getName(method_getName(method)) encoding:NSASCIIStringEncoding];
        if ([name hasPrefix:@"__qg_sm_add_transition"]) {
            //如果是一条注解
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            ZZStateMachineTransition *trans = [self.delegate performSelector:method_getName(method)];
            NSAssert(i+1 < methodCount, @"注解错误：注解后未找到方法");
            //            QG_Error(MODULE_STATEMACHINE, @"注解错误：注解后未找到方法");
            SEL action = method_getName(methods[i+1]);
            __weak typeof(self) weakSelf = self;
            trans.action = ^(ZZStateMachineState from, ZZStateMachineState to) {
                [weakSelf.delegate performSelector:action];
            };
            [self addTransition:trans];
#pragma clang diagnostic pop
        }
    }
    free(methods);
}


@end
