//
//  SkateScoreGuideAppDelegate.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/26/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "SkateScoreGuideAppDelegate.h"
#import "RootViewController.h"


@implementation SkateScoreGuideAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[UIView setAnimationsEnabled:YES];
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

