//
//  SGKTableViewCell.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-05.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKTableViewCell.h"

@implementation SGKTableViewCell

@synthesize _gameNameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initGameNameLabel];
    }
    return self;
}


- (void)initGameNameLabel {
    self._gameNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self._gameNameLabel.backgroundColor = [UIColor clearColor];
    UIFont *sampleFont = [UIFont fontWithName:@"Helvetica" size:12.0];
    [self._gameNameLabel setFont:sampleFont];
    self._gameNameLabel.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
