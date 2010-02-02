//
//  ApplicationUtilities.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ApplicationUtilities.h"


@implementation ApplicationUtilities

+(void)setupStandardTableLookFor:(UITableView *)tableView inView:(UIView *)aView  {
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	tableView.backgroundColor = [UIColor clearColor];
	[self setGeneralViewLookFor:aView];

}

+(void)setGeneralViewLookFor:(UIView *)aView  {
	aView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground.jpg"]];
}

+(void)setGeneralButtonLookFor:(UIButton *)aButton {
	UIImage *buttonBackground = [UIImage imageNamed:@"whiteButtonBackground.png"];
	UIImage *newImage = [buttonBackground stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
	[aButton setBackgroundImage:newImage forState:UIControlStateNormal];
}

+(UIView *)getStandardTableSectionHeaderFor:(UITableView *)tableView with:(NSString *)description {

    tableView.sectionHeaderHeight = 35;
    UIView *sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, tableView.bounds.size.width, 35)];
	
	UILabel *lblDescription = [[UILabel alloc] initWithFrame:CGRectMake(8, 2, 320, 30)];
	lblDescription.textColor = [UIColor whiteColor];
	lblDescription.shadowColor = [UIColor blackColor];
	lblDescription.shadowOffset = CGSizeMake(0, 1);
	lblDescription.font = [UIFont boldSystemFontOfSize:18];
	lblDescription.backgroundColor = [UIColor clearColor];
	lblDescription.text = description;
	
	[sectionHeaderView addSubview:lblDescription];

	return sectionHeaderView;	
}

@end
