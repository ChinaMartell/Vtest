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
	NSString *strf = @"http://www.baidu.com/wfw/s?wd=%E5%95%8A%E9%A2%9D%E5%90%84%E4%B8%AA&rsv_spt=1&issp=1&rsv_bp=0&ie=utf-8&tn=baiduhome_pg&rsv_sug3=3&rsv_sug=0&rsv_sug4=542&rsv_sug1=2&inputT=1230";
	NSURL *url = [NSURL URLWithString:strf];

	NSLog(@"ffaf");
}

@end
