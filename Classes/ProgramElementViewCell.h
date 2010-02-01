//
//  ProgramElementViewCell.h
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgramElementViewCell : UITableViewCell {
	UILabel *description;
	UILabel *baseScore;
	UILabel *goeScore;
	UILabel *goe;
}

@property (nonatomic, retain) IBOutlet UILabel *description;
@property (nonatomic, retain) IBOutlet UILabel *baseScore;
@property (nonatomic, retain) IBOutlet UILabel *goeScore;
@property (nonatomic, retain) IBOutlet UILabel *goe;

@end
