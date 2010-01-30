//
//  Elements.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Element.h"

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
+ (Element *)getElementFor:(NSString*)ijsId;
+ (NSArray *)groupOfElements:(NSString *)elementGroup;
+ (NSArray *)groupOfUniqueElementsIn:(NSString *)elementGroup;

@end
