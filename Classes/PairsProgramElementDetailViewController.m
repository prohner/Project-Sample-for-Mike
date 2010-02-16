//
//  PairsProgramElementDetailViewController.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PairsProgramElementDetailViewController.h"
#import "Elements.h"
#import "ProgramElement.h"
#import "ApplicationUtilities.h"


@implementation PairsProgramElementDetailViewController

@synthesize program, existingProgramElement;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	viewHasFinishedLoading = NO;
	changingElementGroup = NO;
    [super viewDidLoad];
	
	self.title = @"Element";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelElement)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithElement)] autorelease];
	
	[ApplicationUtilities setGeneralViewLookFor:self.view];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground.png"]];
	[ApplicationUtilities setGeneralViewLookFor:workspaceView];
	[ApplicationUtilities setGeneralViewLookFor:jumpComboView];
	
	jumpList.text = DEFAULT_JUMP_COMBO_LABEL;
	[workspaceView addSubview:jumpComboView];
	gradeOfExecutionChooser.selectedSegmentIndex = 3;
	
	jumpComboElement1 = @"";
	jumpComboElement2 = @"";
	jumpComboElement3 = @"";
	
	Element *element = [Elements getElementFor:existingProgramElement.ijsId inDiscipline:program.discipline];
	
	if ( ! existingProgramElement.isSingleElement) {
		elementGroupChooser.selectedSegmentIndex = 3;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_JUMPS]) {
		elementGroupChooser.selectedSegmentIndex = 0;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_SPINS]) {
		elementGroupChooser.selectedSegmentIndex = 1;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_STEP_SPIRAL]) {
		elementGroupChooser.selectedSegmentIndex = 2;		
	} else {
		NSAssert(@"Could not identify the group for the element.", @"other");
	}
	[element release];
	
//	[self loadCurrentElements];
	
	
//	viewHasFinishedLoading = YES;
	//	[self refreshDisplayInfo];
	//	[self performSelector:(@selector(refreshDisplayInfo)) withObject:(nil) afterDelay:0.5];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self presetValuesForProgramElement];
	viewHasFinishedLoading = YES;
}

- (void)loadCurrentElements {
	[elements release];
	switch (elementGroupChooser.selectedSegmentIndex) {
		case 0:
			if (elementSubGroupChooser.selectedSegmentIndex == 0) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS inDiscipline:program.discipline] retain];
			} else if (elementSubGroupChooser.selectedSegmentIndex == 1) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_THROWS inDiscipline:program.discipline] retain];
			} else {
				NSAssert(nil, @"Invalid subgroup.  Shouldn't be here!");
			}

			break;
		case 1:
			if (elementSubGroupChooser.selectedSegmentIndex == 0) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS inDiscipline:program.discipline] retain];
			} else if (elementSubGroupChooser.selectedSegmentIndex == 1) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_PAIR_SPINS inDiscipline:program.discipline] retain];
			} else {
				NSAssert(nil, @"Invalid subgroup.  Shouldn't be here!");
			}
			
			break;
		case 2:
			
			if (elementSubGroupChooser.selectedSegmentIndex == 0) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_STEP_SPIRAL inDiscipline:program.discipline] retain];
			} else if (elementSubGroupChooser.selectedSegmentIndex == 1) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_DEATH_SPIRALS inDiscipline:program.discipline] retain];
			} else {
				NSAssert(nil, @"Invalid subgroup.  Shouldn't be here!");
			}
			
			break;
		case 3:
			
			if (elementSubGroupChooser.selectedSegmentIndex == 0) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_LIFTS inDiscipline:program.discipline] retain];
			} else if (elementSubGroupChooser.selectedSegmentIndex == 1) {
				elements = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_TWIST_LIFTS inDiscipline:program.discipline] retain];
			} else {
				NSAssert(nil, @"Invalid subgroup.  Shouldn't be here!");
			}
			
			break;
		default:
			break;
	}
	
	if (elementGroupChooser.selectedSegmentIndex == 0 && elementSubGroupChooser.selectedSegmentIndex == 0) {
		// Side by side jumps
		resetButton.hidden = NO;
		addJumpButton.hidden = NO;
		jumpComboSeqChooser.hidden = NO;
	} else {
		resetButton.hidden = YES;
		addJumpButton.hidden = YES;
		jumpComboSeqChooser.hidden = YES;
	}


	[self refreshDisplayInfo];
	[jumpComboPickerView reloadAllComponents];
	
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	[elements dealloc];
	
}

#pragma mark Display Update Methods

