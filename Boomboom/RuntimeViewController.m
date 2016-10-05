//
//  RuntimeViewController.m
//  boomboom
//
//  Created by oahgnehzoul on 16/9/16.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "RuntimeViewController.h"
#import <objc/runtime.h>
#import "Student.h"

@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self logProperties:[Student class]];
    [self logPropertyAttributes:[Student class]];
    
    _name = @"123";
//    self.stu->name = @"11";
    Student *stu1 = [Student new];
    stu1.otherName = @"otherName";
    [self logProperties:[stu1 class]];
    NSLog(@"------------");
    [self logMethods:[Student class]];
}

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


@end
