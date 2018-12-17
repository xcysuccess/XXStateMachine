//
//  ZZMacro.h
//  StateMachine
//
//  Created by tomxiang on 2018/12/14.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __qg_concat_inner(A, B) A##B
#define __qg_concat(a,b) __qg_concat_inner(a, b)

#define transition(...) \
class NSObject; \
- (ZZStateMachineTransition *)__qg_concat(__qg_sm_add_transition, __COUNTER__) { \
    return [[ZZStateMachineTransition alloc] initWithAnnotation:__VA_ARGS__]; \
} \
- (void)__qg_concat(__qg_sm_transition_action, __COUNTER__)


NS_ASSUME_NONNULL_BEGIN

@interface ZZMacro : NSObject

@end

NS_ASSUME_NONNULL_END
