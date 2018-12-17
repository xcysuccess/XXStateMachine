//
//  ZZStateMachine.h
//  StateMachine
//
//  Created by tomxiang on 2018/12/17.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZStateMachineTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZZStateMachine : NSObject

@property (nonatomic, assign, readonly) ZZStateMachineState currentState;

/**
 如果需要使用注解方式定义transition，则必须设置delegate
 */
@property (nonatomic, weak) id<ZZStateMachineDelegate> delegate;

- (instancetype)init;
- (instancetype)initWithInitialState:(ZZStateMachineState)initialState;
- (instancetype)initWithInitialState:(ZZStateMachineState)initialState delegate:(id<ZZStateMachineDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (void)sendEvent:(ZZStateMachineEvent)event;
- (void)addTransition:(ZZStateMachineTransition *)transition;

@end

NS_ASSUME_NONNULL_END
