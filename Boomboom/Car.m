//
//  Car.m
//  boomboom
//
//  Created by oahgnehzoul on 16/10/7.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "Car.h"
#import <objc/runtime.h>
#import "Student.h"
@implementation Car

- (NSDictionary *)allIvars {
    unsigned int count = 0;
    NSMutableDictionary *ivarDic = @{}.mutableCopy;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        id value = [self valueForKey:name];
        if (value) {
            ivarDic[name] = value;
        } else {
            NSAssert(value, @"字典的 value 不能为 nil");
        }
    }
    free(ivars);
    return ivarDic;
}

- (NSDictionary *)allProperities {
    unsigned int count = 0;
    NSMutableDictionary *propertiesDic = @{}.mutableCopy;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id value = [self valueForKey:name];
        NSAssert(value, @"字典的 value 不能为 nil");
        propertiesDic[name] = value;
    }
    free(properties);
    return propertiesDic;
}
- (NSDictionary *)allMethods {
    unsigned int count = 0;
    NSMutableDictionary *methodsDic = @{}.mutableCopy;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i ++) {
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
        
        int arg = method_getNumberOfArguments(methods[i]);
        // id obj, SEL _cmd, id some 需要减去默认的两个参数,obj ,_cmd
        methodsDic[name] = @(arg - 2);
    }
    free(methods);
    return methodsDic;
}

@end

@implementation Car (Category)

- (void)setColor:(UIColor *)color {
    objc_setAssociatedObject(self, @selector(color), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)color {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDriveBlock:(void (^)())driveBlock {
    objc_setAssociatedObject(self, @selector(driveBlock), driveBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)())driveBlock {
    return objc_getAssociatedObject(self, _cmd);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"drive"]) {
        // v --> void ; @-->id ; :--> sel
        class_addMethod([self class], sel, (IMP)driveMethod, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void driveMethod(id obj,SEL sel) {
    NSLog(@"car driveMethod");
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    //默认返回 nil
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"park"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    // 默认返回 nil
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 如果到了这个方法，什么都不写，也不会 crash
    Student *stu = [Student new];
    [anInvocation setSelector:@selector(dance)];
    [anInvocation invokeWithTarget:stu];
}

void park(id obj, SEL sel) {
    NSLog(@"car park");
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"消息无法处理%@",NSStringFromSelector(aSelector));
}




@end
