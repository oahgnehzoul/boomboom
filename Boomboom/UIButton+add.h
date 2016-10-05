//
//  UIButton+add.h
//  boomboom
//
//  Created by oahgnehzoul on 16/9/29.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^handlerBlock) ();
@interface UIButton (add)

@property (nonatomic, copy) handlerBlock handle;

- (void)addActionHandler:(handlerBlock)handler forControlEvent:(UIControlEvents)event;

@end
