//
//  Elements.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Elements.h"
#import "Element.h"

NSInteger alphabeticSort(id string1, id string2, void *reverse)
{
    return [string1 localizedCaseInsensitiveCompare:string2];
}


@implementation Elements

static NSMutableDictionary *singles_elements = nil;
static NSMutableDictionary *pairs_elements = nil;
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
	
	newElement.ijsId		= ijsId ;
	newElement.discipline	= discipline ;
	newElement.elementGroup	= elementGroup;
	newElement.description	= description;
	newElement.baseScore	= baseScore;
	newElement.plus_1		= plus_1	;
	newElement.plus_2		= plus_2	;
	newElement.plus_3		= plus_3	;
	newElement.minus_1		= minus_1	;
	newElement.minus_2		= minus_2	;
	newElement.minus_3		= minus_3;

	if ([discipline isEqualToString:DISCIPLINE_SINGLES]) {
		[singles_elements setValue:newElement forKey:newElement.ijsId];
	} else if ([discipline isEqualToString:DISCIPLINE_PAIRS]) {
		[pairs_elements setValue:newElement forKey:newElement.ijsId];
	}

}

+ (NSMutableDictionary *)arrayOfElementsFor:(NSString *)discipline {
	NSMutableDictionary *result = nil;
	if ([discipline isEqualToString:DISCIPLINE_SINGLES]) {
		result = singles_elements;
	} else if ([discipline isEqualToString:DISCIPLINE_PAIRS]) {
		result = pairs_elements;
	}
#ifdef DEBUG
	if (! result) {
		NSLog(@"Hunting for the elements array for \"%@\"", discipline);
	}
#endif
	NSAssert1(result, @"Couldn't find the right kind of elements array for \"%@\".", discipline);
	return result;
}

+ (Element *)getElementFor:(NSString*)ijsId inDiscipline:(NSString *)discipline {
	[self checkElementsArray];
	
	NSMutableDictionary *elements = [self arrayOfElementsFor:discipline];
	return (Element *)[[elements valueForKey:ijsId] retain];
}

+ (NSArray *)groupOfElements:(NSString *)elementGroup inDiscipline:(NSString *)discipline {
	[self checkElementsArray];

	NSMutableDictionary *elements = [self arrayOfElementsFor:discipline];
	
	NSMutableArray *theElements = [[NSMutableArray alloc] init];
	for (NSString *ijsId in elements) {
		Element *element = [self getElementFor:ijsId inDiscipline:discipline];
		if ([element.elementGroup isEqualToString:elementGroup]) {
			[theElements addObject:element];
		}
	}
	return theElements;
}

+ (void)checkElementsArray {
	if (singles_elements == nil) {
		[self initializeElements];
	}
}


