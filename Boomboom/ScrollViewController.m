//
//  ScrollViewController.m
//  DoMansonry
//
//  Created by oahgnehzoul on 16/8/2.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "ScrollViewController.h"
@interface PullRefreshLoadingView : UIView

- (void)startAnimating;
- (void)stopAnimating;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PullRefreshLoadingView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        NSMutableArray *images = @[].mutableCopy;
        for (int i = 1; i < 7; i++) {
            NSString *name = [NSString stringWithFormat:@"MDPullLoading%d",i];
            UIImage *image = [UIImage imageNamed:name];
            [images addObject:image];
        }
        _imageView.animationImages = images;
        _imageView.animationDuration = 0.6;
    }
    return _imageView;
}

- (void)startAnimating {
    [self.imageView startAnimating];
}

- (void)stopAnimating {
    [self.imageView stopAnimating];
}

@end

@interface PullRefreshView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) PullRefreshLoadingView *loadingView;

@property (nonatomic, assign) BOOL isRefreshing;

- (void)startRefreshing;
- (void)stopRefreshing;

@end

@implementation PullRefreshView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        if (!_imageView) {
            _imageView = [UIImageView new];
            
        }
        [self addSubview:_imageView];
        //设置拉伸部分图片
//        _imageView.image = [[UIImage imageNamed:@"MDPullEmoji.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:54];
        _imageView.image = [[UIImage imageNamed:@"MDPullEmoji.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(53, 0, 8, 0)];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];

        [self addSubview:self.loadingView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(65);
        }];
        self.loadingView.hidden = YES;
    }
    self.backgroundColor = [UIColor redColor];
    return self;
}

- (void)startRefreshing {
   
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    self.loadingView.hidden = NO;
    self.imageView.hidden = YES;
    [self.loadingView startAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets inset = scrollView.contentInset;
        inset.top = 65;
        scrollView.contentInset = inset;
        scrollView.contentOffset = CGPointMake(0, -65);
    } completion:^(BOOL finished) {
        //请求网络
    }];
}

- (void)stopRefreshing {

    UIScrollView *scrollView = (UIScrollView *)self.superview;
    [UIView animateWithDuration:0.3 animations:^{
        UIEdgeInsets inset = scrollView.contentInset;
        inset.top = 0;
        scrollView.contentInset = inset;
    } completion:^(BOOL finished) {
        [self.loadingView stopAnimating];
        self.loadingView.hidden = YES;
        self.imageView.hidden = NO;
    }];
}

- (PullRefreshLoadingView *)loadingView {
    if (!_loadingView) {
        _loadingView = [[PullRefreshLoadingView alloc] initWithFrame:CGRectZero];
    }
    return _loadingView;
}

@end



@interface ScrollViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) PullRefreshView *pullView;

@property (nonatomic, assign) CGFloat visibleHeight;

@end

@implementation ScrollViewController

+ (void)load {
//    [super load];
    NSLog(@"load");
}

+ (void)initialize {
    NSLog(@"initialize");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.delegate = self;
    //因为TopLayoutGuide为(0,64)开始计算，
    self.edgesForExtendedLayout = UIRectEdgeNone;

    NSLog(@"self.view.originX:%f Y:%f",self.view.frame.origin.x,self.view.frame.origin.y);
    
//    self.scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    
    NSLog(@"viewDidLoad");

    [self.scrollView addSubview:self.pullView];
//    [self.pullView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(45, 65));
//        make.bottom.equalTo(self.scrollView.mas_top);
//        make.centerX.equalTo(self.scrollView.mas_centerX);
//    }];
    CGFloat w = (CGRectGetWidth(self.view.frame) - 45) / 2;
    self.pullView.frame = CGRectMake(w, -65, 45, 65);
//    self.pullView.bottom = self.scrollView.top;
}

- (PullRefreshView *)pullView {
    if (!_pullView) {
        _pullView = [[PullRefreshView alloc] init];
    }
    return _pullView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//  contentOffSet :CGPoint(x,y) \
    calcuate:x = scrollView.frame.origin.x - scrollView.contentView.x; \
             y = scrollView.frame.origin.y - scrollView.contentView.y; \
    scrollView的origin的坐标 减去  contentView的左上角的坐标\
    在scrollView移动的过程中，scrollView的frame的origin坐标是不变的。拖动的是contentView;
//    NSLog(@"x:%f y:%f",self.scrollView.contentOffset.x,self.scrollView.contentOffset.y);
//    NSLog(@"originX:%f,originY:%f",self.scrollView.frame.origin.x,self.scrollView.frame.origin.y);
    
    CGFloat h = -scrollView.contentOffset.y - scrollView.contentInset.top;
    _visibleHeight = MAX(h, 0);
    NSLog(@"contentInset.top:%f",scrollView.contentInset.top);
    NSLog(@"contentOffset.y:%f",scrollView.contentOffset.y);
    NSLog(@"%f",h);
    CGFloat pullViewHeight = MAX(-scrollView.contentOffset.y, 65);
    //当使用Masonry用力向下滑的时候，pullView的UI会整体向下滑，出现混乱，用frame的时候不会出现这种情况。
//    [self.pullView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(pullViewHeight);
//        make.top.equalTo(self.scrollView.mas_top).offset(-pullViewHeight);
//    }];
    self.pullView.height = pullViewHeight;
    self.pullView.bottom = self.scrollView.top;
}

//停止拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"didEndDragging");
    if (_visibleHeight >= 65) {
        [self.pullView startRefreshing];
    }
    
    //强制 停止刷新，
    [self.pullView performSelector:@selector(stopRefreshing) withObject:nil afterDelay:3];
}

// 停止减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"didEndDeceletating");
}




@end
