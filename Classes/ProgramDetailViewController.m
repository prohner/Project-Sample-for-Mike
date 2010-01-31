//
//  ProgramDetailViewController.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramDetailViewController.h"
#import "ApplicationUtilities.h"
#import "ProgramGroup.h"

@implementation ProgramDetailViewController

@synthesize description;

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

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelProgram)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWithProgram)] autorelease];

	programGroups = [[ProgramGroup allObjects] retain];
	selectedProgramGroupIndex = 0;
	
	[ApplicationUtilities setupStandardTableLookFor:self.tableView inView:self.parentViewController.view];
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

- (void)doneWithProgram {
	Program *newProgram = [[Program alloc] init];
	newProgram.description = description.text;

	[self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)cancelProgram {
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 1;
	} else {
		return [programGroups count]; 
	}
}

- (UIView *)tableView:(UITableView *)aTableView viewForHeaderInSection:(NSInteger)section {
	UIView *v;
	switch (section) {
		case 0:
			v = [ApplicationUtilities getStandardTableSectionHeaderFor:aTableView with:@"Enter Program Description:"];
			break;
		case 1:
			v = [ApplicationUtilities getStandardTableSectionHeaderFor:aTableView with:@"Choose Group for New Program:"];
			break;
		default:
			break;
	}
	
	
	return v;
}

// Customize the appearance of table view cells.

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	NSString *CellIdentifier = [[NSString alloc] initWithFormat: @"Cell", indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		if (indexPath.section == 0) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			cell.backgroundColor = [UIColor clearColor];
			CGRect r = cell.contentView.bounds;
			r.origin.x = cell.indentationWidth + 2;
			r.origin.y += 2;
			r.size.width -= cell.indentationWidth * 2 + 2;
			r.size.height -= 4;
			//		[description setFrame:r];
			[cell addSubview:description];
		} else {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 5, 270, 30)];
			lbl.tag = 1;
			[cell addSubview:lbl];
			[lbl release];
		}	
    }
    
    // Set up the cell...
	if (indexPath.section == 1) {
		if (indexPath.row == selectedProgramGroupIndex) {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
		UILabel *lbl = (UILabel *)[cell viewWithTag:1];
#ifdef DEBUG
		NSLog(@"We're in section 1, looking at row %i", indexPath.row);
#endif
		lbl.text = ((ProgramGroup *)[programGroups objectAtIndex:indexPath.row]).description;
	}
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	if (indexPath.section == 1) {
		UITableViewCell *cell;
		
		cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedProgramGroupIndex inSection:1]];
		cell.accessoryType = UITableViewCellAccessoryNone;
		
		cell = [self.tableView cellForRowAtIndexPath:indexPath];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
		
		selectedProgramGroupIndex = indexPath.row;
		
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


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


@end

