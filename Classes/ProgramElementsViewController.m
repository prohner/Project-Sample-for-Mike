//
//  ProgramElementsViewController.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramElementsViewController.h"
#import "ApplicationUtilities.h"
#import "ProgramElementDetailViewController.h"
#import "ProgramElementViewCell.h"

#define INDEXPATH_DUMMY_SECTION		2

@implementation ProgramElementsViewController

@synthesize program, headerView, headerLabelBaseScore, headerLabelGOEScore, headerLabelRange, btnSendEmail;


/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];

	toolbarForAddEdit = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 97, 44.01)];
	toolbarForAddEdit.barStyle = UIBarStyleBlackOpaque;
	
	// create the array to hold the buttons, which then gets added to the toolbar
	NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
	
	// create a standard "add" button
	UIBarButtonItem* bi = [[UIBarButtonItem alloc]
						   initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addElement)];
	bi.style = UIBarButtonItemStyleBordered;
	[buttons addObject:bi];
	[bi release];
	
	// create a spacer
	bi = [[UIBarButtonItem alloc]
		  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	[buttons addObject:bi];
	[bi release];
	
	// create a standard "edit" button
	[buttons addObject:self.editButtonItem];
	
	// stick the buttons in the toolbar
	[toolbarForAddEdit setItems:buttons animated:NO];
	
	[buttons release];
	
	// and put the toolbar in the nav bar
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:toolbarForAddEdit];
	
	self.title = program.description;
	
	programElements = [program programElements];

#ifdef DEBUG
	[self dumpProgramElements:@"ProgramElementsViewController init"];
#endif
	
	[ApplicationUtilities setupStandardTableLookFor:self.tableView inView:self.parentViewController.view];
	
	[headerView setFrame:CGRectMake(5, 5, 310, 68)];
	self.tableView.tableHeaderView = headerView;
	[self setScoreLabel];
	indexPathOfDummyElement = nil;

}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	programElements = [program programElements];
	
#ifdef DEBUG
	[self dumpProgramElements:@"In viewWillAppear"];
#endif

	NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
	if (selection) {
		[self.tableView deselectRowAtIndexPath:selection animated:YES];
	}
	
	[self.tableView reloadData];
	[self setScoreLabel];
}

#ifdef DEBUG
- (void)dumpProgramElements:(NSString *)message {
	NSLog(@"======================================%@", message);
	NSLog(@"           ID\t\tOrd\t2nd Half");
	for (int i = 0; i < [programElements count]; i++) {
		ProgramElement *pe = (ProgramElement *)[programElements objectAtIndex:i];		
		NSLog(@"Looking at %@%@\t%d\t%@", pe.ijsId, ([pe.ijsId length] < 4 ? @"  " : @""), pe.ordinalPosition, pe.isSecondHalf ? @"yes" : @"no");
	}
}
#endif

- (void) elementDetailViewControllerFor:(ProgramElement *)programElement {
	ProgramElementDetailViewController *addController = [[ProgramElementDetailViewController alloc] initWithNibName:@"ProgramElementDetailViewController" bundle:nil];
	addController.program = program;
	addController.existingProgramElement = programElement;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
	navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[self.navigationController presentModalViewController:navigationController animated:YES];
	[navigationController release];
	[addController release];

}
- (id) addElement {
	[self elementDetailViewControllerFor:nil];
	
	return self;
}


- (void) editButtonPushed:(id)sender {
	self.editing = NO;
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)setScoreLabel {
	ScoreSet scoreSet = [program programScore];
	headerLabelBaseScore.text = [[NSString alloc] initWithFormat:@"%i Element%@ Base Score: %.2f", scoreSet.elementsInProgram, (scoreSet.elementsInProgram > 1 ? @"s" : @""), scoreSet.baseScore];
	headerLabelGOEScore.text = [[NSString alloc] initWithFormat:@"Score with GOE: %.2f", scoreSet.scoreWithGOE];
	headerLabelRange.text = [[NSString alloc] initWithFormat:@"Range: %.2f - %.2f", scoreSet.rangeMinimumScore, scoreSet.rangeMaximumScore];

}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	BOOL isFirstHalf = (section == 0);
	int iRowCount = [program elementsInHalf:isFirstHalf];

	if (section == INDEXPATH_DUMMY_SECTION) {
		iRowCount = 1;
	}
    return iRowCount;
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section {
	NSString *title = @"First Half of Program";
	if (section == 1) {
		title = @"Second Half of Program";
	}
	UIView *v = nil;
	
	if (section < INDEXPATH_DUMMY_SECTION) {
		v = [ApplicationUtilities getStandardTableSectionHeaderFor:aTableView with:title];
	}
	
	return v;
}

