//
//  XXNBAGame.h
//  StateMachine
//
//  Created by tomxiang on 2018/12/13.
//  Copyright © 2018年 tomxiang. All rights reserved.
//  https://stackoverflow.com/questions/147267/easy-way-to-use-variables-of-enum-types-as-string-in-c/202511#202511
//  https://www.jianshu.com/p/5eb45c64f3e3


#import <Foundation/Foundation.h>
#import "XXEnumMacro.h"

//状态枚举 - 买票. 进场. 看比赛 . 退场
#define _EN_FSMState_Type(XX) \
XX(StateBuyTicket, = 0x01) \
XX(StateEnterGame, = 0x02) \
XX(StateWatchGame, = 0x03) \
XX(StateQuitGame, = 0x04)
DECLARE_ENUM(EN_FSMState_Type, _EN_FSMState_Type)

//事件枚举 - 买票. 进场. 看比赛 . 退场
#define _EN_FSMEvent_Type(XX) \
XX(EventBuyTicket, = 0x01) \
XX(EventEnterGame, = 0x02) \
XX(EventWatchGame, = 0x03) \
XX(EventQuitGame, = 0x04)
DECLARE_ENUM(EN_FSMEvent_Type, _EN_FSMEvent_Type)

NS_ASSUME_NONNULL_BEGIN

@interface XXNBAGame : NSObject

/**
 状态机当前的状态
 */
@property(nonatomic, assign)EN_FSMState_Type state;

/**
 条件事件触发处理
 
 @param event 事件来源
 */
- (void)onHandleEvent:(EN_FSMEvent_Type) event;

- (void)testAction1;

- (void)testAction2;

- (void)testAction3;

@end

NS_ASSUME_NONNULL_END
