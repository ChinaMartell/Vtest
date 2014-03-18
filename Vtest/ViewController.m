//
//  ViewController.m
//  Vtest
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "ViewController.h"
#import "VCoreData.h"
#import "NSArray+VFoundation.h"
#import "TestTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self testCategory];
	[self testArray];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma test
- (void)testCategory {
}

- (void)testArray {
    TestTableViewController *t1 = [[TestTableViewController alloc] init];
    TestTableViewController *t2 = [[TestTableViewController alloc] init];
	NSArray *array = @[t1, t2];
	NSArray *array1 = [array copy];
	NSMutableArray *array2 = [array mutableCopy];
	NSArray *array3 = [array trueDeepCopy];
	NSLog(@"123");
}



@end
