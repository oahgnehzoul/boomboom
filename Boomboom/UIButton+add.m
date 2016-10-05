//
//  UIButton+add.m
//  boomboom
//
//  Created by oahgnehzoul on 16/9/29.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "UIButton+add.h"
#import <objc/runtime.h>

@implementation UIButton (add)

- (handlerBlock)handle {
    return objc_getAssociatedObject(self, @selector(handle));
}

- (void)setHandle:(handlerBlock)handle {
    objc_setAssociatedObject(self, @selector(handle), handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)addActionHandler:(handlerBlock)handler forControlEvent:(UIControlEvents)event {
    objc_setAssociatedObject(self, @selector(handle), handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(handleAction) forControlEvents:event];
}

- (void)handleAction{
    handlerBlock block = objc_getAssociatedObject(self, @selector(handle));
    if (block) {
        block();
    }
}

@end
