//
//  ViewController.m
//  StateMachine
//
//  Created by tomxiang on 2018/12/13.
//  Copyright © 2018年 tomxiang. All rights reserved.
//

#import "ViewController.h"
#import "XXNBAGame.h"
#import "YYNBAGame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (IBAction)onFirstButtonClick:(UIButton *)sender {
    //First StateMachine
    XXNBAGame *nbaGame = [XXNBAGame new];
    [nbaGame setState:XXStateEnterGame];
    NSLog(@"...等待5秒...");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [nbaGame setState:XXStateWatchGame];
    });
}

- (IBAction)onSecondButtonClick:(UIButton *)sender {
    YYNBAGame *nbaGame = [YYNBAGame new];
    [nbaGame setupStateMachine];
    [nbaGame startEvent];
}

- (IBAction)onThirdButtonClick:(UIButton *)sender {
    
}



@end
