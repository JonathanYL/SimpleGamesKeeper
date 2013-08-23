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

- (id)initWithFrame:(CGRect)frame andIndex:(int)index
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initSystemLabel:index];
        [self initBackButton];
        [self initBorderLine];
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
    self._backButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,26,self.frame.size.height)];
    [self._backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIFont *customFont = [UIFont fontWithName:@"Marker Felt" size:26.0f];
    [self._backButton.titleLabel setFont:customFont];
    [self._backButton setTitle:@"<" forState:UIControlStateNormal];
    self._backButton.backgroundColor = [UIColor clearColor];
    [self addSubview:self._backButton];
}

- (void)initSystemLabel:(int)carouselIndex {
    // Generic Customization
    self._systemName = [[UILabel alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    self._systemName.textColor = [UIColor whiteColor];
    self._systemName.textAlignment = NSTextAlignmentCenter;
    UIFont *customFont = [UIFont fontWithName:@"Marker Felt" size:23.0f];
    [self._systemName setFont:customFont];
    self._systemName.backgroundColor = [UIColor clearColor];
    // Get's a little different here.
    switch (carouselIndex) {
        case 0:
            self.backgroundColor = [UIColor purpleColor];
            self._systemName.text = @"PC Games List";
            break;
        case 1:
            self.backgroundColor = [UIColor blueColor];
            self._systemName.text = @"Sony Games List";
            break;
        case 2:
            self.backgroundColor = [UIColor greenColor];
            self._systemName.text = @"Microsoft Games List";
            break;
        case 3:
            self.backgroundColor = [UIColor redColor];
            self._systemName.text = @"Nintendo Games List";
            break;
        case 4:
            self.backgroundColor = [UIColor orangeColor];
            self._systemName.text = @"Misc Games List";
            break;
        default:
            self.backgroundColor = [UIColor grayColor];
            break;
    }
    [self addSubview:self._systemName];
}

- (void)initBorderLine {
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), CGRectGetWidth(self.frame), 1)];
    border.backgroundColor = [UIColor darkGrayColor];
    [self addSubview:border];
}
@end