+ (NSArray *)groupOfUniqueElementsIn:(NSString *)elementGroup inDiscipline:(NSString *)discipline {
	[self checkElementsArray];

	NSMutableDictionary *elements = [self arrayOfElementsFor:discipline];

	NSMutableSet *theElements = [[NSMutableSet alloc] init];
	for (id ijsId in elements) {
		Element *element = [self getElementFor:ijsId inDiscipline:discipline];
		if ([element.elementGroup isEqualToString:elementGroup]) {
			NSString *ijs;
			NSString *desc;
			if ([element.elementGroup isEqualToString:ELEMENT_GROUP_JUMPS] 
				|| [element.elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS] 
				|| [element.elementGroup isEqualToString:ELEMENT_GROUP_THROWS] 
				) {
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
			[theElements addObject:[[NSString alloc] initWithFormat:@"%@^%@", desc, ijs]];
		}
	}
	return [[theElements allObjects] sortedArrayUsingFunction:alphabeticSort context:nil];
}

+ (void)initializeElements {
	// TODO Figure out how to load the elements from only the needed discipline
	singles_elements = [[NSMutableDictionary alloc] init];
	pairs_elements = [[NSMutableDictionary alloc] init];
	[self loadSinglesElements];
	[self loadPairsElements];
}

+ (void)loadPairsElements {
	[Elements addElement:@"1T" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Toeloop" baseScore:0.4 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1S" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Salchow" baseScore:0.4 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1Lo" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Loop" baseScore:0.5 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1F" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Flip" baseScore:0.5 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1Lz" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Lutz" baseScore:0.6 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1A" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Axel" baseScore:0.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.2 minus_2:-0.4 minus_3:-0.5];
	[Elements addElement:@"2T" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Double Toeloop" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2S" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Double Salchow" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Lo" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Double Loop" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2F" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Double Flip" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Lz" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Double Lutz" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2A" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Double Axel" baseScore:3.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3T" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Triple Toeloop" baseScore:4 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3S" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Triple Salchow" baseScore:4.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3Lo" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Triple Loop" baseScore:5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3F" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Triple Flip" baseScore:5.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3Lz" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Triple Lutz" baseScore:6 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3A" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Triple Axel" baseScore:8.2 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.4 minus_2:-2.8 minus_3:-4.2];
	[Elements addElement:@"4T" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Quad Toeloop" baseScore:9.8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4S" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Quad Salchow" baseScore:10.3 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4Lo" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Quad Loop" baseScore:10.8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4F" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Quad Flip" baseScore:11.3 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4Lz" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Quad Lutz" baseScore:11.8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4A" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS description:@"Quad Axel" baseScore:13.3 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"USp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Upright Spin Level 1" baseScore:1.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Upright Spin Level 2" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Upright Spin Level 3" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Upright Spin Level 4" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Layback Spin Level 1" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Layback Spin Level 2" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Layback Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Layback Spin Level 4" baseScore:2.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Camel Spin Level 1" baseScore:1.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Camel Spin Level 2" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Camel Spin Level 3" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Camel Spin Level 4" baseScore:2.6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Sit Spin Level 1" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Sit Spin Level 2" baseScore:1.6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Sit Spin Level 3" baseScore:2.1 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Sit Spin Level 4" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Upright Spin Level 1" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Upright Spin Level 2" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Upright Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Upright Spin Level 4" baseScore:2.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Layback Spin Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Layback Spin Level 2" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Layback Spin Level 3" baseScore:2.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Layback Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Camel Spin Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Camel Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Camel Spin Level 3" baseScore:2.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Camel Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Sit Spin Level 1" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Sit Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Sit Spin Level 3" baseScore:2.6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Change Foot Sit Spin Level 4" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos Not Foot Level 1" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos Not Foot Level 2" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos Not Foot Level 3" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos Not Foot Level 4" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos & Foot Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos & Foot Level 2" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos & Foot Level 3" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS description:@"Spin Combo Chg Pos & Foot Level 4" baseScore:3.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Seq Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Seq Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Seq Level 3" baseScore:3.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SlSt4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Seq Level 4" baseScore:3.9 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"CiSt1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Seq Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CiSt2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Seq Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CiSt3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Seq Level 3" baseScore:3.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"CiSt4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Seq Level 4" baseScore:3.9 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SeSt1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Seq Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SeSt2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Seq Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SeSt3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Seq Level 3" baseScore:3.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SeSt4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Seq Level 4" baseScore:3.9 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SpSq1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SpSq2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SpSq3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 3" baseScore:3.1 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SpSq4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 4" baseScore:3.4 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"1Li1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 1 Level 1" baseScore:1.1 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1Li2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 1 Level 2" baseScore:1.3 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1Li3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 1 Level 3" baseScore:1.5 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1Li4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 1 Level 4" baseScore:1.7 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Li1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 2 Level 1" baseScore:1.3 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Li2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 2 Level 2" baseScore:1.7 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Li3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 2 Level 3" baseScore:2.4 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Li4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 2 Level 4" baseScore:3 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"3Li1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 3 Level 1" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"3Li2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 3 Level 2" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"3Li3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 3 Level 3" baseScore:3.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"3Li4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 3 Level 4" baseScore:4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"4Li1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 4 Level 1" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"4Li2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 4 Level 2" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"4Li3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 4 Level 3" baseScore:3.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"4Li4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 4 Level 4" baseScore:4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5TLi1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Toe Lasso Level 1" baseScore:4.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5TLi2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Toe Lasso Level 2" baseScore:5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5TLi3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Toe Lasso Level 3" baseScore:5.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5TLi4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Toe Lasso Level 4" baseScore:6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5SLi1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Step in Lasso Level 1" baseScore:4.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5SLi2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Step in Lasso Level 2" baseScore:5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5SLi3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Step in Lasso Level 3" baseScore:5.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5SLi4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Step in Lasso Level 4" baseScore:6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.5 minus_2:-1 minus_3:-1.5];
	[Elements addElement:@"5RLi1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Reverse Lasso Level 1" baseScore:5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"5RLi2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Reverse Lasso Level 2" baseScore:5.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"5RLi3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Reverse Lasso Level 3" baseScore:6 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"5RLi4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Reverse Lasso Level 4" baseScore:6.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"5ALi1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Axel Lasso Level 1" baseScore:5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"5ALi2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Axel Lasso Level 2" baseScore:5.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"5ALi3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Axel Lasso Level 3" baseScore:6 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"5ALi4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_LIFTS description:@"Group 5 Axel Lasso Level 4" baseScore:6.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"1TTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Toeloop Level 1" baseScore:1.1 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1TTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Toeloop Level 2" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1TTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Toeloop Level 3" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1TTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Toeloop Level 4" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2TTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Toeloop Level 1" baseScore:2.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2TTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Toeloop Level 2" baseScore:3.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2TTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Toeloop Level 3" baseScore:3.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2TTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Toeloop Level 4" baseScore:4.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"3TTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Toeloop Level 1" baseScore:4.7 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3TTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Toeloop Level 2" baseScore:5.2 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3TTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Toeloop Level 3" baseScore:5.7 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3TTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Toeloop Level 4" baseScore:6.2 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"4TTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Toeloop Level 1" baseScore:6.2 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4TTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Toeloop Level 2" baseScore:6.7 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4TTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Toeloop Level 3" baseScore:7.2 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4TTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Toeloop Level 4" baseScore:7.7 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"1LzTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Lutz/Flip Level 1" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1LzTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Lutz/Flip Level 2" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1LzTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Lutz/Flip Level 3" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1LzTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Lutz/Flip Level 4" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2LzTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Lutz/Flip Level 1" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2LzTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Lutz/Flip Level 2" baseScore:3.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2LzTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Lutz/Flip Level 3" baseScore:4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2LzTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Lutz/Flip Level 4" baseScore:4.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"3LzTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Lutz/Flip Level 1" baseScore:5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3LzTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Lutz/Flip Level 2" baseScore:5.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3LzTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Lutz/Flip Level 3" baseScore:6 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3LzTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Lutz/Flip Level 4" baseScore:6.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"4LzTw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Lutz/Flip Level 1" baseScore:6.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4LzTw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Lutz/Flip Level 2" baseScore:7 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4LzTw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Lutz/Flip Level 3" baseScore:7.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4LzTw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Lutz/Flip Level 4" baseScore:8 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"1ATw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Axel Level 1" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1ATw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Axel Level 2" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1ATw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Axel Level 3" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1ATw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Single Axel Level 4" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2ATw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Axel Level 1" baseScore:3.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2ATw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Axel Level 2" baseScore:3.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2ATw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Axel Level 3" baseScore:4.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2ATw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Double Axel Level 4" baseScore:4.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"3ATw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Axel Level 1" baseScore:5.3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3ATw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Axel Level 2" baseScore:5.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3ATw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Axel Level 3" baseScore:6.3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"3ATw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Triple Axel Level 4" baseScore:6.8 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"4ATw1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Axel Level 1" baseScore:5.3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4ATw2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Axel Level 2" baseScore:5.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4ATw3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Axel Level 3" baseScore:6.3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4ATw4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_TWIST_LIFTS description:@"Quad Axel Level 4" baseScore:6.8 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"1TTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Toeloop" baseScore:1.2 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1STh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Salchow" baseScore:1.2 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1LoTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Loop" baseScore:1.5 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1FTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Flip/Lutz" baseScore:1.5 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"1ATh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Axel" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2TTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Double Toeloop" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2STh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Double Salchow" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2LoTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Double Loop" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2FTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Double Flip/Lutz" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2ATh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Double Axel" baseScore:4 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3TTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Triple Toeloop" baseScore:4.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3STh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Triple Salchow" baseScore:4.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3LoTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Triple Loop" baseScore:5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3FTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Triple Flip/Lutz" baseScore:5.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3ATh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Triple Axel" baseScore:7.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4TTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Quad Toeloop" baseScore:8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4STh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Quad Salchow" baseScore:8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4LoTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Quad Loop" baseScore:8.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"4FTh" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_THROWS description:@"Quad Flip/Lutz" baseScore:9 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"FiDs1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward inside Level 1" baseScore:2.8 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"FiDs2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward inside Level 2" baseScore:3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"FiDs3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward inside Level 3" baseScore:3.2 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"FiDs4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward inside Level 4" baseScore:3.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BiDs1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward inside Level 1" baseScore:2.8 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BiDs2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward inside Level 2" baseScore:3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BiDs3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward inside Level 3" baseScore:3.2 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BiDs4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward inside Level 4" baseScore:3.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"FoDs1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward outside Level 1" baseScore:3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"FoDs2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward outside Level 2" baseScore:3.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"FoDs3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward outside Level 3" baseScore:4 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"FoDs4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Forward outside Level 4" baseScore:4.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BoDs1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward outside Level 1" baseScore:3 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BoDs2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward outside Level 2" baseScore:3.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BoDs3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward outside Level 3" baseScore:4 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"BoDs4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_DEATH_SPIRALS description:@"Backward outside Level 4" baseScore:4.5 plus_1:0.7 plus_2:1.4 plus_3:2 minus_1:-0.7 minus_2:-1.4 minus_3:-2];
	[Elements addElement:@"PSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Spin Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"PSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Spin Level 2" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"PSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Spin Level 3" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"PSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Spin Level 4" baseScore:3.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"PCoSp1" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Combination Level 1" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"PCoSp2" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Combination Level 2" baseScore:3.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"PCoSp3" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Combination Level 3" baseScore:4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"PCoSp4" discipline:DISCIPLINE_PAIRS  elementGroup:ELEMENT_GROUP_PAIR_SPINS description:@"Pair Combination Level 4" baseScore:4.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	
}

+ (void)loadSinglesElements {
	// Replace this whole method with the elements to add
	[Elements addElement:@"1T" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Toeloop" baseScore:0.4 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1S" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Salchow" baseScore:0.4 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1Lo" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Loop" baseScore:0.5 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1F" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Flip" baseScore:0.5 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1Lz" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Lutz" baseScore:0.6 plus_1:0.3 plus_2:0.6 plus_3:1 minus_1:-0.1 minus_2:-0.2 minus_3:-0.3];
	[Elements addElement:@"1A" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Axel" baseScore:0.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.2 minus_2:-0.4 minus_3:-0.5];
	[Elements addElement:@"2T" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Toeloop" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2S" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Salchow" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Lo" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Loop" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2F" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Flip" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2Lz" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Lutz" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"2A" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Double Axel" baseScore:3.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"3T" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Toeloop" baseScore:4 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3S" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Salchow" baseScore:4.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3Lo" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Loop" baseScore:5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3F" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Flip" baseScore:5.5 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3Lz" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Lutz" baseScore:6 plus_1:1 plus_2:2 plus_3:3 minus_1:-1 minus_2:-2 minus_3:-3];
	[Elements addElement:@"3A" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Triple Axel" baseScore:8.2 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.4 minus_2:-2.8 minus_3:-4.2];
	[Elements addElement:@"4T" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Toeloop" baseScore:9.8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4S" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Salchow" baseScore:10.3 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4Lo" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Loop" baseScore:10.8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4F" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Flip" baseScore:11.3 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4Lz" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Lutz" baseScore:11.8 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"4A" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_JUMPS description:@"Quad Axel" baseScore:13.3 plus_1:1 plus_2:2 plus_3:3 minus_1:-1.6 minus_2:-3.2 minus_3:-4.8];
	[Elements addElement:@"USp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 1" baseScore:1.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 2" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 3" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"USp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Upright Spin Level 4" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 1" baseScore:1.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 2" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"LSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Layback Spin Level 4" baseScore:2.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 1" baseScore:1.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 2" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 3" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Camel Spin Level 4" baseScore:2.6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 1" baseScore:1.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 2" baseScore:1.6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 3" baseScore:2.1 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Sit Spin Level 4" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 1" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 2" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FUSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Upright Spin Level 4" baseScore:2.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 2" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 3" baseScore:2.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FLSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Layback Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 1" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 3" baseScore:2.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FCSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Camel Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 3" baseScore:2.6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"FSSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Flying Sit Spin Level 4" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 1" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 2" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 3" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CUSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Upright Spin Level 4" baseScore:2.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 2" baseScore:2.4 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 3" baseScore:2.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CLSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Layback Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 3" baseScore:2.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Camel Spin Level 4" baseScore:3.2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 1" baseScore:1.9 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 3" baseScore:2.6 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CSSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Change Foot Sit Spin Level 4" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 1" baseScore:1.7 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 2" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 3" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CoSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Pos. Chg. Level 4" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 1" baseScore:2 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 2" baseScore:2.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 3" baseScore:3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CCoSp4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_SPINS description:@"Spin w/ Foot & Pos. Chg. Level 4" baseScore:3.5 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SlSt3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 3" baseScore:3.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SlSt4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Straight Line Step Sequence Level 4" baseScore:3.9 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"CiSt1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CiSt2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"CiSt3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 3" baseScore:3.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"CiSt4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Circular Step Sequence Level 4" baseScore:3.9 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SeSt1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SeSt2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SeSt3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 3" baseScore:3.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SeSt4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Serpentine Step Sequence Level 4" baseScore:3.9 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SpSq1" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 1" baseScore:1.8 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SpSq2" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 2" baseScore:2.3 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.3 minus_2:-0.6 minus_3:-1];
	[Elements addElement:@"SpSq3" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 3" baseScore:3.1 plus_1:0.5 plus_2:1 plus_3:1.5 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	[Elements addElement:@"SpSq4" discipline:DISCIPLINE_SINGLES elementGroup:ELEMENT_GROUP_STEP_SPIRAL description:@"Spiral Sequence (Circular, Serpentine) Level 4" baseScore:3.4 plus_1:1 plus_2:2 plus_3:3 minus_1:-0.7 minus_2:-1.4 minus_3:-2.1];
	
	
	
}

@end
