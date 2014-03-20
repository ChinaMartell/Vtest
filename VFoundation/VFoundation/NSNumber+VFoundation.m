//
//  NSNumber+VFoundation.m
//  VFoundation
//
//  Created by shadow on 14-3-10.
//  Copyright (c) 2014年 SJ. All rights reserved.
//

#import "NSNumber+VFoundation.h"
#define NSNXY_UPPER_BOUNDS 32767
#define NSNXY_SHIFT_VALUE 16
#define NSNXY_MASK 0xffff
@implementation NSNumber (NSNumberVFoundation)

/*
   2^1 = 2
   2^2 = 4
   2^3 = 8
   2^4 = 16
   2^5 = 32
   2^6 = 64
   2^7 = 128
   2^8 = 256
   2^9 = 512
   2^10 = 1024
   2^11 = 2048
   2^12 = 4096
   2^13 = 8192
   2^14 = 16384
   2^15 = 32768
   2^16 = 65536
   2^17 = 131072
 */

+ (NSNumber *)numberWithX:(NSInteger)x andY:(NSInteger)y {
	// this doesn't work for numbers above 32767
	if (x > NSNXY_UPPER_BOUNDS || y > NSNXY_UPPER_BOUNDS ||
	    x < -NSNXY_UPPER_BOUNDS || y < -NSNXY_UPPER_BOUNDS) {
		return @(-1);
	}
	// finally the actual constructor
	unsigned int i = (unsigned int)(x & NSNXY_MASK) | (unsigned int)(y << NSNXY_SHIFT_VALUE);
	return @(i);
}

- (NSInteger)x {
	int16_t xval = [self intValue] & NSNXY_MASK;
	int i = (int)xval;
	return i;
}

- (NSInteger)y {
	int16_t yVal = [self intValue] >> NSNXY_SHIFT_VALUE;
	int i = (int)yVal;
	return i;
}

- (NSNumber *)xAndY:(NSInteger)y {
	return [NSNumber numberWithX:[self intValue] andY:y];
}

@end
