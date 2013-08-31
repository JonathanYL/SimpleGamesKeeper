//
//  SGKListViewController.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGKNavView.h"

@interface SGKListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, SGKNavViewDelegate>

@property (nonatomic, strong) SGKNavView *navBar;
@property (nonatomic, strong) UITableView *_gamesTableView;
@property (nonatomic, strong) UISearchBar *_searchBar;
@property (nonatomic, strong) UIActivityIndicatorView *_activityIndicator;
@property (nonatomic, strong) UIView *_overlayView;

// API
@property (nonatomic, strong) NSMutableDictionary *_gamesDictionary;
@property (nonatomic, strong) NSMutableArray *_gamesArray;
@property (nonatomic) int pageNum;
@property (nonatomic) int fetchBatch;
@property (nonatomic) BOOL loading;
@property (nonatomic) BOOL noMoreResultsAvail;


- (id)initWithIndex:(int)carouselIndex;
@end
