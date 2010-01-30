//
//  ProgramDetailViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

@interface ProgramDetailViewController : UITableViewController {
	Program *program;
	UITextField *description;
}

@property (nonatomic, retain) IBOutlet UITextField *description;

- (void)doneWithProgram;
- (void)cancelProgram;

@end
