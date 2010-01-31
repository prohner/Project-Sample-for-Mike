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

@synthesize program;

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
    [super viewDidLoad];
	
	self.title = @"Element";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelElement)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithElement)] autorelease];

	[ApplicationUtilities setGeneralViewLookFor:self.view];
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
}

- (void)doneWithElement {
	ProgramElement *programElement = [[ProgramElement alloc] init];
	programElement.ordinalPosition	= [program elementsInHalf:YES] - 1;
	programElement.program			= program;
	programElement.isSecondHalf		= NO;

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

	switch (gradeOfExecutionChooser.selectedSegmentIndex) {
		case 0:
			programElement.estimatedGOE		= GOE_plus_3;
			break;
		case 1:
			programElement.estimatedGOE		= GOE_plus_2;
			break;
		case 2:
			programElement.estimatedGOE		= GOE_plus_1;
			break;
		case 3:
			programElement.estimatedGOE		= GOE_0;
			break;
		case 4:
			programElement.estimatedGOE		= GOE_minus_1;
			break;
		case 5:
			programElement.estimatedGOE		= GOE_minus_2;
			break;
		case 6:
			programElement.estimatedGOE		= GOE_minus_3;
			break;
		default:
			break;
	}
	
	[programElement save];

//	[self.navigationController popViewControllerAnimated:YES];
	[self.navigationController dismissModalViewControllerAnimated:YES];
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
			if (thePickerView == jumpPickerView || thePickerView == jumpComboPickerView) {
				return [jumps objectAtIndex:row];
			} else if (thePickerView == spinPickerView) {
				return [spins objectAtIndex:row];
			} else if (thePickerView == stepSpiralPickerView) {
				return [steps objectAtIndex:row];
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
	//textView.text = [elementDescriptions objectAtIndex:row];
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
}

- (IBAction)jumpComboReset:(id)sender {
	jumpList.text = DEFAULT_JUMP_COMBO_LABEL;
	jumpComboElement1 = @"";
	jumpComboElement2 = @"";
	jumpComboElement3 = @"";
	
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
}

@end
