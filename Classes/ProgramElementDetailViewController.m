//
//  ProgramElementDetailViewController.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramElementDetailViewController.h"
#import "Elements.h"
#import "ProgramElement.h"
#import "ApplicationUtilities.h"

@implementation ProgramElementDetailViewController

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
    [super viewDidLoad];
	
	self.title = @"Element";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelElement)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithElement)] autorelease];

	[ApplicationUtilities setGeneralViewLookFor:self.view];
	self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground.png"]];
	[ApplicationUtilities setGeneralViewLookFor:workspaceView];
	[ApplicationUtilities setGeneralViewLookFor:jumpsView];
	[ApplicationUtilities setGeneralViewLookFor:spinsView];
	[ApplicationUtilities setGeneralViewLookFor:stepSpiralView];
	[ApplicationUtilities setGeneralViewLookFor:jumpComboView];
	
	jumpList.text = DEFAULT_JUMP_COMBO_LABEL;
	[workspaceView addSubview:jumpsView];
	gradeOfExecutionChooser.selectedSegmentIndex = 3;
	
	jumps = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_JUMPS] retain];
	spins = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_SPINS] retain];	
	steps = [[Elements groupOfUniqueElementsIn:ELEMENT_GROUP_STEP_SPIRAL] retain];
	
	jumpComboElement1 = @"";
	jumpComboElement2 = @"";
	jumpComboElement3 = @"";
	
	[self presetValuesForProgramElement];
	
	viewHasFinishedLoading = YES;
//	[self refreshDisplayInfo];
	[self performSelector:(@selector(refreshDisplayInfo)) withObject:(nil) afterDelay:0.5];
}

- (void)presetValuesForProgramElement {
	if (existingProgramElement == nil) {
		return;
	}

	Element *element = [Elements getElementFor:existingProgramElement.ijsId];
	
	if ( ! existingProgramElement.isSingleElement) {
		elementGroupChooser.selectedSegmentIndex = 3;
		[self pickerView:jumpPickerView setRowForElement:existingProgramElement withArray:jumps];

	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_JUMPS]) {
		elementGroupChooser.selectedSegmentIndex = 0;
		[self pickerView:jumpPickerView setRowForElement:existingProgramElement withArray:jumps];

	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_SPINS]) {
		elementGroupChooser.selectedSegmentIndex = 1;
		[self pickerView:spinPickerView setRowForElement:existingProgramElement withArray:spins];

	} else if ([element.elementGroup isEqualToString:ELEMENT_GROUP_STEP_SPIRAL]) {
		elementGroupChooser.selectedSegmentIndex = 2;
		[self pickerView:stepSpiralPickerView setRowForElement:existingProgramElement withArray:steps];

	} else {
		NSAssert(@"Could not identify the group for the element.", @"other");
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

	
}

- (void)goeChanged:(id)sender {
	[self refreshDisplayInfo];
}

