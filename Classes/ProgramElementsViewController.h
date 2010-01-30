//
//  ProgramElementsViewController.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Program.h"
#import "ProgramElement.h"

@interface ProgramElementsViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
	Program *program;
	NSMutableArray *programElements;
	UIView *headerView;
	UILabel *headerLabelBaseScore;
	UILabel *headerLabelGOEScore;
	UILabel *headerLabelRange;
	UIButton *btnSendEmail;
	NSIndexPath *indexPathOfDummyElement;
}

@property (nonatomic, retain) Program *program;
@property (nonatomic, retain) IBOutlet UIView *headerView;
@property (nonatomic, retain) IBOutlet UILabel *headerLabelBaseScore;
@property (nonatomic, retain) IBOutlet UILabel *headerLabelGOEScore;
@property (nonatomic, retain) IBOutlet UILabel *headerLabelRange;
@property (nonatomic, retain) IBOutlet UIButton *btnSendEmail;

- (ProgramElement *)programElementForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)setScoreLabel;
- (id) addElement;
- (void) editButtonPushed:(id)sender;
- (int)arrayIndexFromIndexPath:(NSIndexPath *)indexPath;
- (IBAction)sendEmail:(id)sender;


#ifdef DEBUG
- (void)dumpProgramElements:(NSString *)message;
#endif

@end
