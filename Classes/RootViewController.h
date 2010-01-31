//
//  RootViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ApplicationUtilities.h"

@interface RootViewController : UITableViewController {
	UITableView *tableView;
	UIImageView *imageView;
	
	NSArray *programGroups;
	NSMutableArray *programGroupPrograms;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

- (id)addProgram;
- (void)loadData;
@end