- (ProgramElement *)programElementForRowAtIndexPath:(NSIndexPath *)indexPath {
	int iOffset = 0;
	if (indexPath.section == 1) {
		BOOL isFirstHalf = YES;
		iOffset = [program elementsInHalf:isFirstHalf];
	}
	
	int elementIndex = indexPath.row + iOffset;
	ProgramElement *programElement = nil;
	if (elementIndex < [programElements count]) {
		programElement = [[programElements objectAtIndex:elementIndex] retain];
	}

	return programElement;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//	if (indexPath.section == 1) {
//		return 0;
//	}
//	return 100;
//}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    const int LABEL_DESCRIPTION_TAG = 1;
//    const int LABEL_SCORE_TAG		= 2;
//    const int LABEL_GOE_TAG			= 3;
	
    NSString *CellIdentifier = @"ProgramElementViewCell";

	if (indexPath.section != INDEXPATH_DUMMY_SECTION) {
		NSLog(@"Processing section=%i, row=%i", indexPath.section, indexPath.row);
		ProgramElement *programElement = [self programElementForRowAtIndexPath:indexPath];
		
		@try {
			ProgramElementViewCell *cell = (ProgramElementViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

			if (cell == nil) {
				NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ProgramElementViewCell" owner:self options:nil];
				cell = [[topLevelObjects objectAtIndex:0] retain];
				[cell realInitialization];
				
			}

			cell.description.text = programElement.description;
			
#ifdef DEBUG
			NSLog(@"Scoring %@", programElement.description);
			NSLog(@"\tGOE Score %.2f", [programElement goeScore]);
#endif
			cell.baseScore.text = [[NSString alloc] initWithFormat:@"%.2f", [programElement baseScore]];
			cell.goeScore.text = [[NSString alloc] initWithFormat:@"%.2f", [programElement baseScore] + [programElement goeScore]];
			
			if ([[programElement estimatedGOE] isEqualToString:GOE_0]) {
				cell.goe.text = @"-";
			} else {
				cell.goe.text = [programElement estimatedGOE];
			}
			
			
			UIImage *rowBackground;
			UIImage *selectionBackground;
			NSInteger sectionRows = [tableView numberOfRowsInSection:[indexPath section]];
			NSInteger row = [indexPath row];
			if (row == 0 && row == sectionRows - 1) {
				rowBackground = [UIImage imageNamed:@"topAndBottomRow.png"];
				selectionBackground = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
			} else if (row == 0) {
				rowBackground = [UIImage imageNamed:@"topRow.png"];
				selectionBackground = [UIImage imageNamed:@"topRowSelected.png"];
			} else if (row == sectionRows - 1) {
				rowBackground = [UIImage imageNamed:@"bottomRow.png"];
				selectionBackground = [UIImage imageNamed:@"bottomRowSelected.png"];
			} else {
				rowBackground = [UIImage imageNamed:@"middleRow.png"];
				selectionBackground = [UIImage imageNamed:@"middleRowSelected.png"];
			}
			
			[cell setBackgroundImage:rowBackground andSelectionBackgroundImage:selectionBackground];

			return cell;
		}
		@catch (NSException * e) {
			NSString *msg = [e reason];
			NSLog(@"Exception thrown: %@", msg);
		}

	} else {
		@try {
			CellIdentifier = @"ProgramElementViewCell Dummy";
			UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
			if (cell == nil) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			}
			CGRect r = cell.bounds;
			r.size.width -= cell.indentationWidth * 2;
			[btnSendEmail setFrame:r];
			[cell.contentView addSubview:btnSendEmail];
			
			return cell;
		}
		@catch (NSException * e) {
			NSString *msg = [e reason];
			NSLog(@"Exception thrown: %@", msg);
		}
	}
	return nil;		
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	int index = [self arrayIndexFromIndexPath:indexPath];
	ProgramElement *programElementToEdit = (ProgramElement *)[[programElements objectAtIndex:index] retain];
	[self elementDetailViewControllerFor:programElementToEdit];
	[programElementToEdit release];
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
	if (indexPath.section == INDEXPATH_DUMMY_SECTION) {
		return NO;
	}
    return YES;
}

