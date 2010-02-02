//
//  ProgramElement.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramElement.h"
#import "Elements.h"
#import "ApplicationUtilities.h"

@implementation ProgramElement

@synthesize ijsId, ordinalPosition, estimatedGOE, isSecondHalf, ijsIdSecond, ijsIdThird, program, jumpComboType;

-(NSString *)description {
	NSString *desc;
	if ([self isSingleElement]) {
//		desc = [[NSString alloc] initWithFormat:@"%@ %@", [Elements getElementFor:ijsId].description, ijsId];
		desc = [Elements getElementFor:ijsId].description;
	} else {
//		desc = [[NSString alloc] initWithFormat:@"%@ %@", [Elements getElementFor:ijsId].description, ijsId];;
		desc = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@", 
						 ijsId, 
						 (ijsIdSecond == nil || [ijsIdSecond isEqualToString:@""] ? @"" : @" + "), ijsIdSecond,
						 (ijsIdThird == nil || [ijsIdThird isEqualToString:@""] ? @"" : @" + "), ijsIdThird, 
						 [jumpComboType isEqualToString:JUMP_COMBO_TYPE_COMBO] ? @" Combination" : @" Sequence"];
	}

	return desc;
}

- (NSString *)shortenedDescription {
	NSString *txt = [self description];
//	NSRange r = [txt rangeOfString:@"-"];
//	txt = [txt substringToIndex:r.length];
	txt = [txt stringByReplacingOccurrencesOfString:@"Level " withString:@"L"];
	txt = [txt stringByReplacingOccurrencesOfString:@"Sequence" withString:@"Seq."];
	txt = [txt stringByReplacingOccurrencesOfString:@"Serpentine" withString:@"Serp."];
	
	if ([txt length]) {
		txt = [txt stringByReplacingOccurrencesOfString:@"Spin" withString:@"Sp."];
	}
	return txt;
}


-(BOOL)isSingleElement {
	return ijsIdSecond == nil || [ijsIdSecond isEqualToString:@""];
}

-(float)baseScore {
	float score = 0;
	Element *element1 = [Elements getElementFor:ijsId];
	
	if ([self isSingleElement]) {
		// This is a single element
		score = element1.baseScore;
		
	} else {
		Element *element2 = [Elements getElementFor:ijsIdSecond];
		Element *element3 = [Elements getElementFor:ijsIdThird];
		
		float score1 = 0;
		float score2 = 0;
		float score3 = 0;

		if (element1 != nil) {
			score1 = element1.baseScore;
		}
		if (element2 != nil) {
			score2 = element2.baseScore;
		}
		if (element3 != nil) {
			score3 = element3.baseScore;
		}
		
		if ([jumpComboType isEqualToString:JUMP_COMBO_TYPE_COMBO]) {
			// Jump combo
			score = score1 + score2 + score3;
		} else {
			// Jump sequence - add the two highest scores and multiply by 0.8
			if (score1 > score2 && score1 > score3) {
				// score 1 is highest
				if (score2 > score3) {
					score = score1 + score2;
				} else {
					score = score1 + score3;
				}
			} else if (score2 > score1 && score2 > score3) {
				// score 2 is highest
				if (score1 > score3) {
					score = score2 + score1;
				} else {
					score = score2 + score3;
				}
			} else {
				// score 3 is highest
				if (score2 > score1) {
					score = score3 + score2;
				} else {
					score = score3 + score1;
				}
			}
			score *= 0.8;

		}

	}

	if (isSecondHalf && [element1.elementGroup isEqualToString:ELEMENT_GROUP_JUMPS]) {
		score *= 1.1;
	}

	return score;
}

- (Element *)elementForGOE {
	Element *element;
	if ([self isSingleElement]) {
		element = [Elements getElementFor:ijsId];
	} else {
		Element *element1 = [Elements getElementFor:ijsId];
		Element *element2 = [Elements getElementFor:ijsIdSecond];
		Element *element3 = [Elements getElementFor:ijsIdThird];
		
		if (element1.baseScore > element2.baseScore && element1.baseScore > element3.baseScore) {
			element = element1;
		} else if (element2.baseScore > element3.baseScore) {
			element	= element2;
		} else {
			element = element3;
		}
	}

	return element;
}

- (float)goeScore {
	return [self scoreForGOE:[self estimatedGOE]];
}

- (float)scoreForGOE:(NSString *)GOE {
	float goe_adjustment = 0;

	Element *element = [self elementForGOE];
	
	if ([GOE isEqualToString:GOE_plus_1]) {
		goe_adjustment = element.plus_1;
	} else if ([GOE isEqualToString:GOE_plus_2]) {
		goe_adjustment = element.plus_2;
	} else if ([GOE isEqualToString:GOE_plus_3]) {
		goe_adjustment = element.plus_3;
	} else if ([GOE isEqualToString:GOE_minus_1]) {
		goe_adjustment = element.minus_1;
	} else if ([GOE isEqualToString:GOE_minus_2]) {
		goe_adjustment = element.minus_2;
	} else if ([GOE isEqualToString:GOE_minus_3]) {
		goe_adjustment = element.minus_3;
		
	}
	
	return goe_adjustment;
}

- (NSComparisonResult)compareProgramElements:(ProgramElement *)pe {
	if (ordinalPosition > pe.ordinalPosition) {
        return (NSComparisonResult)NSOrderedDescending;
    }
	
    if (ordinalPosition < pe.ordinalPosition) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
	
}

+(NSArray *)transients
{
	NSArray *transient1 = [NSArray arrayWithObject:@"baseScore"];
	NSArray *transient2 = [NSArray arrayWithObject:@"description"];
	return [NSArray arrayWithObjects:transient1, transient2, nil];
}

@end