- (void)presetValuesForProgramElement {
	if (existingProgramElement == nil) {
		return;
	}
	
	jumpComboElement1 = existingProgramElement.ijsId;
	jumpComboElement2 = existingProgramElement.ijsIdSecond;
	jumpComboElement3 = existingProgramElement.ijsIdThird;
	
	Element *element = [Elements getElementFor:existingProgramElement.ijsId inDiscipline:program.discipline];
	
	if ([element.elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS]) {
		elementGroupChooser.selectedSegmentIndex = 0;
		elementSubGroupChooser.selectedSegmentIndex	= 0;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_THROWS]) {
		elementGroupChooser.selectedSegmentIndex = 0;
		elementSubGroupChooser.selectedSegmentIndex	= 1;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_SIDE_BY_SIDE_SPINS]) {
		elementGroupChooser.selectedSegmentIndex = 1;
		elementSubGroupChooser.selectedSegmentIndex	= 0;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_PAIR_SPINS]) {
		elementGroupChooser.selectedSegmentIndex = 1;
		elementSubGroupChooser.selectedSegmentIndex	= 1;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_STEP_SPIRAL]) {
		elementGroupChooser.selectedSegmentIndex = 2;
		elementSubGroupChooser.selectedSegmentIndex	= 0;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_DEATH_SPIRALS]) {
		elementGroupChooser.selectedSegmentIndex = 2;
		elementSubGroupChooser.selectedSegmentIndex	= 1;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_LIFTS]) {
		elementGroupChooser.selectedSegmentIndex = 3;
		elementSubGroupChooser.selectedSegmentIndex	= 0;
	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_TWIST_LIFTS]) {
		elementGroupChooser.selectedSegmentIndex = 3;
		elementSubGroupChooser.selectedSegmentIndex	= 1;
	}

	if ([existingProgramElement.estimatedGOE isEqualToString:GOE_plus_3]) {
		gradeOfExecutionChooser.selectedSegmentIndex = 0;
	} else if ([existingProgramElement.estimatedGOE isEqualToString:GOE_plus_2]) {
		gradeOfExecutionChooser.selectedSegmentIndex = 1;
	} else if ([existingProgramElement.estimatedGOE isEqualToString:GOE_plus_1]) {
		gradeOfExecutionChooser.selectedSegmentIndex = 2;
	} else if ([existingProgramElement.estimatedGOE isEqualToString:GOE_0]) {
		gradeOfExecutionChooser.selectedSegmentIndex = 3;
	} else if ([existingProgramElement.estimatedGOE isEqualToString:GOE_minus_1]) {
		gradeOfExecutionChooser.selectedSegmentIndex = 4;
	} else if ([existingProgramElement.estimatedGOE isEqualToString:GOE_minus_2]) {
		gradeOfExecutionChooser.selectedSegmentIndex = 5;
	} else if ([existingProgramElement.estimatedGOE isEqualToString:GOE_minus_3]) {
		gradeOfExecutionChooser.selectedSegmentIndex = 6;
	}
	
	[self loadCurrentElements];
	
	[self pickerView:jumpComboPickerView setRowForElement:existingProgramElement];
	
	NSLog(@"Executed presetValuesForProgramElement");
	[self performSelector:(@selector(refreshDisplayInfo)) withObject:(nil) afterDelay:1.0];
	
}

- (void)goeChanged:(id)sender {
	[self refreshDisplayInfo];
}

- (void)refreshDisplayInfo {
	if ( ! viewHasFinishedLoading) {
		return;
	}
	
	NSLog(@"Executed refreshDisplayInfo");
	
	if (changingElementGroup) {
		[self jumpListText: @"Choose element and level below"];
	} else {
		ProgramElement *programElement = [self getProgramElement:YES];
		
		if (programElement) {
			NSString *desc = [[NSString alloc] initWithFormat:@"%@\nBase %.2f, GOE %.2f", 
							  programElement.shortenedDescription, 
							  programElement.baseScore,
							  [programElement scoreForGOE:[self goeScoreAsString] ]
							  ];
			[self jumpListText: desc];
		}
	}
}

- (void)jumpListText:(NSString *)txt {
	jumpList.text = txt;
	jumpList.alpha = 0.25;
	[self performSelector:(@selector(resetJumpListBackgroundColor)) withObject:(nil) afterDelay:0.5];
}

- (void)resetJumpListBackgroundColor {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:.5];
	[UIView setAnimationDelegate:self];     
	jumpList.alpha = 1;
	jumpList.opaque = NO;
	jumpList.backgroundColor = [UIColor clearColor];
	
	[UIView commitAnimations];	
	
}

