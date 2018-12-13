//
//  XXNBAGame.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/13.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "XXNBAGame.h"

DEFINE_ENUM(EN_FSMState_Type,_EN_FSMState_Type)
DEFINE_ENUM(EN_FSMEvent_Type,_EN_FSMEvent_Type)

@implementation XXNBAGame

-(instancetype)init{
    if(self = [super init]){
        _state = StateBuyTicket;
    }
    return self;
}

-(void)setState:(EN_FSMState_Type)newstate{

    //1.根据Enum可以转字符串的能力,然后动态去调用+category的方法
    NSString *FSMFunctionName = [NSString stringWithFormat:@"FSM_%@_%@", NSStringFromEN_FSMState_Type(_state),NSStringFromEN_FSMState_Type(newstate)];
    
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

-(void)onHandleEvent:(EN_FSMEvent_Type)event{
    switch (_state) {
        case StateBuyTicket:{
            switch (event) {
                case EventBuyTicket:{
                    self.state = StateEnterGame;
                }
                    break;
                default:{
                    NSLog(@"动作不被允许,买完票只能进场!");
                }
                    break;
            }
        }
            break;
        case StateEnterGame:{
            switch (event) {
                case EventEnterGame:{
                    self.state = StateWatchGame;
                }
                    break;
                default:{
                    NSLog(@"动作不被允许,进场完了只能观看比赛!");
                }
                    break;
            }
        }
            break;
        case StateWatchGame:{
            switch (event) {
                case EventWatchGame:{
                    self.state = StateQuitGame;
                }
                    break;
                default:{
                    NSLog(@"动作不被允许,看完比赛只能退场!");
                }
                    break;
            }
        }
            break;
        case StateQuitGame:{
            NSLog(@"退出之后不允许做任何事情!");
        }
            break;
        default:
            break;
    }
    
}
@end
