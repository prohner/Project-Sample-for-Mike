//
//  ProgramGroupViewController.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramGroupViewController.h"
#import "ApplicationUtilities.h"
#import "ProgramGroupAddController.h"

@implementation ProgramGroupViewController

@synthesize programGroupDescription, cannotDeleteWarningView;

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
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

	[ApplicationUtilities setupStandardTableLookFor:self.tableView inView:self.parentViewController.view];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																			   target:self 
																			   action:@selector(addProgramGroup)];
	self.navigationItem.leftBarButtonItem = addButton;

	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																			   target:self 
																			   action:@selector(doneWithProgramGroups)];
	self.navigationItem.rightBarButtonItem = doneButton;
	
	self.title = @"Program Groups";
	self.editing = YES;
	
	self.tableView.tableFooterView = cannotDeleteWarningView;

}

- (void)addProgramGroup {
	ProgramGroupAddController *addController = [[ProgramGroupAddController alloc] initWithNibName:@"ProgramGroupAddController" bundle:nil];
	UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
	navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[self.navigationController presentModalViewController:navigationController animated:YES];
	[navigationController release];
	[addController release];
	
}

- (void)doneWithProgramGroups {
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	programGroups = [[[ProgramGroup findByCriteria: @"WHERE 1 = 1"] retain] mutableCopy];
	cannotDeleteWarningView.hidden = [programGroups count] > 1;
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
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [programGroups count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	ProgramGroup *pg = (ProgramGroup *)[programGroups objectAtIndex:indexPath.row];
	cell.textLabel.text = pg.description;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
	if ([programGroups count] > 1) {
		return YES;
	} else {
		return NO;
	}
}




// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		int iDefaultIndex = -1;
		for (iDefaultIndex = 0; iDefaultIndex < [programGroups count]; iDefaultIndex++) {
			if (iDefaultIndex != indexPath.row) {
				break;
			}
		}
		NSAssert(iDefaultIndex >= 0, @"Error finding default index.");
		
		ProgramGroup *defaultProgramGroup = [[programGroups objectAtIndex:iDefaultIndex] retain];
		ProgramGroup *deletedProgramGroup = [[programGroups objectAtIndex:indexPath.row] retain];
		NSArray *programs = [deletedProgramGroup findRelated:[Program class]];
		for (Program *program in programs) {
			program.programGroup = defaultProgramGroup;
			[program save];
		}
		
		[deletedProgramGroup deleteObject];
		[programGroups removeObjectAtIndex:indexPath.row];

		cannotDeleteWarningView.hidden = [programGroups count] > 1;

        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    } else if (editingStyle == UITableViewCellEditingStyleNone) {
		[self dismissModalViewControllerAnimated:YES];
	}

}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


- (void)dealloc {
    [super dealloc];
}


@end

