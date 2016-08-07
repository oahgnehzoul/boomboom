//
//  UIImage+Image.m
//  boomboom
//
//  Created by oahgnehzoul on 16/8/4.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>

@implementation UIImage (Image)

+ (void)load {
    method_exchangeImplementations(class_getClassMethod(self, @selector(imageNamed:)), class_getClassMethod(self, @selector(imageWithName:)));
}


+ (UIImage *)imageWithName:(NSString *)name {
    UIImage *image = [self imageWithName:name];
    if (!image) {
        NSLog(@"加载空的图片");
    }
    return image;
}

@end
