//
//  ZZNBAGame.h
//  StateMachine
//
//  Created by tomxiang on 2018/12/14.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ZZState){
    ZZStateBuyTicket = 0,
    ZZStateEnterGame,
    ZZStateWatchGame,
    ZZStateQuitGame,
};

typedef NS_ENUM(NSInteger,ZZEvent){
    ZZEventBuyTicket = 0,
    ZZEventEnterGame,
    ZZEventWatchGame,
    ZZEventQuitGame,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZZNBAGame : NSObject

- (void)startZZState;

@end

NS_ASSUME_NONNULL_END
