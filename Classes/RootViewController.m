//
//  RootViewController.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "ApplicationUtilities.h"
#import "ProgramElementsViewController.h"
#import "ProgramDetailViewController.h"
#import "ProgramGroupViewController.h"

@implementation RootViewController

@synthesize imageView, tableView, btnShareAppWithFriend, btnFeedback, btnOrganizeProgramGroups, myTableFooterView;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = APPLICATION_NAME;
	
    // Set up the buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																			   target:self 
																			   action:@selector(addProgram)];
    self.navigationItem.rightBarButtonItem = addButton;
	
#if LOAD_TEST_DATA
	ProgramGroup *pg1 = [[ProgramGroup alloc] init];
	pg1.description = @"Lexi's Programs";
	pg1.ordinalPosition = 0;
	[pg1 save];

	ProgramGroup *pg2 = [[ProgramGroup alloc] init];
	pg2.description = @"Old Programs";
	pg2.ordinalPosition = 1;
	[pg2 save];
	
	Program *p1 = [[Program alloc] init];
	p1.description = @"Nationals Long";
	p1.programGroup = pg1;
	p1.ordinalPosition = 0;
	[p1 save];
	
//	Program *p2 = [[Program alloc] init];
//	p2.description = @"Sectionals";
//	p2.programGroup = pg1;
//	p2.ordinalPosition = 1;
//	[p2 save];

	Program *p3 = [[Program alloc] init];
	p3.description = @"Regionals Short";
	p3.programGroup = pg2;
	p3.ordinalPosition = 2;
	[p3 save];

//	Program *p4 = [[Program alloc] init];
//	p4.description = @"Regionals Long";
//	p4.programGroup = pg2;
//	p4.ordinalPosition = 3;
//	[p4 save];

	ProgramElement *pe1 = [[ProgramElement alloc] init];
	pe1.ijsId				= @"2T";
	pe1.ordinalPosition		= 0;
	pe1.estimatedGOE		= GOE_plus_1;
	pe1.program				= p1;
	pe1.isSecondHalf		= NO;
	[pe1 save];
	
	ProgramElement *pe2 = [[ProgramElement alloc] init];
	pe2.ijsId				= @"LSp2";
	pe2.ordinalPosition		= 1;
	pe2.estimatedGOE		= GOE_0;
	pe2.program				= p1;
	pe2.isSecondHalf		= NO;
	[pe2 save];
	
	ProgramElement *pe3 = [[ProgramElement alloc] init];
	pe3.ijsId				= @"1A";
	pe3.ordinalPosition		= 2;
	pe3.estimatedGOE		= GOE_minus_1;
	pe3.program				= p1;
	pe3.isSecondHalf		= YES;
	[pe3 save];
	
	ProgramElement *pe4 = [[ProgramElement alloc] init];
	pe4.ijsId				= @"SSp2";
	pe4.ordinalPosition		= 3;
	pe4.estimatedGOE		= GOE_plus_2;
	pe4.program				= p1;
	pe4.isSecondHalf		= YES;
	[pe4 save];
	
	ProgramElement *pe5 = [[ProgramElement alloc] init];
	pe5.ijsId				= @"2Lz";
	pe5.ordinalPosition		= 4;
	pe5.estimatedGOE		= GOE_plus_2;
	pe5.program				= p1;
	pe5.isSecondHalf		= YES;
	[pe5 save];

	ProgramElement *pe6 = [[ProgramElement alloc] init];
	pe6.ijsId				= @"2F";
	pe6.ordinalPosition		= 0;
	pe6.estimatedGOE		= GOE_plus_1;
	pe6.program				= p3;
	pe6.isSecondHalf		= NO;
	[pe6 save];
	
	ProgramElement *pe7 = [[ProgramElement alloc] init];
	pe7.ijsId				= @"SSp1";
	pe7.ordinalPosition		= 0;
	pe7.estimatedGOE		= GOE_0;
	pe7.program				= p3;
	pe7.isSecondHalf		= YES;
	[pe7 save];
	
#if LOAD_TEST_DATA_FOR_SOV_VALIDATION

	ProgramGroup *pg3 = [[ProgramGroup alloc] init];
	pg3.description = @"Scale of Value Tests";
	pg3.ordinalPosition = 2;
	[pg3 save];
	
	for (int i = 0; i < 6; i++) {
		NSString *goe;
		switch (i) {
			case 0:
				goe = GOE_0;
				break;
			case 1:
				goe = GOE_plus_1;
				break;
			case 2:
				goe = GOE_plus_2;
				break;
			case 3:
				goe = GOE_plus_3;
				break;
			case 4:
				goe = GOE_minus_1;
				break;
			case 5:
				goe = GOE_minus_2;
				break;
			case 6:
				goe = GOE_minus_3;
				break;
			default:
				NSAssert(@"Invalid setting up test data", @"whatever");
				break;
		}

		Program *allEll = [[Program alloc] init];
		allEll.description = [[NSString alloc] initWithFormat:@"SOV %@", goe];
		allEll.programGroup = pg3;
		allEll.ordinalPosition = i;
		[allEll save];
		
		for (int k = 0; k < 3; k++) {
			NSArray *array;
			switch (k) {
				case 0:
					array = [Elements groupOfElements:ELEMENT_GROUP_JUMPS];
					break;
				case 1:
					array = [Elements groupOfElements:ELEMENT_GROUP_SPINS];
					break;
				case 2:
					array = [Elements groupOfElements:ELEMENT_GROUP_STEP_SPIRAL];
					break;
				default:
					break;
			}
			
			for (int j = 0; j < [array count]; j++) {
				Element *e = (Element *)[[array objectAtIndex:j] retain];
				ProgramElement *pe = [[ProgramElement alloc] init];
				pe.ijsId			= e.ijsId;
				pe.ordinalPosition	= j;
				pe.estimatedGOE		= goe;
				pe.program			= allEll;
				pe.isSecondHalf		= NO;
				[pe save];
			}
		}

	}
