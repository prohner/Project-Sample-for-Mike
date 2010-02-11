//
//  Elements.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Element.h"

#define DISCIPLINE_SINGLES					@"singles"
#define DISCIPLINE_PAIRS					@"pairs"

#define ELEMENT_GROUP_JUMPS					@"jumps"
#define ELEMENT_GROUP_SPINS					@"spins"
#define ELEMENT_GROUP_STEP_SPIRAL			@"spiral/step"
#define ELEMENT_GROUP_DEATH_SPIRALS			@"death spirals"
#define ELEMENT_GROUP_LIFTS					@"lifts"
#define ELEMENT_GROUP_PAIR_SPINS			@"pair spins"
#define ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS	@"side by side jumps"
#define ELEMENT_GROUP_SIDE_BY_SIDE_SPINS	@"side by side spins"
#define ELEMENT_GROUP_THROWS				@"throws"
#define ELEMENT_GROUP_TWIST_LIFTS			@"twist lifts"


@interface Elements : NSObject {
//	static (NSDictionary *)elements;
}

+ (void)addElement:(NSString*)ijsId 
		discipline:(NSString*)discipline 
	  elementGroup:(NSString*)elementGroup 
	   description:(NSString*)description
		 baseScore:(float)baseScore
			plus_1:(float)plus_1
			plus_2:(float)plus_2
			plus_3:(float)plus_3
		   minus_1:(float)minus_1
		   minus_2:(float)minus_2
		   minus_3:(float)minus_3;
+ (void)checkElementsArray;
+ (void) initializeElements;
+ (Element *)getElementFor:(NSString*)ijsId inDiscipline:(NSString *)discipline;
+ (NSArray *)groupOfElements:(NSString *)elementGroup inDiscipline:(NSString *)discipline;
+ (NSArray *)groupOfUniqueElementsIn:(NSString *)elementGroup inDiscipline:(NSString *)discipline;
+ (void)loadSinglesElements;
+ (void)loadPairsElements;

@end
