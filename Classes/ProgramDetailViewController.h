//
//  ProgramDetailViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

@interface ProgramDetailViewController : UITableViewController <UITextFieldDelegate> {
	Program *program;
	UITextField *description;
	NSArray *programGroups;
	int selectedProgramGroupIndex;

	IBOutlet UISegmentedControl *typeOfProgram;
}

@property (nonatomic, retain) IBOutlet UITextField *description;
@property (nonatomic, retain) IBOutlet UISegmentedControl *typeOfProgram;

- (void)doneWithProgram;
- (void)cancelProgram;

@end
