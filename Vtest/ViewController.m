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
//#import "NSDictionary+VFoundation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self testCategory];
	[self testArray];
	[self testDic];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma test
- (void)testCategory {
}

- (void)testArray {
	NSArray *array = @[@1, @2];
	NSArray *array1 = [array copy];
	[array objectAtIndex:0];
	NSMutableArray *array2 = [array mutableCopy];
	NSArray *array3 = [array trueDeepCopy];
	[array2 addObject:nil];
	[array2 setValue:@"1" forKey:@"1"];
}

- (void)testDic {
	NSDictionary *dic = [[NSDictionary alloc] init];
	[dic setValue:@"1" forKey:@"1"];

//   NSArray *array = @[@1, @2];
  NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
	[mutableDic setValue:@"123" forKey:@"1"];
//    [dic setObject:nil forKey:@"2"];
//      [array setValue:[NSNull null] forKey:@"1"];
//    id object = [dic valueForKey:@"1"];
//   NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[@"1"] forKeys:@[@1]];

	[NSDictionary dictionaryWithDictionaries:nil, nil];
	NSLog(@"%@", [dic valueForKey:@"2"]);
    [mutableDic removeOb
//	NSLog(@"%@ and %@ and %@", [mutableDic valueForKey:@"1"], [mutableDic valueForKey:@"2"], [dic valueForKey:nil]);
}

@end
