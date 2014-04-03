//
//  ViewController.m
//  give me some money
//
//  Created by shadow on 14-3-20.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "ViewController.h"
#import "UserEntity.h"
#import <objc/runtime.h>
#import "VCoreData.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UserEntity *en = [[UserEntity alloc] init];
//	en.userName = @"fuck";
//	[en put];
	[UserEntity get:@"userName='fuck'"];
	[en execute:@"SELECT * FROM UserEntity WHERE userName=?" params:@"fuck", @(15), nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
