//
//  Element.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Element : NSObject {
	NSString *discipline;
	NSString *elementGroup;
	NSString *description;
	NSString *ijsId;
	float baseScore;
	float plus_1;
	float plus_2;
	float plus_3;
	float minus_1;
	float minus_2;
	float minus_3;
}

@property (nonatomic, retain) NSString *discipline;
@property (nonatomic, retain) NSString *elementGroup;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *ijsId;
@property  float baseScore;
@property  float plus_1;
@property  float plus_2;
@property  float plus_3;
@property  float minus_1;
@property  float minus_2;
@property  float minus_3;

- (float)scoreForGOE:(NSString *)GOE;
- (NSString *)ijsIdLetters;
- (NSString *)ijsIdDigits;
- (BOOL)isEligibleForSecondHalfBonus;

- (BOOL)isSingles;
- (BOOL)isPairs;
- (BOOL)isDance;

@end
