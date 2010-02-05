//
//  ApplicationUtilities.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Program.h"
#import "ProgramGroup.h"
#import "ProgramElement.h"
#import "Elements.h"
#import "Element.h"

#define APPLICATION_NAME		@"Sk8 Score!"
#define WEB_URL					@"http://cooltoolapps.appspot.com/skate_score"

#define LOAD_SAMPLE_DATA_TO_PUBLISH			0
#define LOAD_TEST_DATA						0
#define LOAD_TEST_DATA_FOR_SOV_VALIDATION	(0 && LOAD_TEST_DATA)

#define ASSERT_BASE_SCORES					(1 && LOAD_TEST_DATA)


#define GOE_plus_1				@"+1"
#define GOE_plus_2				@"+2"
#define GOE_plus_3				@"+3"
#define GOE_0					@"0"
#define GOE_minus_1				@"-1"
#define GOE_minus_2				@"-2"
#define GOE_minus_3				@"-3"
#define JUMP_COMBO_TYPE_SEQ		@"sequence"
#define JUMP_COMBO_TYPE_COMBO	@"combo"

#define TABLE_MAIN_LABEL_TEXT_COLOR				[UIColor colorWithRed:0.75 green:0.0 blue:0.0 alpha:1.0]
#define TABLE_MAIN_LABEL_HIGHLIGHT_TEXT_COLOR	[UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0]

#define TABLE_SUB_LABEL_TEXT_COLOR				[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0]
#define TABLE_SUB_LABEL_HIGHLIGHT_TEXT_COLOR	[UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0]

#define fequal(a,b) (fabs((a) - (b)) < .0001 /*FLT_EPSILON*/)

@interface ApplicationUtilities : NSObject {

}

+(void)setupStandardTableLookFor:(UITableView *)tableView inView:(UIView *)aView;
+(void)setGeneralViewLookFor:(UIView *)aView ;
+(void)setGeneralButtonLookFor:(UIButton *)aButton;

+(UIView *)getStandardTableSectionHeaderFor:(UITableView *)tableView with:(NSString *)description;

@end