- (void)refreshDisplayInfo {
	if ( ! viewHasFinishedLoading) {
		return;
	}

	ProgramElement *pe = [[ProgramElement alloc] init];
	
	if ([elementGroupChooser selectedSegmentIndex] == 3) {
		pe.ijsId = jumpComboElement1;
		pe.ijsIdSecond = jumpComboElement2;
		pe.ijsIdThird = jumpComboElement3;
		if ([pe.ijsId isEqualToString:@""]) {
			pe.ijsId = [self ijsIdFromPicker:jumpComboPickerView];;
		}
		if (jumpComboSeqChooser.selectedSegmentIndex == 0) {
			pe.jumpComboType = JUMP_COMBO_TYPE_COMBO;
		} else {
			pe.jumpComboType = JUMP_COMBO_TYPE_SEQ;
		}
	} else {
		switch ([elementGroupChooser selectedSegmentIndex]) {
			case 0:
				pe.ijsId = [self ijsIdFromPicker:jumpPickerView];
				break;
			case 1:
				pe.ijsId = [self ijsIdFromPicker:spinPickerView];
				break;
			case 2:
				pe.ijsId = [self ijsIdFromPicker:stepSpiralPickerView];
				break;
			default:
				break;
		}
	}
	if (pe) {
		NSString *desc = [[NSString alloc] initWithFormat:@"%@\nBase %.2f, GOE %.2f", 
						  pe.shortenedDescription, 
						  pe.baseScore,
						  [pe scoreForGOE:[self goeScoreAsString] ]
						  ];
		jumpList.text = desc;
		jumpList.alpha = 0.25;
		[self performSelector:(@selector(resetJumpListBackgroundColor)) withObject:(nil) afterDelay:0.5];
	}
	
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

- (void)pickerView:(UIPickerView *)pickerView setRowForElement:(ProgramElement *)programElement withArray:(NSArray *)elements {
	Element *element = [Elements getElementFor:existingProgramElement.ijsId];

	NSString *letters = [[NSString alloc] initWithFormat:@"-%@", [element ijsIdLetters]];
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

- (void)doneWithElement {
	ProgramElement *programElement;
	if (existingProgramElement == nil) {
		programElement = [[ProgramElement alloc] init];
		programElement.ordinalPosition	= [program elementsInHalf:YES] - 1;
		programElement.program			= program;
		programElement.isSecondHalf		= NO;
	} else {
		programElement = existingProgramElement;
	}


	switch (elementGroupChooser.selectedSegmentIndex) {
		case 0:
			programElement.ijsId			= [self ijsIdFromPicker:jumpPickerView];
			break;
		case 1:
			programElement.ijsId			= [self ijsIdFromPicker:spinPickerView];
			break;
		case 2:
			programElement.ijsId			= [self ijsIdFromPicker:stepSpiralPickerView];
			break;
		case 3:
			programElement.ijsId			= jumpComboElement1;
			programElement.ijsIdSecond		= jumpComboElement2;
			programElement.ijsIdThird		= jumpComboElement3;
			if (jumpComboSeqChooser.selectedSegmentIndex == 0) {
				programElement.jumpComboType = JUMP_COMBO_TYPE_COMBO;
			} else {
				programElement.jumpComboType = JUMP_COMBO_TYPE_SEQ;
			}

			break;
		default:
			break;
	}

	programElement.estimatedGOE		= [self goeScoreAsString];
	
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
	[jumps dealloc];
	[spins dealloc];
	[steps dealloc];
	
}

- (IBAction)segmentedControlValueChanged:(id)sender {
	if (currentView != nil) {
		[currentView removeFromSuperview];
	}
	
	switch ([sender selectedSegmentIndex]) {
		case 0:
			currentView = jumpsView;
			break;
		case 1:
			currentView = spinsView;
			break;
		case 2:
			currentView = stepSpiralView;
			break;
		case 3:
			currentView = jumpComboView;
			break;
		default:
			currentView = nil;
			break;
	}

	[self refreshDisplayInfo];
//	[self.view addSubview:currentView];
	
	if (currentView) {
//		[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
		[workspaceView addSubview:currentView];
	}	
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	if (thePickerView == jumpPickerView) {
		return 2;
	} else if (thePickerView == spinPickerView) {
		return 2;
	} else if (thePickerView == stepSpiralPickerView) {
		return 2;
	}	
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	if (component > 0) {
		return 4;
	}
	
	if (thePickerView == jumpPickerView || thePickerView == jumpComboPickerView) {
		return [jumps count];
	}
	
	if (thePickerView == spinPickerView) {
		return [spins count];
	}
	
	if (thePickerView == stepSpiralPickerView) {
		return [steps count];
	}
	
	return 0;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {	
	switch (component) {
		case 0:
		{
			NSString *txt;
			if (thePickerView == jumpPickerView || thePickerView == jumpComboPickerView) {
				txt = [jumps objectAtIndex:row];
			} else if (thePickerView == spinPickerView) {
				txt = [spins objectAtIndex:row];
			} else if (thePickerView == stepSpiralPickerView) {
				txt = [steps objectAtIndex:row];
			}
			NSRange r = [txt rangeOfString:@"-"];
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
	if (pickerView == jumpPickerView && 0) {
		return 320;
	} else {
		switch(component) {
			case 0: 
				return 250;
				break;
			case 1: 
				return 70;
				break;
		}
	}
	
    //NOT REACHED
    return 320;
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {	
	[self refreshDisplayInfo];
}

- (NSString *)ijsIdFromPicker:(UIPickerView *)picker {
	NSInteger jumpIndex = [picker selectedRowInComponent:0];
	NSInteger revolutionIndex = [picker selectedRowInComponent:1];

	NSString *selectedElement = nil;
	if (picker == jumpPickerView || picker == jumpComboPickerView) {
		selectedElement = [[jumps objectAtIndex:jumpIndex] retain];
	} else if (picker == spinPickerView) {
		selectedElement = [[spins objectAtIndex:jumpIndex] retain];
	} else if (picker == stepSpiralPickerView) {
		selectedElement = [[steps  objectAtIndex:jumpIndex] retain];
	}
	
	NSRange r = [selectedElement rangeOfString:@"-"];
	NSString *jumpId = [selectedElement substringFromIndex:r.location + 1];
	NSString *result = [[NSString alloc] initWithFormat:@"%i%@", revolutionIndex + 1, jumpId];
	if (picker != jumpPickerView && picker != jumpComboPickerView) {
		result = [[NSString alloc] initWithFormat:@"%@%i", jumpId, revolutionIndex + 1];
	}
	return result;
}

- (IBAction)jumpComboAdd:(id)sender {
	NSString *ijsId = [self ijsIdFromPicker:jumpComboPickerView];
		
	if ([jumpComboElement1 isEqualToString:@""]) {
		jumpComboElement1 = ijsId;
	} else if ([jumpComboElement2 isEqualToString:@""]) {
		jumpComboElement2 = ijsId;
	} else if ([jumpComboElement3 isEqualToString:@""]) {
		jumpComboElement3 = ijsId;
	}
	
	[self updateJumpComboLabel];
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
	jumpList.text = [[NSString alloc] initWithFormat:@"%@%@%@%@%@%@", 
					 jumpComboElement1, 
					 ([jumpComboElement2 isEqualToString:@""] ? @"" : @" + "), jumpComboElement2,
					 ([jumpComboElement3 isEqualToString:@""] ? @"" : @" + "), jumpComboElement3, 
					 [jumpComboSeqChooser selectedSegmentIndex] == 0 ? @" combination" : @" sequence"];
}

- (IBAction)jumpComboValueChanged:(id)sender {
	[self updateJumpComboLabel];
	[self refreshDisplayInfo];
}

@end