- (void)refreshDisplay:(UITableView *)tableView {
	[tableView reloadData]; 
	[self setScoreLabel];

}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
#if DEBUG	
		NSLog(@"Deleting at section %i, row %i", indexPath.section, indexPath.row);
#endif

		int index = [self arrayIndexFromIndexPath:indexPath];
		ProgramElement *deletee = (ProgramElement *)[programElements objectAtIndex:index];
		[deletee deleteObject];
		[programElements removeObjectAtIndex:index];
		[deletee release];
		[self setScoreLabel];

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    NSInteger row = 0;
    if (proposedDestinationIndexPath.section == INDEXPATH_DUMMY_SECTION) {
		row = [self tableView:tableView numberOfRowsInSection:1] - 1;
		if (row < 0) {
			row = 0;
		}
		return [NSIndexPath indexPathForRow:row inSection:1];     
    }
	return proposedDestinationIndexPath;
}

- (int)arrayIndexFromIndexPath:(NSIndexPath *)indexPath {
	int elementsInFirstHalf = [program elementsInHalf:YES];
#ifdef DEBUG
	NSLog(@"elementsInFirstHalf: %i", elementsInFirstHalf);
#endif
	return (indexPath.section == 1 ? elementsInFirstHalf : 0) + indexPath.row;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
	NSLog(@"Moving %i/%i to %i/%i", fromIndexPath.section, fromIndexPath.row, toIndexPath.section, toIndexPath.row);
	
	if (fromIndexPath.section == toIndexPath.section && fromIndexPath.row == toIndexPath.row) {
		// Not moving at all
		return;
	}
	
	int srcArrayIndex = [self arrayIndexFromIndexPath:fromIndexPath];
	int dstArrayIndex = [self arrayIndexFromIndexPath:toIndexPath];
	
	if (fromIndexPath.section == 0 && toIndexPath.section == 1) {
		// Moving from first half to second half, so the first half count is now too high
		dstArrayIndex--;
	}
	
	
#ifdef DEBUG
	NSLog(@"Src: %i, Dst: %i, array len=%i", srcArrayIndex, dstArrayIndex, [programElements count]);
#endif
	
	BOOL isMovingUp;
	if (srcArrayIndex > dstArrayIndex) {
		isMovingUp = YES;
	} else {
		isMovingUp = NO;
	}
	
	// Hold on to the mover
	ProgramElement *mover = (ProgramElement *)[[programElements objectAtIndex:srcArrayIndex] retain];
	mover.isSecondHalf = (toIndexPath.section == 1);
	[mover save];

	if (srcArrayIndex != dstArrayIndex) {
		// There may have been a change of section without actually changing the order of the elements
		int iTo = srcArrayIndex;
		int iFrom;
		
		do {
			if (isMovingUp) {
				iFrom = iTo - 1;
			} else {
				iFrom = iTo + 1;
			}
			
			ProgramElement *mv = (ProgramElement *)[[programElements objectAtIndex:iFrom] retain];
			[programElements replaceObjectAtIndex:iTo withObject:mv];
			
			if (isMovingUp) {
				iTo--;
			} else {
				iTo++;
			}
		} while (iTo != dstArrayIndex);
		
		[programElements replaceObjectAtIndex:dstArrayIndex withObject:mover];
	}
	
#ifdef DEBUG
	NSLog(@"The moved element: %@  %i %@", mover.ijsId, mover.ordinalPosition, (mover.isSecondHalf ? @"yes" : @"no"));
	[self dumpProgramElements:@"Before re-assign"];
#endif
	for (int i = 0; i < [programElements count]; i++) {
		ProgramElement *mv = (ProgramElement *)[[programElements objectAtIndex:i] retain];
		mv.ordinalPosition = i;
		[mv save];
	}
#ifdef DEBUG
	[self dumpProgramElements:@"After re-assign"];
#endif
	
	if (fromIndexPath.section != toIndexPath.section) {
		[self performSelector:(@selector(refreshDisplay:)) withObject:(tableView) afterDelay:0.5];
	}
	
}

 
 // Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
	if (indexPath.section == INDEXPATH_DUMMY_SECTION) {
		return NO;
	}
    return YES;
}

