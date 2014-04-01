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
	NSMutableArray *arra = [[NSMutableArray alloc] init];
	[arra addObject:@"fff"];
	NSMutableArray *xx = [arra deepCopy];
	[xx addObject:@"aaa"];
	UserEntity *enty = [[UserEntity alloc] init];
	enty.userName = @"fuck";
	enty.age = 29;
	UserEntity *aa = [enty mutableCopy];
	aa.userName = @"fff";
	NSLog(@"fff");
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
