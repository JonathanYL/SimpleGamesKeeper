//
//  SGKListViewController.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGKNavView.h"

@interface SGKListViewController : UIViewController

@property (nonatomic, strong) SGKNavView *navBar;

- (id)initWithIndex:(int)carouselIndex;
@end
