//
//  Element.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Element.h"
#import "ApplicationUtilities.h"

@implementation Element

@synthesize discipline, elementGroup, description, ijsId;
@synthesize baseScore, plus_1, plus_2, plus_3, minus_1, minus_2, minus_3;

- (float)scoreForGOE:(NSString *)GOE {
	float goe_adjustment = 0;
	if ([GOE isEqualToString:GOE_plus_1]) {
		goe_adjustment = plus_1;
	} else if ([GOE isEqualToString:GOE_plus_2]) {
		goe_adjustment = plus_2;
	} else if ([GOE isEqualToString:GOE_plus_3]) {
		goe_adjustment = plus_3;
	} else if ([GOE isEqualToString:GOE_minus_1]) {
		goe_adjustment = minus_1;
	} else if ([GOE isEqualToString:GOE_minus_2]) {
		goe_adjustment = minus_2;
	} else if ([GOE isEqualToString:GOE_minus_3]) {
		goe_adjustment = minus_3;

	}

	return goe_adjustment;
}

@end