- (ProgramElement *)getProgramElement:(BOOL)mustBeTempVariable {
	ProgramElement *programElement;
	if (existingProgramElement == nil || mustBeTempVariable) {
		programElement = [[ProgramElement alloc] init];
		programElement.ordinalPosition	= [program elementsInHalf:YES] - 1;
		programElement.program			= program;
		programElement.isSecondHalf		= NO;
	} else {
		programElement = existingProgramElement;
	}
	
	programElement.discipline = program.discipline;
	
	if (elementGroupChooser.selectedSegmentIndex == 0) {
		// Could be a jump combo or sequence
		programElement.ijsId			= jumpComboElement1;
		programElement.ijsIdSecond		= jumpComboElement2;
		programElement.ijsIdThird		= jumpComboElement3;
		if (jumpComboSeqChooser.selectedSegmentIndex == 0) {
			programElement.jumpComboType = JUMP_COMBO_TYPE_COMBO;
		} else {
			programElement.jumpComboType = JUMP_COMBO_TYPE_SEQ;
		}
	} else {
		programElement.ijsId = [self ijsIdFromPicker:jumpComboPickerView];
		programElement.ijsIdSecond		= @"";
		programElement.ijsIdThird		= @"";
		programElement.jumpComboType	= @"";
	}
	
	programElement.estimatedGOE		= [self goeScoreAsString];
	return programElement;
}

- (void)doneWithElement {
	ProgramElement *programElement = [self getProgramElement:NO];
	[programElement save];

	//	[self.navigationController popViewControllerAnimated:YES];
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (NSString *)goeScoreAsString {
	NSString *goeString = @"";
	switch (gradeOfExecutionChooser.selectedSegmentIndex) {
		case 0:
			goeString		= GOE_plus_3;
			break;
		case 1:
			goeString		= GOE_plus_2;
			break;
		case 2:
			goeString		= GOE_plus_1;
			break;
		case 3:
			goeString		= GOE_0;
			break;
		case 4:
			goeString		= GOE_minus_1;
			break;
		case 5:
			goeString		= GOE_minus_2;
			break;
		case 6:
			goeString		= GOE_minus_3;
			break;
		default:
			break;
	}
	return goeString;
}

- (void)cancelElement {
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (IBAction)segmentedControlValueChanged:(id)sender {
	if ( ! viewHasFinishedLoading) {
		return;
	}
	
	changingElementGroup = YES;

	if (currentView != nil) {
		[currentView removeFromSuperview];
	}

	resetButton.hidden = YES;
	addJumpButton.hidden = YES;
	jumpComboSeqChooser.hidden = YES;
	
	[workspaceView addSubview:elementSubGroupChooser];
	
	switch ([sender selectedSegmentIndex]) {
		case 0:
			[elementSubGroupChooser setTitle:@"S-by-S" forSegmentAtIndex:0];
			[elementSubGroupChooser setTitle:@"Throws" forSegmentAtIndex:1];
			break;
		case 1:
			[elementSubGroupChooser setTitle:@"S-by-S" forSegmentAtIndex:0];
			[elementSubGroupChooser setTitle:@"Pairs" forSegmentAtIndex:1];
			break;
		case 2:
			[elementSubGroupChooser setTitle:@"Stp/Sprl" forSegmentAtIndex:0];
			[elementSubGroupChooser setTitle:@"Death" forSegmentAtIndex:1];
			break;
		case 3:
			[elementSubGroupChooser setTitle:@"Lifts" forSegmentAtIndex:0];
			[elementSubGroupChooser setTitle:@"Twists" forSegmentAtIndex:1];
			break;
		default:
			currentView = nil;
			break;
	}
	
	[self loadCurrentElements];
	//	[self.view addSubview:currentView];
	
	if (currentView) {
		//		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
		[workspaceView addSubview:currentView];
	}	

	changingElementGroup = NO;
}

- (IBAction)elementSubGroupValueChanged:(id)sender {
	if ( ! viewHasFinishedLoading) {
		return;
	}

	[self loadCurrentElements];
}

- (NSString *)ijsIdFromPicker:(UIPickerView *)picker {
	NSInteger jumpIndex = [picker selectedRowInComponent:0];
	NSInteger revolutionIndex = [picker selectedRowInComponent:1];
	
	NSString *selectedElement = nil;
	
	selectedElement = [[elements objectAtIndex:jumpIndex] retain];
	
	NSRange r = [selectedElement rangeOfString:@"^"];
	NSString *jumpId = [selectedElement substringFromIndex:r.location + 1];
	NSString *result;// = [[NSString alloc] initWithFormat:@"%i%@", revolutionIndex + 1, jumpId];
	if (elementGroupChooser.selectedSegmentIndex == 0) {
		// Jump
		result = [[NSString alloc] initWithFormat:@"%i%@", revolutionIndex + 1, jumpId];
	} else {
		result = [[NSString alloc] initWithFormat:@"%@%i", jumpId, revolutionIndex + 1];
	}

	
	//	if (picker != jumpPickerView && picker != jumpComboPickerView) {
	//		result = [[NSString alloc] initWithFormat:@"%@%i", jumpId, revolutionIndex + 1];
	//	}
	return result;
}

#pragma mark Picker View Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	if (component > 0) {
		return 4;
	}
	
	return [elements count];
}

