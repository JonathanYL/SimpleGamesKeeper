//
//  SGKListViewController.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGKNavView.h"

@interface SGKListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) SGKNavView *navBar;
@property (nonatomic, strong) UITableView *_gamesTableView;
@property (nonatomic, strong) NSDictionary *_gamesList;
@property (nonatomic, strong) UISearchBar *_searchBar;

- (id)initWithIndex:(int)carouselIndex;
- (void)fetchGamesList;
@end
