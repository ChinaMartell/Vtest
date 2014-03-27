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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	NSPriorityQueue *q = [[NSPriorityQueue alloc] init];
	[q enQueue:@"default" withPriority:NSQueuePriorityDefault];
	[q enQueue:@"low" withPriority:NSQueuePriorityLow];
	[q enQueue:@"high" withPriority:NSQueuePriorityHigh];
	[q jumpQueue:@"max"];
	for (id object in q) {
		NSLog(@"aff:%@", object);
	}
	NSLog(@"ff");


	NSStack *s = [[NSStack alloc] init];
	[s push:@"ffff"];
	[s push:@"fffaf"];
	[s push:@"ffegff"];
	[s push:@"fffhf"];
	[s push:@"ffrtff"];
	[s push:@"fffhaf"];
	for (id object in s) {
		NSLog(@"aaaaff:%@", object);
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

@end
