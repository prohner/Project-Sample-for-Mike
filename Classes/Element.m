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

- (NSString *)description {
	NSString *result = description;
	if ([self isPairs]) {
		if ([elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS]) {
			result = [result stringByAppendingString:@" s-by-s jump"];
		} else if ([elementGroup isEqualToString:ELEMENT_GROUP_TWIST_LIFTS]) {
			result = [result stringByAppendingString:@" twist lift"];
		} else if ([elementGroup isEqualToString:ELEMENT_GROUP_DEATH_SPIRALS]) {
			result = [result stringByAppendingString:@" death spiral"];
		} else if ([elementGroup isEqualToString:ELEMENT_GROUP_LIFTS]) {
			result = [result stringByAppendingString:@" lift"];
		} else if ([elementGroup isEqualToString:ELEMENT_GROUP_PAIR_SPINS]) {
			result = [result stringByAppendingString:@" pair spin"];
		} else if ([elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS]) {
			result = [result stringByAppendingString:@" s-by-s spin"];
		} else if ([elementGroup isEqualToString:ELEMENT_GROUP_THROWS]) {
			result = [result stringByAppendingString:@" throw"];
		}
	}
	
	return result;
}

- (BOOL)isSingles {
	if ([[self discipline] isEqualToString:DISCIPLINE_SINGLES]) {
		return YES;
	}
	return NO;
}

- (BOOL)isPairs {
	if ([[self discipline] isEqualToString:DISCIPLINE_PAIRS]) {
		return YES;
	}
	return NO;
}

- (BOOL)isDance {
	if ([[self discipline] isEqualToString:DISCIPLINE_DANCE]) {
		return YES;
	}
	return NO;
}


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

- (NSString *)ijsIdLetters {
	NSString *theLetters;
	if ([elementGroup isEqualToString:ELEMENT_GROUP_JUMPS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_THROWS]
		) {
		theLetters = [ijsId substringFromIndex:1];
	} else {
		theLetters = [ijsId substringToIndex:[ijsId length]-1];
	}
	return theLetters;
}

- (NSString *)ijsIdDigits {
	NSString *theDigits;
	if ([elementGroup isEqualToString:ELEMENT_GROUP_JUMPS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_THROWS]
		) {
		theDigits = [ijsId substringToIndex:1];
	} else {
		theDigits = [ijsId substringFromIndex:[ijsId length]-1];
	}
	return theDigits;
}

- (BOOL)isEligibleForSecondHalfBonus {
	BOOL result = NO;
	if ([elementGroup isEqualToString:ELEMENT_GROUP_JUMPS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_THROWS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_LIFTS]
		|| [elementGroup isEqualToString:ELEMENT_GROUP_TWIST_LIFTS]
		) {
		result = YES;
	}		
	return result;
}

@end
