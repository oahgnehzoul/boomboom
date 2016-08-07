//
//  ViewController.m
//  DoMansonry
//
//  Created by oahgnehzoul on 16/7/29.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "ViewController.h"
//#define MAS_SHORTHAND_GLOBALS
//#import <Masonry/Masonry.h>
#import "MasonryBasic.h"
#import <CoreFoundation/CoreFoundation.h>
#import <pthread/pthread.h>
@interface ViewController ()

@property (nonatomic, strong) UIView *blueView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIView *view1 = [[UIView alloc] init];
//    view1.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view1];
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(100);
//        make.left.equalTo(self.view.mas_left).with.offset(100);
//        make.right.equalTo(self.view.mas_right).with.offset(-100);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
//    }];
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    self.blueView = [UIView new];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    UIView *yellowView = [UIView new];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-40);
        make.height.equalTo(50);
    }];
    
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(redView);
        make.left.equalTo(redView.mas_right).with.offset(40);
    }];
    
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(redView);
        make.left.equalTo(self.blueView.mas_right).with.offset(40);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        
        make.left.equalTo(redView.mas_right).with.offset(20).priority(250);
    }];
    
    //block
    // 没有引用外部变量为globalblock
    NSLog(@"1 %@",^(void){NSLog(@"block");});   //global
    // 引用外部变量，为stackblock
    MasonryBasic *bs = [MasonryBasic new];
    NSLog(@"2 %@",^(){NSLog(@"%@",bs);});   //stack
    
    //global
    NSLog(@"3 %@",[^{NSLog(@"123");} copy]);    //global
    // 引用了外部变量 而且 copy ，才会malloc ,malloc 会retain外部对象。
    NSLog(@"4 %@",[^{NSLog(@"%@",bs);} copy]);  //malloc
    
    // 如果block不是copy，还是 stackblock
    __block MasonryBasic *blockBs = bs;
    NSLog(@"5 %@",^{NSLog(@"%@",blockBs);});   //stack
    NSLog(@"6 %@",[^{NSLog(@"%@",blockBs);} copy]); //malloc
    
    __weak MasonryBasic *weakBs = bs;
    NSLog(@"7 %@",^{NSLog(@"%@",weakBs);}); //stack
    NSLog(@"8 %@",[^{NSLog(@"%@",weakBs);} copy]);  //malloc
    
//    void (^block)() = ^{NSLog(@"123");};
    void (^block)();
    block = ^{NSLog(@"345");};
    NSLog(@"9 %@",block);
    
    
    // ARC下，如果block内部 没有引用外部变量，是global block。引用了是 stack block。强引用了之后到 malloc block;


    //全局的Dictionary, @{pthread_t:CFRunLoopRef} \
                            key   :  value
    
//    static CFSpinLock_t loopsLock;
    
    
}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.blueView removeFromSuperview];
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
}





@end
