//
//  Student.h
//  boomboom
//
//  Created by oahgnehzoul on 16/9/8.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block)(void);

@protocol StudentDelegate <NSObject>

- (void)speak;

@end
@interface Student : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) Block block;

@property (nonatomic, copy) void (^BlockName)(id data);

@property (nonatomic, copy, readonly) id job;

@property (nonatomic, assign) NSInteger age;
//@property (nonatomic, copy) returnType (^blockName)(params);

- (void)dance;
@end

@interface Student (Study)


@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *otherName;

@property (nonatomic, weak) id<StudentDelegate> delegate;

@end
