//
//  VUtilityDefine.m
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "VUtilityDefine.h"

@implementation VUtilityDefine
void mainS(dispatch_block_t block) {
	dispatch_sync(dispatch_get_main_queue(), block);
}

void mainA(dispatch_block_t block) {
	dispatch_async(dispatch_get_main_queue(), block);
}

void globalS(dispatch_block_t block) {
	dispatch_async(dispatch_get_global_queue(0, 0), block);
}

void globalA(dispatch_block_t block) {
	dispatch_async(dispatch_get_global_queue(0, 0), block);
}

void asyncToMain(dispatch_block_t gblock, dispatch_block_t mblock) {
	dispatch_async(dispatch_get_global_queue(0, 0), ^{
	    gblock();
	    mainA(mblock);
	});
}

@end
