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
#import "AFNetworking.h"
#import "UIButton+add.h"
typedef void (^blk_t)(id obj);
//blk_t blk;
@interface ViewController ()
//{
//    blk_t blk;
//}

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, copy) blk_t blk;

@property (nonatomic, copy) void (^BlockName)(id data);


@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    int count = 0;
    for (int i = 1564; i <= 1616; i++) {
        if ((i % 4 == 0) && (i % 100 != 0)) {
            printf("%d\n",i);
            count++;
        }
    }
    printf("count:%d\n",count);
    printf("a:%f\n",100*0.75*0.68*0.85*0.80);
//    self.title = @"viewController";
//    
//    int (^BlockName)(int a) = ^int (int a) {
//        NSLog(@"%d",a);
//        return a;
//    };
    
    
    
    // masonry内部不会造成block循环引用,因为view1对象并没有强引用block对象。
//    UIView *view1 = [[UIView alloc] init];
//    view1.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:view1];
//    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view.mas_top).with.offset(100);
//        make.left.equalTo(self.view.mas_left).with.offset(100);
//        make.right.equalTo(self.view.mas_right).with.offset(-100);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-100);
//    }];
//    UIImageView *imageView;
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperationManager manager] GET:@"" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        imageView.image = [UIImage imageNamed:@"1"];
//    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//        NSLog(@"error");
//    }];
    
    dispatch_queue_t q = dispatch_queue_create("com.example", NULL);
    
    dispatch_sync(q, ^{
        
    });
    
    
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
    
//    [self captureObject];
//    blk([[NSObject alloc] init]);
//    blk([[NSObject alloc] init]);
//    blk([[NSObject alloc] init]);
//    blk([[NSObject alloc] init]);
//    NSLog(@"blk:%@",blk);

    
//    __block id tmp = self;
//    blk = ^(id obj){
//        NSLog(@"%@",tmp);
//        tmp = nil;
//    };
    // 执行blk才不会循环引用，不执行 就会造成循环引用，所以感觉循环引用在编译期就已经决定了，\
    __block 在arc下，block内部会retain 调用的外部对象 \
            在mrc下，block内部不会retain 调用的外部对象
    
//    blk([NSString new]);
    
//    当block作为函数返回值返回时，编译器会自动调用copy方法
//    当block赋值给__strong id 类型的对象或成员变量，编译器调用copy
//    当block作为参数传递给usingBlock的cocoaFramework方法或GCD的API时，这些方法会在内部对传递进来的block调用copy

//    [self transmitBlock:blk];
    
    // 这样并不会造成循环引用，block强引用了self，但是self并没有强引用block， \
    间接说明了 当self 调用 一个方法时，并不会强引用方法里的参数？？不一定，用set、add等关键字
//    [self transmitBlock:^(id obj) {
//        [self NSLog];
//    }]; // 不会造成循环引用， 并且会执行NSLog
    
    
//    [self executeBlock:^(id obj) {
//        // 没有提醒造成循环引用，并且不会造成循环引用。
////        [self NSLog];
//        [self performSelector:@selector(NSLog) withObject:nil afterDelay:5];
//        NSLog(@"%@",self);
//    }];
    

    [self test];
//    [self addBlock:^(id obj) {
//        [self NSLog];  //这样会提醒造成循环引用;self 还是可以释放的
//    }];
    
//    [self setBlock:^(id obj) {
//        [self NSLog];  //和addBlock一样的效果。
//    }];
    
//    self.blk = ^(id data) {
//        [self NSLog];    // 这样会提醒造成循环引用，并且self 销毁不了
//    };
    
//    [self setHandler:^(id obj) {
//        [self NSLog];
//        //会提醒造成了循环引用，pop时还是可以销毁的,像这些带有set、add这种的，编译器因为KVC，相当于默认吧block作为了self的属性，那为什么pop了之后可以销毁？？猜测实际上没有循环引用
//    //http://stackoverflow.com/questions/15535899/blocks-retain-cycle-from-naming-convention
//    }];
    
//    NSLog(@"111:%@",^(id obj){
//        NSLog(@"%@",self);
//    });
    // block引用了外部变量，但是没有copy，都为stack block;
    
