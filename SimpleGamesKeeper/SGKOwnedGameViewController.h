//
//  SGKOwnedGameViewController.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-30.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGKNavView.h"
#import "Game.h"

@interface SGKOwnedGameViewController : UIViewController

@property (nonatomic, strong) SGKNavView *navBar;
@property (nonatomic, strong) Game* _myGame;
@property (nonatomic, strong) UIScrollView *_scrollView;
@property (nonatomic, strong) UIView *_overlayView;
@property (nonatomic, strong) UIActivityIndicatorView *_activityIndicator;

- (id)initWithGame:(Game *)game with:(int)carouselIndex;
@end
