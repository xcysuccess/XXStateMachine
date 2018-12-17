//
//  ZZStateMachineTransition.h
//  StateMachine
//
//  Created by tomxiang on 2018/12/14.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSInteger ZZStateMachineState;
typedef NSInteger ZZStateMachineEvent;
#define ZZStateMachineStateUnknown -1

NS_ASSUME_NONNULL_BEGIN

typedef void(^ZZStateMachineAction)(ZZStateMachineState from, ZZStateMachineState to);


@protocol ZZStateMachineDelegate <NSObject>
- (void)stateDidChangedFrom:(ZZStateMachineState)from To:(ZZStateMachineState)to;
@end


@interface ZZStateMachineTransition : NSObject


/**
 ZZStateMachineState
 */
@property (nonatomic, strong) NSArray<NSNumber *> *from;
@property (nonatomic, assign) ZZStateMachineState to;
@property (nonatomic, assign) ZZStateMachineEvent event;

/**
 状态变化的回调
 */
@property (nonatomic, strong) ZZStateMachineAction action;

- (instancetype)initWithState:(ZZStateMachineState)from
                           to:(ZZStateMachineState)to
                        event:(ZZStateMachineEvent)event
                       action:(ZZStateMachineAction)action;

- (instancetype)initWithAnnotation:(ZZStateMachineEvent)event, ...;

- (BOOL)isValid:(ZZStateMachineTransition *)object;

@end

NS_ASSUME_NONNULL_END