#endif
	
	[p1 release];
//	[p2 release];
	[p3 release];
//	[p4 release];
	[pg1 release];
	[pg2 release];
#endif
	
	[ApplicationUtilities setupStandardTableLookFor:tableView inView:self.parentViewController.view];
	tableView.rowHeight = 85;
	tableView.tableFooterView = myTableFooterView;
	
	[ApplicationUtilities setGeneralButtonLookFor:btnShareAppWithFriend];
	[ApplicationUtilities setGeneralButtonLookFor:btnFeedback];
	[ApplicationUtilities setGeneralButtonLookFor:btnOrganizeProgramGroups];

}

- (void)loadData {
	programGroupPrograms = [[NSMutableArray alloc] init];
	// Create an array of arrays of programs for each section (program group)
	for (int i = 0; i < [programGroups count]; i++) {
		ProgramGroup *programGroup = (ProgramGroup *)[[programGroups objectAtIndex:i] retain];
		NSMutableArray *programs = [[programGroup findRelated:[Program class]] mutableCopy];
		[programGroupPrograms addObject:programs];
	}
	
}

- (id)addProgram {
	ProgramDetailViewController *addController = [[ProgramDetailViewController alloc] initWithNibName:@"ProgramDetailViewController" bundle:nil];
	//addController.program = program;
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
	navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[self.navigationController presentModalViewController:navigationController animated:YES];
	[navigationController release];
	[addController release];

	return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	programGroups = [[ProgramGroup findByCriteria: @"WHERE 1 = 1"] retain];
	[self loadData];
	[self.tableView reloadData];
}

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
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [programGroups count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
	int count = 1;
	if (section < [programGroups count]) {
		NSArray *programs = [[programGroupPrograms objectAtIndex:section] retain];
		count = [programs count];
		[programs release];
	}
    return count;
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section {
	UIView *v = nil;
	if (section < [programGroups count]) {
		ProgramGroup *pg = (ProgramGroup *)[[programGroups objectAtIndex:section] retain];
		v = [ApplicationUtilities getStandardTableSectionHeaderFor:aTableView with:pg.description];
	}
	
	return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	CGFloat f = 40;
	if (indexPath.section < [programGroups count]) {
		f = 85;
	}
	
	return f;
}

- (Program *)programForRowAtIndexPath:(NSIndexPath *)indexPath {
//	if (indexPath.section < [programGroupPrograms count]) {
//		return nil;
//	}
	NSArray *programs = [[programGroupPrograms objectAtIndex:indexPath.section] retain];
	Program *program = [[programs objectAtIndex:indexPath.row] retain];
	return program;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	const CGFloat LABEL_HEIGHT = 23;
	UILabel *topLabel;
	UILabel *bottomLabel;
	
	BOOL isButtonCell = NO;
    
    NSString *CellIdentifier = @"Cell Regular";
	if (indexPath.section >= [programGroups count]) {
		isButtonCell = YES;
		CellIdentifier = @"Cell Button";
	}
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		if (isButtonCell) {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			CGRect r1 = cell.bounds;
			r1.origin.x = 10;
			r1.origin.y = 0;
			r1.size.width = 93;
			[btnOrganizeProgramGroups setFrame:r1];
			
			CGRect r2 = cell.bounds;
			r2.origin.x = 103;
			r2.origin.y = 0;
			r2.size.width = 93;
			[btnShareAppWithFriend setFrame:r2];
			
			CGRect r3 = cell.bounds;
			r3.origin.x = 206;
			r3.origin.y = 0;
			r3.size.width = 93;
			[btnShareAppWithFriend setFrame:r2];
			
			[cell.contentView addSubview:btnOrganizeProgramGroups];
			[cell.contentView addSubview:btnShareAppWithFriend];
			[cell.contentView addSubview:btnFeedback];
			
			return cell;
		} else {
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
			
			UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
			cell.accessoryView = [[[UIImageView alloc] initWithImage:indicatorImage] autorelease];
			
			UIImage *image = [UIImage imageNamed:@"imageA.png"];
			
			topLabel = [[[UILabel alloc] initWithFrame:CGRectMake(image.size.width + 2.0 * cell.indentationWidth,
																0.25 * (aTableView.rowHeight - 2 * LABEL_HEIGHT),
																aTableView.bounds.size.width - image.size.width - 4.0 * cell.indentationWidth - indicatorImage.size.width,
																LABEL_HEIGHT)] 
						autorelease];
			[cell.contentView addSubview:topLabel];
			
			topLabel.tag = TOP_LABEL_TAG;
			topLabel.backgroundColor = [UIColor clearColor];
			topLabel.textColor = TABLE_MAIN_LABEL_TEXT_COLOR;
			topLabel.highlightedTextColor = TABLE_MAIN_LABEL_HIGHLIGHT_TEXT_COLOR;
			topLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] + 2];

			bottomLabel = [[[UILabel alloc] initWithFrame:CGRectMake(image.size.width + 2.0 * cell.indentationWidth, 
																	 -4 + 0.5 * (aTableView.rowHeight - 2 * LABEL_HEIGHT) + LABEL_HEIGHT, 
																	 aTableView.bounds.size.width - image.size.width - 4.0 * cell.indentationWidth - indicatorImage.size.width, 
																	 LABEL_HEIGHT)] 
						   autorelease];
			bottomLabel.numberOfLines = 2;
			[cell.contentView addSubview:bottomLabel];
			
			bottomLabel.tag = BOTTOM_LABEL_TAG;
			bottomLabel.backgroundColor = [UIColor clearColor];
			bottomLabel.textColor = TABLE_SUB_LABEL_TEXT_COLOR;
			bottomLabel.highlightedTextColor = TABLE_SUB_LABEL_HIGHLIGHT_TEXT_COLOR;
			bottomLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize] - 2];
			
			cell.backgroundView = [[[UIImageView alloc] init] autorelease];
			cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
		}

		
		
    }
    
	if ( ! isButtonCell) {
		UIImage *rowBackground;
		UIImage *selectionBackground;
		NSInteger sectionRows = [aTableView numberOfRowsInSection:[indexPath section]];
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
		((UIImageView *)cell.backgroundView).image = rowBackground;
		((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;
		
		topLabel = (UILabel *)[cell viewWithTag:TOP_LABEL_TAG];
		bottomLabel = (UILabel *)[cell viewWithTag:BOTTOM_LABEL_TAG];

		// Configure the cell.
		Program *program = [self programForRowAtIndexPath:indexPath];
		if (program != nil) {
			topLabel.text = program.description;
			bottomLabel.text = program.programSubDescription;
			
			CGRect r = CGRectMake(85, 
								  35, 
								  bottomLabel.bounds.size.width, 
								  LABEL_HEIGHT);
			if ([bottomLabel.text rangeOfString:@"\n"].length != 0) {
				r.size.height *= 2;
			}
			[bottomLabel setFrame:r];
			
			cell.imageView.image = [UIImage imageNamed:@"imageA.png"];
		} else {
			topLabel.text = @"";
			bottomLabel.text = @"";
		}
	}
    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	ProgramElementsViewController *programElementsViewController = [[ProgramElementsViewController alloc] initWithNibName:@"ProgramElementsViewController" bundle:nil];
	programElementsViewController.program = [self programForRowAtIndexPath:indexPath];
	[self.navigationController pushViewController:programElementsViewController animated:YES];
	[programElementsViewController release];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Override to support editing the table view.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		NSMutableArray *programs = [[programGroupPrograms objectAtIndex:indexPath.section] retain];
		Program *programToDelete = (Program *)[[programs objectAtIndex:indexPath.row] retain];
		[programs removeObjectAtIndex:indexPath.row];
		[programToDelete deleteObjectCascade:YES];

        [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}

#pragma mark Button action methods
- (IBAction)buttonTapped:(id)sender {
	if (sender == btnShareAppWithFriend) {
		[self shareAppWithFriend];
	} else if (sender == btnFeedback) {
		[self sendFeedback];
	} else if (sender == btnOrganizeProgramGroups) {
		[self organizeProgramGroups];
	}
}

- (void)shareAppWithFriend {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	controller.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	NSString *subject = [[NSString alloc] initWithFormat:@"%@ on iPhone/iTouch", APPLICATION_NAME];
	NSString *message = @"Check out this app I've been using to calculate my figure skating IJS scores.";

	[controller setSubject:subject];
	
	[controller setMessageBody:message isHTML:YES]; 
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)sendFeedback {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	controller.navigationBar.barStyle = UIBarStyleBlackOpaque;
	
	NSString *subject = [[NSString alloc] initWithFormat:@"%@ Feedback", APPLICATION_NAME];
	NSString *message = @"Describe your feedback.";
	
	[controller setToRecipients:[NSArray arrayWithObject:@"prestonrohner@me.com"]];
	[controller setSubject:subject];
	
	[controller setMessageBody:message isHTML:YES]; 
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

- (void)organizeProgramGroups {
	ProgramGroupViewController *programGroupsViewController = [[ProgramGroupViewController alloc] initWithNibName:@"ProgramGroupViewController" bundle:nil];
	[self.navigationController pushViewController:programGroupsViewController animated:YES];
	[programGroupsViewController release];
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