//    NSMutableArray *array = [NSMutableArray array];
//    addBlockToArray(array);
//    void (^myblock)() = [array objectAtIndex:0]; //在这里强引用了block ,在arc下为copy
//    myblock();
//    NSLog(@"myblock:%@",myblock);
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NSLog) name:@"dfasf" object:nil];
    
    NSDictionary *dic = @{
                          @"name":@"张三",
                          @"job":@"老师"
                          };
    for (NSString *key in dic) {
        NSLog(@"%@",key);
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 30)];
    [self.view addSubview:button];
    __weak UIButton *weak = button;
    button.titleLabel.text = @"123";
    button.backgroundColor = [UIColor redColor];
    [button addActionHandler:^{
        weak.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    } forControlEvent:UIControlEventTouchUpInside];
    
    /* ab 之后再 c
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSOperation *a = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"a");
    }];
    NSOperation *b = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"b");
    }];
    NSOperation *c = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"c");
    }];
    [c addDependency:a];
    [c addDependency:b];
    [queue addOperation:c];
    [queue addOperation:b];
    [queue addOperation:a];
    
    */
    
    
    uint8_t x;
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"MDPullEmoji@2x" ofType:@"png"];
    NSLog(@"imagePath:%@",imagePath);
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    [data getBytes:&x length:1];
    // png --> 0x89
    NSLog(@"%x",x);
    
//    [self findBiggestValue];
}


typedef struct treeNode {
    int value;
    struct treeNode *left;
    struct treeNode *right;
}TreeNode;

void addValue(NSMutableArray *a,struct treeNode *t) {
    if (t != NULL) {
        [a addObject:@(t->value)];
        addValue(a, t->left);
        addValue(a, t->right);
    }
}

void inOrder(TreeNode *t) {
    if (t) {
        printf("%d,",t->value);
        inOrder(t->left);
        inOrder(t->right);
    }
    return;
}

- (void)findBiggestValue {
    TreeNode *node1 = (TreeNode *)malloc(sizeof(TreeNode));
    TreeNode *node2 = (TreeNode *)malloc(sizeof(TreeNode));
    TreeNode *node3 = (TreeNode *)malloc(sizeof(TreeNode));
    TreeNode *node4 = (TreeNode *)malloc(sizeof(TreeNode));
    TreeNode *node5 = (TreeNode *)malloc(sizeof(TreeNode));
    TreeNode *node6 = (TreeNode *)malloc(sizeof(TreeNode));
    TreeNode *node7 = (TreeNode *)malloc(sizeof(TreeNode));
    TreeNode *node8 = (TreeNode *)malloc(sizeof(TreeNode));
    node1->value = 1;
    node1->left = node2;
    node1->right = node8;
    node2->value = 2;
    node2->right = node4;
    node4->value = 4;
    node8->value = 8;
    node8->left = node3;
    node3->value = 3;
    node8->right = node6;
    node6->value = 6;
    node6->left = node5;
    node6->right = node7;
    node5->value = 5;
    node7->value = 7;
    
//    inOrder(node1);
    NSMutableArray *arr = @[].mutableCopy;
    addValue(arr, node1);
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",obj);
    }];
}

- (void)test {
    UIApplication *application = [UIApplication sharedApplication];
    UIBackgroundTaskIdentifier __block backgroundTaskIdentifier = UIBackgroundTaskInvalid;
    __weak typeof (self) weakSelf = self;
    backgroundTaskIdentifier = [application beginBackgroundTaskWithExpirationHandler:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        [strongSelf NSLog];
        

        
//        [self NSLog];
        //AF 中用到，此处 需要 weakself 解决循环引用
//        self-->application-？->block-->self，感觉application 的 beginBackgroundTask 方法的实现中中强引用了 block，
        
    }];
}


- (void)transmitBlock:(blk_t)block {
    NSLog(@"传参：%@",block);
    block([NSString new]);
}

- (void)executeBlock:(blk_t)block {
    NSLog(@"executeBlock");
    block([NSString new]);
}

- (void)addBlock:(blk_t)block {
    NSLog(@"addBlock");
    block([NSString new]);
}

- (void)setBlock:(blk_t)block {
    NSLog(@"setBlock");
    block([NSString new]);
}

- (void)setHandler:(blk_t)block {
    NSLog(@"setHandler");
    block([NSString new]);
}

- (void)handleBlock:(void(^)(id data))block {
    block([NSString new]);
}

- (void)NSLog {
    NSLog(@"NSLog");
}

void addBlockToArray(NSMutableArray *array) {
    NSString *str = @"aaa";
    [array addObject:^{NSLog(@"%@",str);}];
    NSLog(@"arrayBLock:%@",^{NSLog(@"%@",str);});
}

- (void)captureObject {
//    id array = [[NSMutableArray alloc] init];
//    id __weak weakArray = array;
//    blk = ^(id obj) {
////        [array addObject:obj];
//        [weakArray addObject:obj];
////        NSLog(@"count = %ld",[array count]);
//        NSLog(@"count:%ld",[weakArray count]);
//    };
}

//MARK:-你好啊
- (void)dealloc {
    NSLog(@"viewController dealloced");
}

#pragma mark - 变了吗
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.blueView removeFromSuperview];
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];
}





@end
