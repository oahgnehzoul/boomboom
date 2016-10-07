//
//  Student.m
//  boomboom
//
//  Created by oahgnehzoul on 16/9/8.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>
@implementation Student
+ (void)load {
    NSLog(@"load Student");
}

- (void)dance {
    NSLog(@"student dance");
}
- (void)park {
    NSLog(@"student park");
}
@end
@implementation Student (Study)

+ (void)load {
    NSLog(@"load study");
}

- (void)setOtherName:(NSString *)otherName {
    objc_setAssociatedObject(self, "otherName", otherName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)otherName {
    return objc_getAssociatedObject(self, "otherName");
}

- (void)setDelegate:(id<StudentDelegate>)delegate {
    objc_setAssociatedObject(self, "delegate", delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<StudentDelegate>)delegate {
    return objc_getAssociatedObject(self, "delegate");
}


@end
