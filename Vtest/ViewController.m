//
//  ViewController.m
//  Vtest
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  [self testCategory];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.

}

#pragma test
- (void)testCategory {
  NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
  setObject(mDict, @"ff", @"ff");
  NSMutableArray *mArray = [[NSMutableArray alloc] init];
  addObject(mArray, nil);
}

@end
