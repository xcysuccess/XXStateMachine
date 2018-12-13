//
//  XXNBAGame+FSM.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/13.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "XXNBAGame+FSM.h"

#define FSM_FUN(statusA, statusB) FSM_##statusA##_##statusB

@implementation XXNBAGame (FSM)

- (void)FSM_FUN(StateBuyTicket, StateEnterGame){
    [self testAction1];
}

- (void)FSM_FUN(StateEnterGame, StateWatchGame){
    [self testAction2];
}

- (void)FSM_FUN(StateWatchGame, StateQuitGame){
    [self testAction3];
}



@end
