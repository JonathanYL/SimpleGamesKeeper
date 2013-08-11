//
//  SGKNavView.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKNavView.h"

@implementation SGKNavView
@synthesize _systemName;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSystemLabel];
        [self initBackButton];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

// Instantiation
-(void)initBackButton {
    self._backButton = [[UIButton alloc] initWithFrame:CGRectMake(5,5,30,40)];
    self._backButton.backgroundColor = [UIColor blackColor];
    [self addSubview:self._backButton];
}

-(void)initSystemLabel {
    self._systemName = [[UILabel alloc] initWithFrame:CGRectMake(50,5,200,40)];
    self._systemName.textColor = [UIColor whiteColor];
    self._systemName.textAlignment = NSTextAlignmentCenter;
    self._systemName.font = [UIFont systemFontOfSize:14];
    self._systemName.backgroundColor = [UIColor blackColor];
    [self addSubview:self._systemName];
}

@end
