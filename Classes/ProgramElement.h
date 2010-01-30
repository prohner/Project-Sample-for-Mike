//
//  ProgramElement.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
#import "Program.h"
#import "Element.h"

@interface ProgramElement : SQLitePersistentObject {
	NSString *ijsId;
	int ordinalPosition;
	NSString *estimatedGOE;
	BOOL isSecondHalf;
	
	NSString *ijsIdSecond;
	NSString *ijsIdThird;
	NSString *jumpComboType;

	Program *program;
}

@property (nonatomic, retain) NSString *ijsId;
@property (nonatomic) int ordinalPosition;
@property (nonatomic, retain) NSString *estimatedGOE;
@property (nonatomic) BOOL isSecondHalf;
@property (nonatomic, retain) NSString *jumpComboType;

- (NSString *)description;
- (float) baseScore;
- (float)goeScore;

- (NSComparisonResult)compareProgramElements:(ProgramElement *)pe;
- (float)scoreForGOE:(NSString *)GOE;
-(BOOL)isSingleElement;
- (Element *)elementForGOE;

@property (nonatomic, retain) NSString *ijsIdSecond;
@property (nonatomic, retain) NSString *ijsIdThird;
@property (nonatomic, retain) Program *program;

+(NSArray *)transients;



@end
