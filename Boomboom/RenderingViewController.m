//
//  RenderingViewController.m
//  boomboom
//
//  Created by oahgnehzoul on 16/9/23.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "RenderingViewController.h"

@interface RenderingViewController ()

@property (nonatomic, strong) NSString *str1;
@property (nonatomic, copy) NSString *str2;
@end

@implementation RenderingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView *viewA = [UIView new];
    viewA.backgroundColor = [UIColor greenColor];
    [self.view addSubview:viewA];
    [viewA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(100, 100));
        make.left.top.equalTo(self.view);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.jpg"]];
    imageView.frame = CGRectMake(0, 200, 150, 150);
    [self.view addSubview:imageView];
    
    UIBlurEffect *blurEffrct = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffrct];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffrct];
//    visualEffectView.backgroundColor = [UIColor grayColor];
    visualEffectView.frame = CGRectMake(0, 0, 150, 150);
//    [self.view addSubview:visualEffectView];
    [imageView addSubview:visualEffectView];
    visualEffectView.alpha  = 0.5;
//    [visualEffectView.contentView addSubview:imageView];
    */
    
    NSMutableString *str = @"mutableString".mutableCopy;
    
    self.str1 = str;
    self.str2 = str;
    [str appendString:@"123"];
    NSLog(@"%@",self.str1);
    NSLog(@"%@",self.str2);
    
    
}

@end
