//
//  RootViewController.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ApplicationUtilities.h"
#import "ProgramElementsViewController.h"
#import "ProgramDetailViewController.h"
#import "ProgramGroupViewController.h"

#define PROGRAMS_DECORATIVE_IMAGE	@"skate.png"

@implementation RootViewController

@synthesize imageView, tableView, btnShareAppWithFriend, btnFeedback, btnOrganizeProgramGroups, myTableFooterView;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = APPLICATION_NAME;
	
    // Set up the buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																			   target:self 
																			   action:@selector(addProgram)];
    self.navigationItem.rightBarButtonItem = addButton;

	NSArray *testProgramGroups = [[ProgramGroup findByCriteria: @"WHERE 1 = 1"] retain];

	if ([testProgramGroups count] == 0) {
		[self fabricateData];
	}
	[testProgramGroups release];
	
#if LOAD_SAMPLE_DATA_TO_PUBLISH
	int elementOrdinal = 0;
	ProgramGroup *pg1 = [[ProgramGroup alloc] init];
	pg1.description = @"2010 Programs";
	pg1.ordinalPosition = 0;
	[pg1 save];
	
	ProgramGroup *pg2 = [[ProgramGroup alloc] init];
	pg2.description = @"Old Programs";
	pg2.ordinalPosition = 1;
	[pg2 save];
	
	Program *p1 = [[Program alloc] init];
	p1.description = @"Long";
	p1.programGroup = pg1;
	p1.ordinalPosition = 0;
	[p1 save];
	
	[self addTo:p1	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_3	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2Lz"	ijsIdSecond:@"2T"	ijsIdThird:@"1Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"1S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"SpSq4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"LSp1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2F"		ijsIdSecond:@"1T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2Lz"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"FSSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	
	Program *p2 = [[Program alloc] init];
	p2.description = @"Short";
	p2.programGroup = pg1;
	p2.ordinalPosition = 1;
	[p2 save];
	[self addTo:p2	ijsId:@"2Lz"	ijsIdSecond:@"2Lo"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"1A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"2F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"SpSq4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_2	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"LSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
	
	Program *p3 = [[Program alloc] init];
	p3.description = @"Adult Gold Free Skate";
	p3.programGroup = pg2;
	p3.ordinalPosition = 2;
	[p3 save];

	[self addTo:p3	ijsId:@"1A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"SSp2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"1F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"CCoSp1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"1Lz"	ijsIdSecond:@"1Lo"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"1A"		ijsIdSecond:@"1T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"2S"		ijsIdSecond:@"1T"	ijsIdThird:@"1Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"SlSt1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"2S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_3	inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"LSp1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	
#endif
	
#if LOAD_TEST_DATA
	if (1 == 1) {
		ProgramGroup *pg1 = [[ProgramGroup alloc] init];
		pg1.description = @"2010 Programs";
		pg1.ordinalPosition = 0;
		[pg1 save];

		ProgramGroup *pg2 = [[ProgramGroup alloc] init];
		pg2.description = @"Old Programs";
		pg2.ordinalPosition = 1;
		[pg2 save];
		
		Program *p1 = [[Program alloc] init];
		p1.description = @"Long";
		p1.programGroup = pg1;
		p1.ordinalPosition = 0;
		[p1 save];
		
		Program *p2 = [[Program alloc] init];
		p2.description = @"Short";
		p2.programGroup = pg1;
		p2.ordinalPosition = 1;
		[p2 save];

		Program *p3 = [[Program alloc] init];
		p3.description = @"Adult Gold Free Skate";
		p3.programGroup = pg2;
		p3.ordinalPosition = 2;
		[p3 save];
		
		ProgramElement *pe1 = [[ProgramElement alloc] init];
		pe1.ijsId				= @"2T";
		pe1.ordinalPosition		= 0;
		pe1.estimatedGOE		= GOE_plus_1;
		pe1.program				= p1;
		pe1.isSecondHalf		= NO;
		[pe1 save];
		
		ProgramElement *pe2 = [[ProgramElement alloc] init];
		pe2.ijsId				= @"LSp2";
		pe2.ordinalPosition		= 1;
		pe2.estimatedGOE		= GOE_0;
		pe2.program				= p1;
		pe2.isSecondHalf		= NO;
		[pe2 save];
		
		ProgramElement *pe3 = [[ProgramElement alloc] init];
		pe3.ijsId				= @"1A";
		pe3.ordinalPosition		= 2;
		pe3.estimatedGOE		= GOE_minus_1;
		pe3.program				= p1;
		pe3.isSecondHalf		= YES;
		[pe3 save];
		
		ProgramElement *pe4 = [[ProgramElement alloc] init];
		pe4.ijsId				= @"SSp2";
		pe4.ordinalPosition		= 3;
		pe4.estimatedGOE		= GOE_plus_2;
		pe4.program				= p1;
		pe4.isSecondHalf		= YES;
		[pe4 save];
		
		ProgramElement *pe5 = [[ProgramElement alloc] init];
		pe5.ijsId				= @"2Lz";
		pe5.ordinalPosition		= 4;
		pe5.estimatedGOE		= GOE_plus_2;
		pe5.program				= p1;
		pe5.isSecondHalf		= YES;
		[pe5 save];

		ProgramElement *pe6 = [[ProgramElement alloc] init];
		pe6.ijsId				= @"2F";
		pe6.ordinalPosition		= 0;
		pe6.estimatedGOE		= GOE_plus_1;
		pe6.program				= p3;
		pe6.isSecondHalf		= NO;
		[pe6 save];
		
		ProgramElement *pe7 = [[ProgramElement alloc] init];
		pe7.ijsId				= @"SSp1";
		pe7.ordinalPosition		= 0;
		pe7.estimatedGOE		= GOE_0;
		pe7.program				= p3;
		pe7.isSecondHalf		= YES;
		[pe7 save];
		
		ProgramGroup *programGroupNationals = [[ProgramGroup alloc] init];
		programGroupNationals.description = @"2010 US Championships";
		programGroupNationals.ordinalPosition = 3;
		[programGroupNationals save];

		int elementOrdinal = 0;
		
		Program *programLK = [[Program alloc] init];
		programLK.description = @"Leah Keiser";
		programLK.programGroup = programGroupNationals;
		programLK.ordinalPosition = 0;
		[programLK save];
		elementOrdinal = 0;

		[self addTo:programLK	ijsId:@"3S"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"3Lz"	ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@"2Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"FSSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"3Lz"	ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"LSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"SpSq2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"3F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"3S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programLK	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		

		Program *programAC = [[Program alloc] init];
		programAC.description = @"Ashley Cain";
		programAC.programGroup = programGroupNationals;
		programAC.ordinalPosition = 0;
		[programAC save];
		elementOrdinal = 0;
		
		[self addTo:programAC	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@"2Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"3S"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"FSSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"3Lo"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"SpSq4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_2	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"3S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"CoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"2Lz"	ijsIdSecond:@"2Lo"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAC	ijsId:@"CCoSp2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];

		Program *programKK = [[Program alloc] init];
		programKK.description = @"Katarina Kulgeyko";
		programKK.programGroup = programGroupNationals;
		programKK.ordinalPosition = 0;
		[programKK save];
		elementOrdinal = 0;
		
		[self addTo:programKK	ijsId:@"FSSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"3S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"3T"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"1F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"LSp2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"3S"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@"2Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"SlSt3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programKK	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];

		Program *programCH = [[Program alloc] init];
		programCH.description = @"Courtney Hicks";
		programCH.programGroup = programGroupNationals;
		programCH.ordinalPosition = 0;
		[programCH save];
		elementOrdinal = 0;
		
		[self addTo:programCH	ijsId:@"3S"		ijsIdSecond:@"2A"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_SEQ	estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"CoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"2Lz"	ijsIdSecond:@"2T"	ijsIdThird:@"2Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"FCSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"2F"		ijsIdSecond:@"1T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"3S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"3F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"SlSt3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCH	ijsId:@"CCoSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		
		Program *programRK = [[Program alloc] init];
		programRK.description = @"Renee Kono";
		programRK.programGroup = programGroupNationals;
		programRK.ordinalPosition = 0;
		[programRK save];
		elementOrdinal = 0;
		
		[self addTo:programRK	ijsId:@"FSSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"3T"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"SpSq2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"2F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"CoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"2Lz"	ijsIdSecond:@"2Lo"	ijsIdThird:@"2T"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"2T"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programRK	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		
		Program *programCT = [[Program alloc] init];
		programCT.description = @"Courtney Taylor";
		programCT.programGroup = programGroupNationals;
		programCT.ordinalPosition = 0;
		[programCT save];
		elementOrdinal = 0;
		
		[self addTo:programCT	ijsId:@"3T"		ijsIdSecond:@"2T"	ijsIdThird:@"2T"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"2A"		ijsIdSecond:@"1T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"3S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"LSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"3T"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"SpSq4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"2F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programCT	ijsId:@"FSSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];

		Program *programAK = [[Program alloc] init];
		programAK.description = @"Abby Kimmelman";
		programAK.programGroup = programGroupNationals;
		programAK.ordinalPosition = 0;
		[programAK save];
		elementOrdinal = 0;
		
		[self addTo:programAK	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_3	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"2Lz"	ijsIdSecond:@"2T"	ijsIdThird:@"1Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"1S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"SpSq4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"LSp1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"2F"		ijsIdSecond:@"1T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"2Lz"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAK	ijsId:@"FSSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		
		Program *programNR = [[Program alloc] init];
		programNR.description = @"Nicole Rajic";
		programNR.programGroup = programGroupNationals;
		programNR.ordinalPosition = 0;
		[programNR save];
		elementOrdinal = 0;
		
		[self addTo:programNR	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@"2Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"3S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_3	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"2F"		ijsIdSecond:@"2Lo"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"FSSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"SpSq3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_2	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"2Lz"	ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_1	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"CCoSp2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"2F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programNR	ijsId:@"CoSp2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];

		Program *programAT = [[Program alloc] init];
		programAT.description = @"Allison Timlen";
		programAT.programGroup = programGroupNationals;
		programAT.ordinalPosition = 0;
		[programAT save];
		elementOrdinal = 0;
		
		[self addTo:programAT	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"3S"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_3	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"2Lz"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"CCoSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"2F"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_3	inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"CCoSp2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"SpSq3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"2S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_SEQ	estGOE:GOE_minus_3	inSecondHalf:YES	inPos:elementOrdinal++];
		[self addTo:programAT	ijsId:@"FSSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];

	#if ASSERT_BASE_SCORES
		[self verifyScoreFor:programLK is:48.10];
		[self verifyScoreFor:programAC is:41.54];
		[self verifyScoreFor:programKK is:37.51];
		[self verifyScoreFor:programCH is:40.76];
		[self verifyScoreFor:programRK is:34.35];
		[self verifyScoreFor:programCT is:38.85];
		[self verifyScoreFor:programAK is:28.28];
		[self verifyScoreFor:programNR is:33.84];
		[self verifyScoreFor:programAT is:29.91];
	#endif

	#if LOAD_TEST_DATA_FOR_SOV_VALIDATION

		ProgramGroup *pg3 = [[ProgramGroup alloc] init];
		pg3.description = @"Scale of Value Tests";
		pg3.ordinalPosition = 2;
		[pg3 save];
		
		for (int i = 0; i < 6; i++) {
			NSString *goe;
			switch (i) {
				case 0:
					goe = GOE_0;
					break;
				case 1:
					goe = GOE_plus_1;
					break;
				case 2:
					goe = GOE_plus_2;
					break;
				case 3:
					goe = GOE_plus_3;
					break;
				case 4:
					goe = GOE_minus_1;
					break;
				case 5:
					goe = GOE_minus_2;
					break;
				case 6:
					goe = GOE_minus_3;
					break;
				default:
					NSAssert(@"Invalid setting up test data", @"whatever");
					break;
			}

			Program *allEll = [[Program alloc] init];
			allEll.description = [[NSString alloc] initWithFormat:@"SOV %@", goe];
			allEll.programGroup = pg3;
			allEll.ordinalPosition = i;
			[allEll save];
			
			for (int k = 0; k < 3; k++) {
				NSArray *array;
				switch (k) {
					case 0:
						array = [Elements groupOfElements:ELEMENT_GROUP_JUMPS];
						break;
					case 1:
						array = [Elements groupOfElements:ELEMENT_GROUP_SPINS];
						break;
					case 2:
						array = [Elements groupOfElements:ELEMENT_GROUP_STEP_SPIRAL];
						break;
					default:
						break;
				}
				
				for (int j = 0; j < [array count]; j++) {
					Element *e = (Element *)[[array objectAtIndex:j] retain];
					ProgramElement *pe = [[ProgramElement alloc] init];
					pe.ijsId			= e.ijsId;
					pe.ordinalPosition	= j;
					pe.estimatedGOE		= goe;
					pe.program			= allEll;
					pe.isSecondHalf		= NO;
					[pe save];
				}
			}

		}
	#endif
		
		[p1 release];
	//	[p2 release];
		[p3 release];
	//	[p4 release];
		[pg1 release];
		[pg2 release];
	}
#endif
	
	[ApplicationUtilities setupStandardTableLookFor:tableView inView:self.parentViewController.view];
	tableView.rowHeight = 85;
	tableView.tableFooterView = myTableFooterView;
	
	[ApplicationUtilities setGeneralButtonLookFor:btnShareAppWithFriend];
	[ApplicationUtilities setGeneralButtonLookFor:btnFeedback];
	[ApplicationUtilities setGeneralButtonLookFor:btnOrganizeProgramGroups];

}

- (void)addTo:(Program *)prog 
		ijsId:(NSString *)ijsId 
  ijsIdSecond:(NSString *)ijsIdSecond 
   ijsIdThird:(NSString *)ijsIdThird 
	comboType:(NSString *)comboType 
	   estGOE:(NSString *)estimatedGOE 
 inSecondHalf:(BOOL)isSecondHalf 
		inPos:(int)ordinalPosition {
	ProgramElement *pe7		= [[ProgramElement alloc] init];
	pe7.ijsId				= ijsId;
	pe7.ijsIdSecond			= ijsIdSecond;
	pe7.ijsIdThird			= ijsIdThird;
	pe7.jumpComboType		= comboType;
	pe7.ordinalPosition		= ordinalPosition;
	pe7.estimatedGOE		= estimatedGOE;
	pe7.program				= prog;
	pe7.isSecondHalf		= isSecondHalf;
	[pe7 save];
	[pe7 release];
}

#if ASSERT_BASE_SCORES
- (void)verifyScoreFor:(Program *)program is:(float)correctScore {
	float actualScore = [program programScore].baseScore;
	NSAssert4(fequal(correctScore, actualScore), @"Score came out incorrect for %@, expected %.2f and got %.2f, diff=%.6f", 
			  program.description, 
			  correctScore, 
			  actualScore, 
			  (correctScore - actualScore));
	NSLog(@"Verified score of %.2f for %@", correctScore, program.description);
}

#endif

- (void)fabricateData {
	int elementOrdinal = 0;
	ProgramGroup *pg1 = [[ProgramGroup alloc] init];
	pg1.description = @"2010 Programs";
	pg1.ordinalPosition = 0;
	[pg1 save];
	
	ProgramGroup *pg2 = [[ProgramGroup alloc] init];
	pg2.description = @"Old Programs";
	pg2.ordinalPosition = 1;
	[pg2 save];
	
	Program *p1 = [[Program alloc] init];
	p1.description = @"Long";
	p1.programGroup = pg1;
	p1.ordinalPosition = 0;
	[p1 save];
	
	[self addTo:p1	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_3	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2Lz"	ijsIdSecond:@"2T"	ijsIdThird:@"1Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"1S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"SpSq4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2A"		ijsIdSecond:@"2T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"LSp1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2F"		ijsIdSecond:@"1T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"2Lz"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p1	ijsId:@"FSSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	
	Program *p2 = [[Program alloc] init];
	p2.description = @"Short";
	p2.programGroup = pg1;
	p2.ordinalPosition = 1;
	[p2 save];
	[self addTo:p2	ijsId:@"2Lz"	ijsIdSecond:@"2Lo"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"1A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"2F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"CCoSp4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"SpSq4"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_2	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p2	ijsId:@"LSp3"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_plus_1	inSecondHalf:YES	inPos:elementOrdinal++];
	
	Program *p3 = [[Program alloc] init];
	p3.description = @"Adult Gold Free Skate";
	p3.programGroup = pg2;
	p3.ordinalPosition = 2;
	[p3 save];
	
	[self addTo:p3	ijsId:@"1A"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"SSp2"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"1F"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"CCoSp1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"1Lz"	ijsIdSecond:@"1Lo"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_minus_1	inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"1A"		ijsIdSecond:@"1T"	ijsIdThird:@""		comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:NO		inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"2S"		ijsIdSecond:@"1T"	ijsIdThird:@"1Lo"	comboType:JUMP_COMBO_TYPE_COMBO	estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"SlSt1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"2S"		ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_minus_3	inSecondHalf:YES	inPos:elementOrdinal++];
	[self addTo:p3	ijsId:@"LSp1"	ijsIdSecond:@""		ijsIdThird:@""		comboType:@""					estGOE:GOE_0		inSecondHalf:YES	inPos:elementOrdinal++];
	
}

- (void)loadData {
	thereArePrograms = NO;
	programGroups = [[ProgramGroup findByCriteria: @"WHERE 1 = 1"] retain];
	programGroupPrograms = [[NSMutableArray alloc] init];
	// Create an array of arrays of programs for each section (program group)
	for (int i = 0; i < [programGroups count]; i++) {
		ProgramGroup *programGroup = (ProgramGroup *)[[programGroups objectAtIndex:i] retain];
		NSMutableArray *programs = [[programGroup findRelated:[Program class]] mutableCopy];
		if (!thereArePrograms) {
			thereArePrograms = ([programs count] > 0);
		}
		[programGroupPrograms addObject:programs];
		[programs release];
	}
	
//	[self performSelectorInBackground:@selector(updateProgramScores) withObject:nil];
#ifdef DEBUG
	[self updateProgramScores];
#else
	[self performSelector:(@selector(updateProgramScores)) withObject:(nil) afterDelay:0.5];
#endif

}

- (void)updateProgramScores {
	// Used in background to force programs to recalculate.  Trying to reduce "laggy-ness"
	NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];
	for (NSArray *programs in programGroupPrograms) {
		for (Program *program in programs) {
			[program programScore];
		}
	}
	[autoreleasepool release];
}

- (id)addProgram {
	ProgramDetailViewController *addController = [[ProgramDetailViewController alloc] initWithNibName:@"ProgramDetailViewController" bundle:nil];
	//addController.program = program;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
	navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[self.navigationController presentModalViewController:navigationController animated:YES];
	[navigationController release];
	[addController release];

	return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self loadData];
	[self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (thereArePrograms) {
		return [programGroups count];
	} else {
		return 1;
	}

}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	int count = 1;
	if (section < [programGroups count]) {
		NSArray *programs = [[programGroupPrograms objectAtIndex:section] retain];
		count = [programs count];
		[programs release];
	}
	
	if ( ! thereArePrograms && section == 0) {
		//NSAssert(count == 0, @"Count should be 0 if we believe there are no programs.");
		count = 1;
	}
	
    return count;
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section {
	UIView *v = nil;
	if (section < [programGroups count]) {
		ProgramGroup *pg = (ProgramGroup *)[[programGroups objectAtIndex:section] retain];
		v = [ApplicationUtilities getStandardTableSectionHeaderFor:aTableView with:pg.description];
	}
	
	return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat f = 40;
	if (indexPath.section < [programGroups count]) {
		f = 85;
	}
	
	return f;
}

- (Program *)programForRowAtIndexPath:(NSIndexPath *)indexPath {
//	if (indexPath.section < [programGroupPrograms count]) {
//		return nil;
//	}
//	NSLog(@"Getting program for %i / %i", indexPath.section, indexPath.row);
	NSArray *programs = [[programGroupPrograms objectAtIndex:indexPath.section] retain];
//	NSLog(@"\tHave programs for section %i", indexPath.section);
	Program *program = [[programs objectAtIndex:indexPath.row] retain];
//	NSLog(@"\t\tHave program for row %i", indexPath.row);
	return program;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	const CGFloat LABEL_HEIGHT = 23;
	UILabel *topLabel;
	UILabel *bottomLabel;
	
    NSString *CellIdentifier = @"Cell Regular";
	if ( ! thereArePrograms) {
		CellIdentifier = @"Cell Empty";
	}
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		
		if (thereArePrograms) {
			UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
			cell.accessoryView = [[[UIImageView alloc] initWithImage:indicatorImage] autorelease];
			
//			UIImage *image = [UIImage imageNamed:@"imageA.png"];
			UIImage *image = [UIImage imageNamed:PROGRAMS_DECORATIVE_IMAGE];
			
			topLabel = [[[UILabel alloc] initWithFrame:CGRectMake(85, //image.size.width + 2.0 * cell.indentationWidth,
																  0.25 * (aTableView.rowHeight - 2 * LABEL_HEIGHT),
																  190, //aTableView.bounds.size.width - image.size.width - 4.0 * cell.indentationWidth - indicatorImage.size.width,
																  LABEL_HEIGHT)] 
						autorelease];
			[cell.contentView addSubview:topLabel];
			
			topLabel.tag = TOP_LABEL_TAG;
			topLabel.backgroundColor = [UIColor clearColor];
			topLabel.textColor = TABLE_MAIN_LABEL_TEXT_COLOR;
			topLabel.highlightedTextColor = TABLE_MAIN_LABEL_HIGHLIGHT_TEXT_COLOR;
			topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] + 2];
			
			bottomLabel = [[[UILabel alloc] initWithFrame:CGRectMake(90, //image.size.width + 2.0 * cell.indentationWidth, 
																	 -4 + 0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT, 
																	 aTableView.bounds.size.width - image.size.width - 4.0 * cell.indentationWidth - indicatorImage.size.width, 
																	 LABEL_HEIGHT)] 
						   autorelease];
			bottomLabel.numberOfLines = 2;
			[cell.contentView addSubview:bottomLabel];
			
			bottomLabel.tag = BOTTOM_LABEL_TAG;
			bottomLabel.backgroundColor = [UIColor clearColor];
			bottomLabel.textColor = TABLE_SUB_LABEL_TEXT_COLOR;
			bottomLabel.highlightedTextColor = TABLE_SUB_LABEL_HIGHLIGHT_TEXT_COLOR;
			bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
			
			cell.backgroundView = [[[UIImageView alloc] init] autorelease];
			cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
		}
		
    }
    
	if (thereArePrograms) {
		UIImage *rowBackground;
		UIImage *selectionBackground;
		NSInteger sectionRows = [aTableView numberOfRowsInSection:[indexPath section]];
		NSInteger row = [indexPath row];
		if (row == 0 && row == sectionRows - 1) {
			rowBackground = [UIImage imageNamed:@"topAndBottomRow.png"];
			selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
		} else if (row == 0) {
			rowBackground = [UIImage imageNamed:@"topRow.png"];
			selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
		} else if (row == sectionRows - 1) {
			rowBackground = [UIImage imageNamed:@"bottomRow.png"];
			selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
		} else {
			rowBackground = [UIImage imageNamed:@"middleRow.png"];
			selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
		}
		((UIImageView *)cell.backgroundView).image = rowBackground;
		((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
		
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];
		
		// Configure the cell.
		Program *program = [self programForRowAtIndexPath:indexPath];
		if (program != nil) {
			topLabel.text = program.description;
			bottomLabel.text = program.programSubDescription;
			
			CGRect r = CGRectMake(85, 
								  35, 
								  bottomLabel.bounds.size.width, 
								  LABEL_HEIGHT);
			if ([bottomLabel.text rangeOfString:@"\n"].length != 0) {
				r.size.height *= 2;
			}
			[bottomLabel setFrame:r];
			
			cell.imageView.image = [UIImage imageNamed:PROGRAMS_DECORATIVE_IMAGE];
		} else {
			topLabel.text = @"";
			bottomLabel.text = @"";
		}
	} else {
		cell.backgroundColor = [UIColor lightGrayColor];
		cell.textLabel.textAlignment = UITextAlignmentCenter;
		cell.textLabel.text = @"Tap + (upper right corner) to add a program";
		cell.textLabel.numberOfLines = 0;
		
	}

    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (thereArePrograms) {
		// Navigation logic may go here -- for example, create and push another view controller.
		ProgramElementsViewController *programElementsViewController = [[ProgramElementsViewController alloc] initWithNibName:@"ProgramElementsViewController" bundle:nil];
		Program *program = [self programForRowAtIndexPath:indexPath];
		programElementsViewController.program = program;
		program.cachedScoresAreDirty = YES;
		[self.navigationController pushViewController:programElementsViewController animated:YES];
		[programElementsViewController release];
	}
	[aTableView deselectRowAtIndexPath:indexPath animated:YES];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return thereArePrograms;
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		NSMutableArray *programs = [[programGroupPrograms objectAtIndex:indexPath.section] retain];
		Program *programToDelete = (Program *)[[programs objectAtIndex:indexPath.row] retain];
		[programs removeObjectAtIndex:indexPath.row];
		[programToDelete deleteObjectCascade:YES];

        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		[aTableView reloadData];
		
		// TODO When deleting the last program, make sure the cell saying "tap + to add program" shows up.
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}

#pragma mark Button action methods
- (IBAction)buttonTapped:(id)sender {
	if (sender == btnShareAppWithFriend) {
		[self shareAppWithFriend];
	} else if (sender == btnFeedback) {
		[self sendFeedback];
	} else if (sender == btnOrganizeProgramGroups) {
		[self organizeProgramGroups];
	}
}

- (void)shareAppWithFriend {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	controller.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	NSString *subject = [[NSString alloc] initWithFormat:@"%@ on iPhone/iTouch", APPLICATION_NAME];

	NSString *message = [[NSString alloc] initWithFormat:@"Calculate your skating program IJS scores with <a href=\"%@\">%@</a><br />"
						 "GET THE POINT.",
						 WEB_URL,
						 APPLICATION_NAME 
						 ];						  
	
	
	[controller setSubject:subject];
	
	[controller setMessageBody:message isHTML:YES]; 
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)sendFeedback {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	controller.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	NSString *subject = [[NSString alloc] initWithFormat:@"%@ Feedback", APPLICATION_NAME];
	NSString *message = @"Describe your feedback.";
	
	[controller setToRecipients:[NSArray arrayWithObject:@"prestonrohner@me.com"]];
	[controller setSubject:subject];
	
	[controller setMessageBody:message isHTML:YES]; 
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)organizeProgramGroups {
	ProgramGroupViewController *programGroupsViewController = [[ProgramGroupViewController alloc] initWithNibName:@"ProgramGroupViewController" bundle:nil];
	[self.navigationController pushViewController:programGroupsViewController animated:YES];
	[programGroupsViewController release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) {
		NSLog(@"It's away!");
	}
	[self dismissModalViewControllerAnimated:YES];
}


@end

