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
#import "NSDictionary+VFoundation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self testCategory];
	[self testArray];
	[self testDic];
//	[self testCategoryBundle];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma test
- (void)testCategory {
}

- (void)testArray {
    NSMutableArray *arrayx = [[NSMutableArray alloc] init];
    [arrayx removeFirstObject];
    [arrayx removeLastObject];
	NSArray *array = @[@1, @2];
	NSArray *array1 = [array copy];
	[array objectAtIndex:0];
	NSMutableArray *array2 = [array mutableCopy];
	NSArray *array3 = [array trueDeepCopy];
}

- (void)testDic {
	NSDictionary *dic = [[NSDictionary alloc] init];

//   NSArray *array = @[@1, @2];
	NSMutableDictionary *mutableDic = [[NSMutableDictionary alloc] init];
    [mutableDic setValue:nil forKey:@"1"];

    [mutableDic removeFirstObject];
    
    [mutableDic setValue:nil forKey:@"1"];

    [mutableDic removeLastObject];
//    [dic setObject:nil forKey:@"2"];
//      [array setValue:[NSNull null] forKey:@"1"];
//    id object = [dic valueForKey:@"1"];
//   NSDictionary *dic = [[NSDictionary alloc] initWithObjects:@[@"1"] forKeys:@[@1]];

	[NSDictionary dictionaryWithDictionaries:nil, nil];
}

@end
