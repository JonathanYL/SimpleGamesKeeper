//
//  SGKTileReflectionView.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-24.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SGKTileReflectionView.h"

@implementation SGKTileReflectionView

@synthesize _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dynamic = YES;
        self.reflectionScale = 0.3;
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

- (void)initImage:(UIImage *)image {
    self._imageView = [[UIImageView alloc] initWithFrame:self.frame];
    self._imageView.image = image;
    [self addSubview:self._imageView];
}
@end
