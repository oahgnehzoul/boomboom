//
//  RACViewController.m
//  boomboom
//
//  Created by oahgnehzoul on 16/8/2.
//  Copyright © 2016年 llzzzhh. All rights reserved.
//

#import "RACViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RACViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation RACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[self.textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
//        NSLog(@"textField change");
//    }];
    
//    [[self.textField rac_textSignal] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    
    [[[self.textField rac_textSignal] filter:^BOOL(id value) {
        return [(NSString *)value length] > 3;
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    @weakify(self)
    RACSignal *validUsernameSignal = [self.textField.rac_textSignal map:^id(NSString *text) {
        @strongify(self)
        return @([self isValidUsername:text]);
    }];

    RACSignal *validPasswordSignal = [self.password.rac_textSignal map:^id(NSString *text) {
        @strongify(self)
        return @([self isValidPassword:text]);
    }];
//    [[validPasswordSignal map:^id(NSNumber *passwordValid) {
//        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
//    }] subscribeNext:^(UIColor *color) {
//        self.password.backgroundColor = color;
//    }];
    

    RAC(self.password, backgroundColor) = [validPasswordSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RAC(self.textField, backgroundColor) = [validUsernameSignal map:^id(NSNumber *passwordValid) {
        return [passwordValid boolValue] ? [UIColor clearColor] : [UIColor yellowColor];
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                                                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid){
                                                          
                                                          return @([usernameValid boolValue] && [passwordValid boolValue]);
                                                      }];
    
   
    
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        @strongify(self)        
        self.signInButton.enabled = [signupActive boolValue];
    }];
    
    [[self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"signInButton clicked");
    }];
}

- (BOOL)isValidUsername:(NSString *)str {
    return [str isEqualToString:@"oahgnehzoul"];
}

- (BOOL)isValidPassword:(NSString *)str {
    return [str isEqualToString:@"password"];
}


- (IBAction)goSign:(id)sender {

}

- (void)dealloc {
    NSLog(@"RACViewController dealloced");
}

@end