- (void)dealloc {
    [super dealloc];
	[programElements dealloc];
	[toolbarForAddEdit dealloc];
}


#pragma mark Email sending methods

- (IBAction)sendEmail:(id)sender {
	NSLog(@"Need to send email");
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	
	NSString *subject = [[NSString alloc] initWithFormat:@"Skating Program \"%@\"", program.description];
	NSString *body = @"<html><body><br /><br /><br />"
	"<table cellspacing=\"0\" border=\"1\">"
	"<tr><th colspan=\"4\"><!--title--></th></tr>"
	"<tr><th colspan=\"4\">First Half</th></tr>"
	"<th>Element</th>"
	"<th>Expected GOE</th>"
	"<th>Base Score</th>"
	"<th>GOE Score</th>"
	"<!--firsthalf-->"
	"<tr><th colspan=\"4\">Second Half</th></tr>"
	"<!--secondhalf-->"
	"<tr><th colspan=\"4\">Summary</th></tr>"
	"<!--scoresummary-->"
//	"<tr><th colspan=\"4\">Summary</th></tr>"
	"<!--salespitch-->"
	"</table>"
	"</body></html>";
	NSString *target = @"<!--title--></th>";
	body = [body stringByReplacingOccurrencesOfString:target withString:subject];
	for (ProgramElement *programElement in programElements) {
		target = @"<!--firsthalf-->";
		if (programElement.isSecondHalf) {
			target = @"<!--secondhalf-->";
		}
		NSString *row = [[NSString alloc] initWithFormat:@"<tr><td>%@</td><td align=\"center\">%@</td><td align=\"right\">%.2f</td><td align=\"right\">%.2f</td></tr>%@",
						 [programElement description],
						 [programElement.estimatedGOE isEqualToString:GOE_0] ? @"-" : programElement.estimatedGOE,
						 [programElement baseScore],
						 [programElement baseScore] + [programElement goeScore],
						 target];
		body = [body stringByReplacingOccurrencesOfString:target withString:row];
	}
	
	ScoreSet scores = [program programScore];
	NSString *scoreSummary = [[NSString alloc] initWithFormat:@"<tr><td colspan=\"4\">"
							  "There are %i elements giving a base score of %.2f.<br />"
							  "The anticipated GOE score is %.2f.<br />"
							  "The score range is %.2f - %.2f.<br />"
							  "</td></tr>",
							  scores.elementsInProgram,
							  scores.baseScore,
							  scores.scoreWithGOE,
							  scores.rangeMinimumScore,
							  scores.rangeMaximumScore
							  ];
	target = @"<!--scoresummary-->";
	body = [body stringByReplacingOccurrencesOfString:target withString:scoreSummary];

	NSString *salesPitch = [[NSString alloc] initWithFormat:@"<tr><td colspan=\"4\">"
						   "Results presented by %@.<br />"
						   "<a href=\"http://cooltoolapps.appspot.com/\">Learn more.</a><br />"
						   "</td></tr>",
						   APPLICATION_NAME
						   ];						  
	target = @"<!--salespitch-->";
	body = [body stringByReplacingOccurrencesOfString:target withString:salesPitch];

	[controller setSubject:subject];
	
	[controller setMessageBody:body isHTML:YES]; 
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
	if (result == MFMailComposeResultSent) {
		NSLog(@"It's away!");
	}
	[self dismissModalViewControllerAnimated:YES];
}



@end

