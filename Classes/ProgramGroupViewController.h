//
//  ProgramGroupViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramGroupViewController : UITableViewController {
	UITextField *programGroupDescription;
	NSMutableArray *programGroups;
	UIView *cannotDeleteWarningView;
}
	
@property (nonatomic, retain) IBOutlet UITextField *programGroupDescription;
@property (nonatomic, retain) IBOutlet UIView *cannotDeleteWarningView;

- (void)addProgramGroup;
- (void)doneWithProgramGroups;

@end
