//
//  Car.h
//  boomboom
//
//  Created by oahgnehzoul on 16/10/7.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
{
    NSString *carName;
}

@property (nonatomic, assign) NSUInteger age;

- (NSDictionary *)allProperities;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

@end

@interface Car (Category)

@property (nonatomic, copy) void(^driveBlock)();
@property (nonatomic, strong) UIColor *color;

- (void)drive;
- (void)park;

@end
