//
//  VUtilityDefine.h
//  VFoundation
//
//  Created by shadow on 14-3-11.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VGCDManager.h"

#pragma mark - VGCD

@interface VUtilityDefine : NSObject
/**
 *  It is a simplified version of dispatchMainQueueSync
 *
 *  @param block Will add by main queue
 */
	void mainS(dispatch_block_t block);

/**
 *  It is a simplified version of dispatchMainQueueAsync
 *
 *  @param block Will add by main queue
 */
void mainA(dispatch_block_t block);

/**
 *  It is a simplified version of dispatchGlobalQueueSync
 *
 *  @param block Will add by global queue
 */
void globalS(dispatch_block_t block);

/**
 *  It is a simplified version of dispatchGlobalQueueAsync
 *
 *  @param block Will add by global queue
 */
void globalA(dispatch_block_t block);

void asyncToMain(dispatch_block_t gBlock, dispatch_block_t mBlock);

@end
