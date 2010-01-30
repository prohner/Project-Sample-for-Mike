//
//  Program.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Program.h"
#import "ProgramElement.h"
#import "Elements.h"
#import "ApplicationUtilities.h"

@implementation Program

@synthesize description, programGroup, ordinalPosition;

-(NSMutableArray *)programElements {
	return [[self findRelated:[ProgramElement class] filter:@"1 = 1 order by ordinal_position"] mutableCopy];
}

-(ScoreSet)programScore {
	ScoreSet scores;
	scores.baseScore = 0;
	scores.scoreWithGOE = 0;
	scores.elementsInProgram = 0;
	scores.rangeMinimumScore = 0;
	scores.rangeMaximumScore = 0;

	NSArray *programElements = [self programElements];
	if ([programElements count] > 0) {
		for (ProgramElement *programElement in programElements) {
			NSString *goe = programElement.estimatedGOE;
			
			float baseScore = programElement.baseScore;

			scores.baseScore += baseScore;
			scores.scoreWithGOE += baseScore;
			scores.scoreWithGOE += [programElement scoreForGOE:goe];
			
			scores.rangeMinimumScore += baseScore;
			scores.rangeMaximumScore += baseScore;

			scores.rangeMinimumScore += [programElement scoreForGOE:GOE_minus_3];
			scores.rangeMaximumScore += [programElement scoreForGOE:GOE_plus_3];

			scores.elementsInProgram++;
		}
	}
	return scores;
}

- (NSString *)programSubDescription {
	NSString *subDescription = @"No elements in this program.";
	ScoreSet scores = [self programScore];

	if (scores.elementsInProgram > 0) {
		subDescription = [NSString stringWithFormat:@"Base score: %.2f\nWith GOEs: %.2f", scores.baseScore, scores.scoreWithGOE];
	}

	return subDescription;
}

-(int)elementsInHalf:(BOOL)firstHalf {
	NSString *filter = [[NSString alloc] initWithFormat:@" is_second_half = %d", (firstHalf ? 0 : 1)];
	NSArray *programElements = [self findRelated:[ProgramElement class] filter:filter];
	return [programElements count];
}

+(NSArray *)transients
{
	return [NSArray arrayWithObject:@"programSubDescription"];
}

@end
