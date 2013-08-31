//
//  SGKGameCollectionViewController.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-28.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGKNavView.h"

@interface SGKGameCollectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) SGKNavView *navBar;
@property (nonatomic, strong) UITableView *_gamesCollectionTableView;

- (id)initWithIndex:(int)carouselIndex;

@end