- (void)pickerView:(UIPickerView *)pickerView setRowForElement:(ProgramElement *)programElement {
	Element *element = [Elements getElementFor:existingProgramElement.ijsId inDiscipline:program.discipline];
	
	NSString *letters = [[NSString alloc] initWithFormat:@"^%@", [element ijsIdLetters]];
	NSString *digits = [element ijsIdDigits];
	for (int i = 0; i < [elements count]; i++) {
		NSString *theElement = (NSString *)[elements objectAtIndex:i];
		NSRange range = [theElement rangeOfString:letters];
		NSLog(@"Searched for %@ in %@", letters, theElement);
		if (range.length > 0) {
			[pickerView selectRow:i inComponent:0 animated:YES];
			break;
		}
	}
	
	[pickerView selectRow:([digits intValue] - 1) inComponent:1 animated:YES];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {	
	switch (component) {
		case 0:
		{
			NSString *txt;
			txt = [elements objectAtIndex:row];

			NSRange r = [txt rangeOfString:@"^"];
			txt = [txt substringToIndex:r.location];
			//			txt = [txt stringByReplacingOccurrencesOfString:@"Level" withString:@"Lvl"];
			return txt;
		}
			break;
		case 1:
			switch (row) {
				case 0:
					return @"1";
					break;
				case 1:
					return @"2";
					break;
				case 2:
					return @"3";
					break;
				case 3:
					return @"4";
					break;
				default:
					break;
			}
		default:
			break;
	}
	return @"";
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//	if (pickerView == jumpPickerView && 0) {
//		return 320;
//	} else {
		switch(component) {
			case 0: 
				return 250;
				break;
			case 1: 
				return 70;
				break;
		}
//	}
	
    //NOT REACHED
    return 320;
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {	
	if (elementGroupChooser.selectedSegmentIndex > 0) {
		jumpComboElement1 = @"";
		jumpComboElement2 = @"";
		jumpComboElement3 = @"";
	}
	[self refreshDisplayInfo];
}

#pragma mark Button Actions

- (IBAction)jumpComboAdd:(id)sender {
	// TODO When you come in to edit an existing element and then change to jump combo, the + button doesn't work
	
	NSString *ijsId = [self ijsIdFromPicker:jumpComboPickerView];
	
	if ([jumpComboElement1 isEqualToString:@""]) {
		jumpComboElement1 = ijsId;
	} else if ([jumpComboElement2 isEqualToString:@""]) {
		jumpComboElement2 = ijsId;
	} else if ([jumpComboElement3 isEqualToString:@""]) {
		jumpComboElement3 = ijsId;
	}
	
//	[self updateJumpComboLabel];
	[self refreshDisplayInfo];
}

- (IBAction)jumpComboReset:(id)sender {
	jumpList.text = DEFAULT_JUMP_COMBO_LABEL;
	jumpComboElement1 = @"";
	jumpComboElement2 = @"";
	jumpComboElement3 = @"";
	[self refreshDisplayInfo];
	
}

- (void)updateJumpComboLabel {
	NSLog(@"Updating label (%@) + (%@) + (%@)", jumpComboElement1, jumpComboElement2, jumpComboElement3);
	NSString *list = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@", 
					  jumpComboElement1, 
					  ([jumpComboElement2 isEqualToString:@""] ? @"" : @" + "), jumpComboElement2,
					  ([jumpComboElement3 isEqualToString:@""] ? @"" : @" + "), jumpComboElement3, 
					  [jumpComboSeqChooser selectedSegmentIndex] == 0 ? @" combination" : @" sequence"];
	NSLog(@"\t (%@)", list);
	jumpList.text = list;
}

- (IBAction)jumpComboValueChanged:(id)sender {
	[self updateJumpComboLabel];
	[self refreshDisplayInfo];
}

@end
