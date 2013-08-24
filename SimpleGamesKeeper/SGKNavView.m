//
//  SGKNavView.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKNavView.h"

#define PlayStationColor [UIColor colorWithRed:17.0f/255.0f green:98.0f/255.0f blue:175.0f/255.0f alpha:1.0f]
#define XboxColor [UIColor colorWithRed:119.0f/255.0f green:177.0f/255.0f blue:54.0f/255.0f alpha:1.0f]
#define NintendoColor [UIColor colorWithRed:236.0f/255.0f green:79.0f/255.0f blue:76.0f/255.0f alpha:1.0f]
#define EverythingColor [UIColor colorWithRed:255.0f/255.0f green:167.0f/255.0f blue:77.0f/255.0f alpha:1.0f]
#define PCColor [UIColor colorWithRed:213.0f/255.0f green:134.0f/255.0f blue:221.0f/255.0f alpha:1.0f]

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
            self.backgroundColor = PCColor;
            self._systemName.text = @"PC Games";
            break;
        case 1:
            self.backgroundColor = PlayStationColor;
            self._systemName.text = @"Playstation Games";
            break;
        case 2:
            self.backgroundColor = XboxColor;
            self._systemName.text = @"Xbox Games";
            break;
        case 3:
            self.backgroundColor = NintendoColor;
            self._systemName.text = @"Nintendo Games";
            break;
        case 4:
            self.backgroundColor = EverythingColor;
            self._systemName.text = @"Everything!";
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
