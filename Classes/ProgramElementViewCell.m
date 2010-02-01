//
//  ProgramElementViewCell.m
//  SkateScoreGuide
//
//  Created by Preston Rohner on 1/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ProgramElementViewCell.h"


@implementation ProgramElementViewCell

@synthesize description, baseScore, goeScore, goe;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
