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
	UIView *myTableFooterView;
	
	NSArray *programGroups;
	NSMutableArray *programGroupPrograms;
	
	UIButton *btnShareAppWithFriend;
	UIButton *btnFeedback;
	UIButton *btnOrganizeProgramGroups;
	
	BOOL thereArePrograms;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIView *myTableFooterView;

@property (nonatomic, retain) IBOutlet UIButton *btnShareAppWithFriend;
@property (nonatomic, retain) IBOutlet UIButton *btnFeedback;
@property (nonatomic, retain) IBOutlet UIButton *btnOrganizeProgramGroups;

- (id)addProgram;
- (void)loadData;
- (IBAction)buttonTapped:(id)sender;

- (void)shareAppWithFriend;
- (void)sendFeedback;
- (void)organizeProgramGroups;	
- (void)updateProgramScores;

#if LOAD_TEST_DATA || LOAD_SAMPLE_DATA_TO_PUBLISH
- (void)addTo:(Program *)prog 
		ijsId:(NSString *)ijsId 
  ijsIdSecond:(NSString *)ijsIdSecond 
   ijsIdThird:(NSString *)ijsIdThird 
	comboType:(NSString *)comboType 
	   estGOE:(NSString *)estimatedGOE 
 inSecondHalf:(BOOL)isSecondHalf 
		inPos:(int)ordinalPosition;

#if ASSERT_BASE_SCORES
- (void)verifyScoreFor:(Program *)program is:(float)correctScore;
#endif

#endif



@end
