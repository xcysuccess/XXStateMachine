//
//  YYNBAGame.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/14.
//  Copyright © 2018年 tomxiang. All rights reserved.

#import "YYNBAGame.h"
#import "TransitionKit.h"

DEFINE_ENUM(YY_FSMState_Type,_YY_FSMState_Type)
DEFINE_ENUM(YY_FSMEvent_Type,_YY_FSMEvent_Type)

@interface YYNBAGame()
@property(nonatomic,strong) TKStateMachine *stateMachine;
@end

@implementation YYNBAGame

- (void)setupStateMachine {
    self.stateMachine = [[TKStateMachine alloc] init];
//    __weak typeof(self) weakSelf = self;
    
    //初始化状态,买票
    TKState *stateBuyTicket = [TKState stateWithName:NSStringFromYY_FSMState_Type(YYStateBuyTicket)];
    [stateBuyTicket setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        NSLog(@"买票->enter");
    }];
    [stateBuyTicket setDidExitStateBlock:^(TKState *state, TKTransition *transition) {
        NSLog(@"买票->exit");
    }];
    
    //进场状态
    TKState *stateEnterGame = [TKState stateWithName:NSStringFromYY_FSMState_Type(YYStateEnterGame)];
    [stateEnterGame setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        NSLog(@"进场->enter");
    }];
    [stateEnterGame setDidExitStateBlock:^(TKState *state, TKTransition *transition) {
        NSLog(@"进场->exit");
    }];
    
    //看比赛
    TKState *stateWatchGame = [TKState stateWithName:NSStringFromYY_FSMState_Type(YYStateWatchGame)];
    [stateWatchGame setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        NSLog(@"看比赛->enter");
    }];
    
    //退场
    TKState *stateQuitGame = [TKState stateWithName:NSStringFromYY_FSMState_Type(YYStateQuitGame)];
    [stateQuitGame setDidEnterStateBlock:^(TKState *state, TKTransition *transition) {
        NSLog(@"退场->enter");
    }];
    
    [self.stateMachine addStates:@[stateBuyTicket,stateEnterGame,stateWatchGame,stateQuitGame]];
    [self.stateMachine setInitialState:stateBuyTicket];
    
    //关联事件
    TKEvent *buyTicketEvent = [TKEvent eventWithName:NSStringFromYY_FSMEvent_Type(YYEventBuyTicket) transitioningFromStates:@[stateBuyTicket] toState:stateEnterGame];
    TKEvent *enterGameEvent = [TKEvent eventWithName:NSStringFromYY_FSMEvent_Type(YYEventEnterGame) transitioningFromStates:@[stateEnterGame] toState:stateWatchGame];
    TKEvent *watchGameEvent = [TKEvent eventWithName:NSStringFromYY_FSMEvent_Type(YYEventWatchGame) transitioningFromStates:@[stateWatchGame] toState:stateEnterGame];
    TKEvent *quitGameEvent = [TKEvent eventWithName:NSStringFromYY_FSMEvent_Type(YYEventQuitGame) transitioningFromStates:@[stateQuitGame] toState:stateQuitGame];
    
    [_stateMachine addEvents:@[buyTicketEvent, enterGameEvent, watchGameEvent, quitGameEvent]];
    
    [_stateMachine activate];
}

- (void)startEvent{
    [self.stateMachine fireEvent:NSStringFromYY_FSMEvent_Type(YYEventBuyTicket) userInfo:nil error:nil];
}


@end
