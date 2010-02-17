//
//  PairsProgramElementDetailViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 2/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"
#import "ProgramElement.h"

#define DEFAULT_JUMP_COMBO_LABEL	@"Choose jump & press +"


@interface PairsProgramElementDetailViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
	BOOL viewHasFinishedLoading;
	BOOL changingElementGroup;
	IBOutlet UISegmentedControl *elementGroupChooser;
	IBOutlet UISegmentedControl *elementSubGroupChooser;
	IBOutlet UISegmentedControl *gradeOfExecutionChooser;
	
	IBOutlet UIPickerView *jumpComboPickerView;
	
	IBOutlet UIView *currentView;
	IBOutlet UIView *workspaceView;
	
	IBOutlet UIView *jumpComboView;
	IBOutlet UILabel *jumpList;
	
	IBOutlet UIButton *resetButton;
	IBOutlet UIButton *addJumpButton;
	IBOutlet UISegmentedControl *jumpComboSeqChooser;
	
	NSArray *elements;
	
	NSString *jumpComboElement1;
	NSString *jumpComboElement2;
	NSString *jumpComboElement3;
	
	Program *program;
	ProgramElement *existingProgramElement;
}

@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) ProgramElement *existingProgramElement;

- (void)loadCurrentElements;

- (IBAction)segmentedControlValueChanged:(id)sender;
- (IBAction)elementSubGroupValueChanged:(id)sender;
- (IBAction)jumpComboValueChanged:(id)sender;
- (void)doneWithElement;
- (void)cancelElement;
- (IBAction)jumpComboAdd:(id)sender;
- (IBAction)jumpComboReset:(id)sender;
- (void)updateJumpComboLabel;
- (void)presetValuesForProgramElement;
- (void)pickerView:(UIPickerView *)pickerView setRowForElement:(ProgramElement *)programElement;
- (void)refreshDisplayInfo;
- (void)goeChanged:(id)sender;
- (NSString *)goeScoreAsString;
- (void)resetJumpListBackgroundColor;
- (void)jumpListText:(NSString *)txt;

- (void)setSubGroupChooserTitles;
- (ProgramElement *)getProgramElement:(BOOL)mustBeTempVariable;
- (NSString *)ijsIdFromPicker:(UIPickerView *)picker;


@end
