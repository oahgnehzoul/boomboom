//
//  RuntimeViewController.m
//  boomboom
//
//  Created by oahgnehzoul on 16/9/16.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Student.h"
#import "Car.h"
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

void sayFunction(id obj, SEL _cmd, id some) {
    NSLog(@"%@ say %@",object_getIvar(obj, class_getInstanceVariable([obj class], "name")),some);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建一个类，添加方法，添加获取修改实例变量
    Class People = objc_allocateClassPair([NSObject class], "People", 0);
    class_addIvar(People, "name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    class_addMethod(People, sel_registerName("say:"), (IMP)sayFunction, "v@:@");
    objc_registerClassPair(People);
    
    id people = [People new];
    [people setValue:@"张三" forKey:@"name"];
    
    Ivar nameIvar = class_getInstanceVariable(People, "name");
    object_setIvar(people, nameIvar, @"李四");
    
    ((void (*)(id,SEL,id))objc_msgSend)(people,sel_registerName("say:"),@"hello");
    
    people = nil;
    objc_disposeClassPair(People);
    
    
    Car *car = [Car new];
    car.driveBlock = ^ {
        NSLog(@"car drive");
    };
//    car.driveBlock();
    [car drive];
    [car park];
}


/*
- (void)logMethods:(Class)class {
    unsigned int count = 0;
    Method *methods = class_copyMethodList(class, &count);
    for (int i = 0; i < count; i++) {
        SEL sel = method_getName(methods[i]);
//        sel_getName(sel);
        NSLog(@"%s",sel_getName(sel));
    }
    free(methods);
}

- (void)logProperties:(Class)class {
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList([class class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        NSLog(@"propertyName%d:%s",i,property_getName(properties[i]));
    }
    free(properties);
}

- (void)logPropertyAttributes:(Class)class {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([class class], &count);
    for (int i = 0; i < count; i++) {
        const char *const attrString = property_getAttributes(properties[i]);
        //例如 attrString:   T@"NSString",C,N,V_name
//            typeString:   @"NSString",C,N,V_name
//              next:                  ,C,N,V_name
//                typeLength     @"NSString"的长度
        const char *typeString = attrString + 1;
//        NSLog(@"%s",typeString);
        const char *next = NSGetSizeAndAlignment(typeString, NULL, NULL);
        size_t typeLength = next - typeString;
        NSLog(@"%zu",typeLength);
        NSLog(@"next:%s",next);
        NSLog(@"propertyAttribute%d:%s",i,attrString);
        
//        strncpy(<#char *__dst#>, <#const char *__src#>, <#size_t __n#>)
        
    }
    free(properties);
}
 */


@end
