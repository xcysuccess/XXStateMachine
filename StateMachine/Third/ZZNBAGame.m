//
//  ZZNBAGame.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/14.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "ZZNBAGame.h"
#import "ZZStateMachine.h"
#import "ZZMacro.h"

@interface ZZNBAGame()<ZZStateMachineDelegate>
@property (nonatomic, strong) ZZStateMachine *zzStateMachine;
@end

@implementation ZZNBAGame

- (instancetype)init{
    if(self = [super init]){
        _zzStateMachine = [[ZZStateMachine alloc] initWithInitialState:ZZStateBuyTicket delegate:self];
    }
    return self;
}

- (void)startZZState{
    [_zzStateMachine sendEvent:ZZStateBuyTicket];
}

- (void)stateDidChangedFrom:(ZZStateMachineState)from To:(ZZStateMachineState)to{
    NSLog(@"状态变化!");
    NSLog(@"(From,To)->(%zd,%zd)",from,to);
}

@transition(ZZEventBuyTicket,@[@(ZZStateBuyTicket)],ZZStateEnterGame){
    NSLog(@"正在买票,准备进场");
}

@end
