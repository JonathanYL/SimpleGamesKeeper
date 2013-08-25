//
//  SGKTileReflectionView.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-24.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ReflectionView.h"

@interface SGKTileReflectionView : ReflectionView

@property (strong, nonatomic) UIImageView *_imageView;
- (void)initImage:(UIImage *)image;
@end
