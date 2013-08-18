//
//  SGKGameViewController.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-11.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGKNavView.h"
#import "GameModel.h"

@interface SGKGameViewController : UIViewController

@property (nonatomic, strong) SGKNavView *navBar;
@property (nonatomic, strong) NSDictionary *_gameResult;
@property (nonatomic, strong) UIScrollView *_scrollView;
@property (nonatomic, strong) GameModel *_game;

- (id)initWithURLDetail:(NSString *)urlString andIndex:(int)carouselIndex;
- (void)initGameModelClassAndPushNavigationController;
- (void)initMainView;
@end
