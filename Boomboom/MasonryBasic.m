//
//  MasonryBasic.m
//  DoMansonry
//
//  Created by oahgnehzoul on 16/7/29.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "MasonryBasic.h"
#import <WebKit/WebKit.h>
@interface MasonryBasic ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation MasonryBasic

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
    }
    return _imageView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];

    
//    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"html"];
//    NSString *html = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
//    [self.webView loadHTMLString:html baseURL:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.shenghuozhe.net/support/location_intro.html"]]];
    
    self.webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.webView];
    
    
    /*
    UIView *greenView = [UIView new];
    greenView.layer.backgroundColor = [UIColor greenColor].CGColor;
    greenView.layer.cornerRadius = 20;
    
    
    [self.view addSubview:greenView];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.view.mas_top).with.offset(20);
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(greenView.mas_right).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.width.height.equalTo(greenView);
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(greenView.mas_bottom).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-20);
        make.height.equalTo(greenView);
    }];
    
    [self.view addSubview:self.imageView];
    self.imageView.image = [UIImage imageWithName:@"1"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.top.equalTo(self.view.mas_top).with.offset(20);
        make.width.height.equalTo(50);
    }];
    */
//    [self performSelector:@selector(remove:) withObject:self.view afterDelay:2];
}

- (void)dealloc {
    NSLog(@"MasonryBasic dealloc");
}

- (void)remove:(UIView *)view {
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

@end
