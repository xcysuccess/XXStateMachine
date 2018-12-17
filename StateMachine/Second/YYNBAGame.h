//
//  YYNBAGame.h
//  StateMachine
//
//  Created by tomxiang on 2018/12/14.
//  Copyright © 2018年 tomxiang. All rights reserved.
//  https://www.jianshu.com/p/4838a9ebf266
//  https://github.com/blakewatters/TransitionKit

#import <Foundation/Foundation.h>
#import "XXEnumMacro.h"

//状态枚举 - 买票. 进场. 看比赛 . 退场
#define _YY_FSMState_Type(QQ) \
QQ(YYStateBuyTicket, = 0x01) \
QQ(YYStateEnterGame, = 0x02) \
QQ(YYStateWatchGame, = 0x03) \
QQ(YYStateQuitGame, = 0x04)
DECLARE_ENUM(YY_FSMState_Type, _YY_FSMState_Type)

//事件枚举 - 买票. 进场. 看比赛 . 退场
#define _YY_FSMEvent_Type(QQ) \
QQ(YYEventBuyTicket, = 0x01) \
QQ(YYEventEnterGame, = 0x02) \
QQ(YYEventWatchGame, = 0x03) \
QQ(YYEventQuitGame, = 0x04)
DECLARE_ENUM(YY_FSMEvent_Type, _YY_FSMEvent_Type)

NS_ASSUME_NONNULL_BEGIN

@interface YYNBAGame : NSObject

- (void)setupStateMachine;

- (void)startEvent;

@end

NS_ASSUME_NONNULL_END
