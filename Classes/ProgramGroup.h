//
//  ProgramGroup.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface ProgramGroup : SQLitePersistentObject {
	NSString * description;
	int ordinalPosition;

}

@property (nonatomic, retain) NSString * description;
@property (nonatomic) int ordinalPosition;

@end
