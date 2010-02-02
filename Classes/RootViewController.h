//
//  RootViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ApplicationUtilities.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface RootViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
	UITableView *tableView;
	UIImageView *imageView;
	
	NSArray *programGroups;
	NSMutableArray *programGroupPrograms;
	
	UIButton *btnShareAppWithFriend;
	UIButton *btnFeedback;
	UIButton *btnOrganizeProgramGroups;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@property (nonatomic, retain) IBOutlet UIButton *btnShareAppWithFriend;
@property (nonatomic, retain) IBOutlet UIButton *btnFeedback;
@property (nonatomic, retain) IBOutlet UIButton *btnOrganizeProgramGroups;

- (id)addProgram;
- (void)loadData;
- (IBAction)buttonTapped:(id)sender;

- (void)shareAppWithFriend;
- (void)sendFeedback;
- (void)organizeProgramGroups;	
@end
