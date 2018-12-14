//
//  XXNBAGame.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/13.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "XXNBAGame.h"

DEFINE_ENUM(XX_FSMState_Type,_XX_FSMState_Type)
DEFINE_ENUM(XX_FSMEvent_Type,_XX_FSMEvent_Type)

@implementation XXNBAGame

-(instancetype)init{
    if(self = [super init]){
        _state = XXStateBuyTicket;
    }
    return self;
}

-(void)setState:(XX_FSMState_Type)newstate{

    //1.根据Enum可以转字符串的能力,然后动态去调用+category的方法
    NSString *FSMFunctionName = [NSString stringWithFormat:@"FSM_%@_%@", NSStringFromXX_FSMState_Type(_state),NSStringFromXX_FSMState_Type(newstate)];
    
    //2.获取Sel
    SEL sel = NSSelectorFromString(FSMFunctionName);
    
    if([self respondsToSelector:sel]){
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:sel];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:sel];
        [invocation invoke];
    }else{
        NSLog(@"not respondsToSelector %@",FSMFunctionName);
    }
    _state = newstate;
}

- (void)testAction1{
    NSLog(@"买票->进场");
}

- (void)testAction2{
    NSLog(@"进场->看比赛");
}

- (void)testAction3{
    NSLog(@"看比赛->退出比赛");
}

-(void)onHandleEvent:(XX_FSMEvent_Type)event{
    switch (_state) {
        case XXStateBuyTicket:{
            switch (event) {
                case XXEventBuyTicket:{
                    self.state = XXStateEnterGame;
                }
                    break;
                default:{
                    NSLog(@"动作不被允许,买完票只能进场!");
                }
                    break;
            }
        }
            break;
        case XXStateEnterGame:{
            switch (event) {
                case XXEventEnterGame:{
                    self.state = XXStateWatchGame;
                }
                    break;
                default:{
                    NSLog(@"动作不被允许,进场完了只能观看比赛!");
                }
                    break;
            }
        }
            break;
        case XXStateWatchGame:{
            switch (event) {
                case XXEventWatchGame:{
                    self.state = XXStateQuitGame;
                }
                    break;
                default:{
                    NSLog(@"动作不被允许,看完比赛只能退场!");
                }
                    break;
            }
        }
            break;
        case XXStateQuitGame:{
            NSLog(@"退出之后不允许做任何事情!");
        }
            break;
        default:
            break;
    }
    
}
@end
