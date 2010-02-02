//
//  ProgramElementDetailViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"
#import "ProgramElement.h"

#define DEFAULT_JUMP_COMBO_LABEL	@"Choose jump & press +"

@interface ProgramElementDetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	BOOL viewHasFinishedLoading;
	IBOutlet UISegmentedControl *elementGroupChooser;
	IBOutlet UISegmentedControl *gradeOfExecutionChooser;

	IBOutlet UIPickerView *jumpPickerView;
	IBOutlet UIPickerView *spinPickerView;
	IBOutlet UIPickerView *stepSpiralPickerView;
	IBOutlet UIPickerView *jumpComboPickerView;
	
	IBOutlet UIView *currentView;
	IBOutlet UIView *workspaceView;

	IBOutlet UIView *jumpsView;
	IBOutlet UIView *spinsView;
	IBOutlet UIView *stepSpiralView;
	IBOutlet UIView *jumpComboView;
	IBOutlet UILabel *jumpList;
	IBOutlet UISegmentedControl *jumpComboSeqChooser;
	
	NSArray *jumps;
	NSArray *spins;	
	NSArray *steps;	
	
	NSString *jumpComboElement1;
	NSString *jumpComboElement2;
	NSString *jumpComboElement3;
	
	Program *program;
	ProgramElement *existingProgramElement;
}

@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) ProgramElement *existingProgramElement;

- (IBAction)segmentedControlValueChanged:(id)sender;
- (IBAction)jumpComboValueChanged:(id)sender;
- (void)doneWithElement;
- (void)cancelElement;
- (IBAction)jumpComboAdd:(id)sender;
- (IBAction)jumpComboReset:(id)sender;
- (void)updateJumpComboLabel;
- (void)presetValuesForProgramElement;
- (void)pickerView:(UIPickerView *)pickerView setRowForElement:(ProgramElement *)programElement withArray:(NSArray *)elements;
- (void)refreshDisplayInfo;
- (void)goeChanged:(id)sender;
- (NSString *)goeScoreAsString;
- (void)resetJumpListBackgroundColor;
- (void)jumpListText:(NSString *)txt;

- (NSString *)ijsIdFromPicker:(UIPickerView *)picker;

@end
