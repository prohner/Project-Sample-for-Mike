//
//  Elements.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Elements.h"
#import "Element.h"

@implementation Elements

static NSMutableDictionary *elements = nil;
//+ (NSDictionary *)elements { 
//	if ([elements class] != [NSDictionary class]) {
//		elements = [[NSDictionary alloc] init];
//		[self initializeElements];
//	}
//	return elements; 
//}

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
		   minus_3:(float)minus_3 {
	
	Element *newElement = [[Element alloc] init];
	
	newElement.ijsId  = ijsId ;
	newElement.discipline  = discipline ;
	newElement.elementGroup = elementGroup;
	newElement.description = description;
	newElement.baseScore = baseScore;
	newElement.plus_1	 = plus_1	;
	newElement.plus_2	 = plus_2	;
	newElement.plus_3	 = plus_3	;
	newElement.minus_1	 = minus_1	;
	newElement.minus_2	 = minus_2	;
	newElement.minus_3 = minus_3;

	[elements setValue:newElement forKey:newElement.ijsId];
}

+ (Element *)getElementFor:(NSString*)ijsId {
	[self checkElementsArray];
	return (Element *)[[elements valueForKey:ijsId] retain];
}

+ (NSArray *)groupOfElements:(NSString *)elementGroup {
	NSMutableArray *theElements = [[NSMutableArray alloc] init];
	for (Element *element in elements) {
		if ([element.elementGroup isEqualToString:elementGroup]) {
			[theElements addObject:element];
		}
	}
	return theElements;
}

+ (void)checkElementsArray {
	if (elements == nil) {
		elements = [[NSMutableDictionary alloc] init];
		[self initializeElements];
	}
}


+ (NSArray *)groupOfUniqueElementsIn:(NSString *)elementGroup {
	[self checkElementsArray];
	NSMutableSet *theElements = [[NSMutableSet alloc] init];
	for (id ijsId in elements) {
		Element *element = [self getElementFor:ijsId];
		if ([element.elementGroup isEqualToString:elementGroup]) {
			NSString *ijs;
			NSString *desc;
			if ([element.elementGroup isEqualToString:ELEMENT_GROUP_JUMPS]) {
				ijs = [element.ijsId substringFromIndex:1];
				desc = [element.description stringByReplacingOccurrencesOfString:@"Double " withString:@""];
				desc = [desc stringByReplacingOccurrencesOfString:@"Triple " withString:@""];
				desc = [desc stringByReplacingOccurrencesOfString:@"Quad " withString:@""];
			} else {
				ijs = [element.ijsId substringToIndex:[element.ijsId length]-1];
				desc = [element.description stringByReplacingOccurrencesOfString:@" Level 1" withString:@""];
				desc = [desc stringByReplacingOccurrencesOfString:@" Level 2" withString:@""];
				desc = [desc stringByReplacingOccurrencesOfString:@" Level 3" withString:@""];
				desc = [desc stringByReplacingOccurrencesOfString:@" Level 4" withString:@""];
			}
			[theElements addObject:[[NSString alloc] initWithFormat:@"%@-%@", desc, ijs]];
		}
	}
	return [theElements allObjects];
}

+ (void)initializeElements {
	[Elements addElement:@"1T" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Toeloop" baseScore:0.4 plus_1:0.3 plus_2:0.3 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1S" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Salchow" baseScore:0.4 plus_1:0.3 plus_2:0.3 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1Lo" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Loop" baseScore:0.5 plus_1:0.3 plus_2:0.3 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1F" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Flip" baseScore:0.5 plus_1:0.3 plus_2:0.3 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1Lz" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Lutz" baseScore:0.6 plus_1:0.3 plus_2:0.3 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1A" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Axel" baseScore:0.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.2 minus_2:-0.4 minus_3:-0.5];
	[Elements addElement:@"2T" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Toeloop" baseScore:1.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2S" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Salchow" baseScore:1.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Lo" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Loop" baseScore:1.5 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2F" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Flip" baseScore:1.7 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Lz" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Lutz" baseScore:1.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2A" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Axel" baseScore:3.5 plus_1:1 plus_2:1 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3T" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Toeloop" baseScore:4 plus_1:1 plus_2:1 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3S" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Salchow" baseScore:4.5 plus_1:1 plus_2:1 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3Lo" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Loop" baseScore:5 plus_1:1 plus_2:1 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3F" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Flip" baseScore:5.5 plus_1:1 plus_2:1 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3Lz" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Lutz" baseScore:6 plus_1:1 plus_2:1 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3A" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Axel" baseScore:8.2 plus_1:1 plus_2:1 plus_3:3 minus_1:-1.4 minus_2:-2.8 minus_3:-4.2];
	[Elements addElement:@"4T" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Toeloop" baseScore:9.8 plus_1:1 plus_2:1 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4S" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Salchow" baseScore:10.3 plus_1:1 plus_2:1 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4Lo" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Loop" baseScore:10.8 plus_1:1 plus_2:1 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4F" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Flip" baseScore:11.3 plus_1:1 plus_2:1 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4Lz" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Lutz" baseScore:11.8 plus_1:1 plus_2:1 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4A" discipline:@"singles" elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Axel" baseScore:13.3 plus_1:1 plus_2:1 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"USp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 1" baseScore:1.2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 2" baseScore:1.5 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 3" baseScore:1.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 4" baseScore:2.4 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 1" baseScore:1.5 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 2" baseScore:1.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 4" baseScore:2.7 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 1" baseScore:1.4 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 2" baseScore:1.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 3" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 4" baseScore:2.6 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 1" baseScore:1.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 2" baseScore:1.6 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 3" baseScore:2.1 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 4" baseScore:2.5 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 1" baseScore:1.7 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 2" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 4" baseScore:2.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 1" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 2" baseScore:2.4 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 3" baseScore:2.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 1" baseScore:1.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 3" baseScore:2.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 1" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 3" baseScore:2.6 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 4" baseScore:3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 1" baseScore:1.7 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 2" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 4" baseScore:2.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 1" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 2" baseScore:2.4 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 3" baseScore:2.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 1" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 3" baseScore:2.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 1" baseScore:1.9 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 3" baseScore:2.6 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 4" baseScore:3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 1" baseScore:1.7 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 2" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 3" baseScore:2.5 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 4" baseScore:3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp1" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 1" baseScore:2 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp2" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 2" baseScore:2.5 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp3" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 3" baseScore:3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp4" discipline:@"singles" elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 4" baseScore:3.5 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt1" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 1" baseScore:1.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt2" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt3" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 3" baseScore:3.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SlSt4" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 4" baseScore:3.9 plus_1:1 plus_2:1 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"CiSt1" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 1" baseScore:1.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CiSt2" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CiSt3" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 3" baseScore:3.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"CiSt4" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 4" baseScore:3.9 plus_1:1 plus_2:1 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SeSt1" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 1" baseScore:1.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SeSt2" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SeSt3" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 3" baseScore:3.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SeSt4" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 4" baseScore:3.9 plus_1:1 plus_2:1 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SpSq1" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 1" baseScore:1.8 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SpSq2" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 2" baseScore:2.3 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SpSq3" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 3" baseScore:3.1 plus_1:0.5 plus_2:0.5 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SpSq4" discipline:@"singles" elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 4" baseScore:3.4 plus_1:1 plus_2:1 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	
}

@end
