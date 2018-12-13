//
//  ViewController.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/13.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "ViewController.h"
#import "XXNBAGame.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XXNBAGame *nbaGame = [XXNBAGame new];
    [nbaGame setState:StateEnterGame];
    NSLog(@"...等待5秒...");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [nbaGame setState:StateWatchGame];
    });
}


@end
