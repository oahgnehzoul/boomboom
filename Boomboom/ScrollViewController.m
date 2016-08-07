//
//  ScrollViewController.m
//  DoMansonry
//
//  Created by oahgnehzoul on 16/8/2.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    //因为TopLayoutGuide为(0,64)开始计算，
    self.edgesForExtendedLayout = UIRectEdgeNone;

    NSLog(@"self.view.originX:%f Y:%f",self.view.frame.origin.x,self.view.frame.origin.y);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//  contentOffSet :CGPoint(x,y) \
    calcuate:x = scrollView.frame.origin.x - scrollView.contentView.x; \
             y = scrollView.frame.origin.y - scrollView.contentView.y; \
    scrollView的origin的坐标 减去  contentView的左上角的坐标\
    在scrollView移动的过程中，scrollView的frame的origin坐标是不变的。拖动的是contentView;
    NSLog(@"x:%f y:%f",self.scrollView.contentOffset.x,self.scrollView.contentOffset.y);
//    NSLog(@"originX:%f,originY:%f",self.scrollView.frame.origin.x,self.scrollView.frame.origin.y);
}

//停止拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"didEndDragging");
}

// 停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"didEndDeceletating");
}


@end
