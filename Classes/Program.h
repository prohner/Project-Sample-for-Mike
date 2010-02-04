//
//  Program.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
#import "ProgramGroup.h"

typedef struct ScoreSet {
	float baseScore;
	float scoreWithGOE;
	float rangeMinimumScore;
	float rangeMaximumScore;
	int elementsInProgram;
} ScoreSet;


@interface Program : SQLitePersistentObject {
	NSString *description;
	ProgramGroup *programGroup;
	int ordinalPosition;

	BOOL cachedScoresAreDirty;
	float cached_baseScore;
	float cached_scoreWithGOE;
}

@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) ProgramGroup *programGroup;
@property (nonatomic) int ordinalPosition;
@property (nonatomic) BOOL cachedScoresAreDirty;

-(NSString *)programSubDescription;
-(ScoreSet)programScore;

-(int)elementsInHalf:(BOOL)firstHalf;
-(NSMutableArray *)programElements;

+(NSArray *)transients;

@end
