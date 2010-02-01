//
//  ProgramElementViewCell.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramElementViewCell.h"
#import "ApplicationUtilities.h"

@implementation ProgramElementViewCell

@synthesize description, baseScore, goeScore, goe;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
//		UIImage *indicatorImage = [UIImage imageNamed:@"indicator.png"];
//		self.accessoryView = [[[UIImageView alloc] initWithImage:indicatorImage] autorelease];

		self.description.adjustsFontSizeToFitWidth = YES;
		self.description.lineBreakMode = UILineBreakModeWordWrap;
		self.description.numberOfLines = 0;
		self.description.textColor = TABLE_MAIN_LABEL_TEXT_COLOR;
		self.description.highlightedTextColor = TABLE_MAIN_LABEL_HIGHLIGHT_TEXT_COLOR;
		self.description.backgroundColor = [UIColor redColor];
//		self.backgroundView			= [[[UIImageView alloc] init] autorelease];
//		self.backgroundView			= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topAndBottomRow.png"]] autorelease];
//		self.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];
    
	}
    return self;
}

- (void)realInitialization {
	self.description.adjustsFontSizeToFitWidth = YES;
	self.description.lineBreakMode = UILineBreakModeWordWrap;
	self.description.numberOfLines = 0;
	self.description.textColor = TABLE_MAIN_LABEL_TEXT_COLOR;
	self.description.highlightedTextColor = TABLE_MAIN_LABEL_HIGHLIGHT_TEXT_COLOR;
	self.backgroundView			= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topAndBottomRow.png"]] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.backgroundView			= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topAndBottomRow.png"]] autorelease];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

//	if (selected) {
//		self.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topAndBottomRow.png"]] autorelease];
//	} else {
//		self.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topAndBottomRow.png"]] autorelease];
//	}
}

- (void)setBackgroundImage:(UIImage *)rowBackground andSelectionBackgroundImage:(UIImage *)selectionBackground {
	UIImageView *iv;
	
	iv = (UIImageView *)self.backgroundView;
	iv.image = rowBackground;

//	iv = (UIImageView *)self.selectedBackgroundView;
//	iv.image = selectionBackground;
}

- (void)dealloc {
    [super dealloc];
}


@end
