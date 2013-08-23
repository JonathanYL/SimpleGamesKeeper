//
//  SGKListViewController.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKListViewController.h"
#import "DataLoader.h"
#import "SGKGameViewController.h"

@interface SGKListViewController () {
    int index;
}
@end

@implementation SGKListViewController

@synthesize navBar = _navBar;
@synthesize _gamesTableView;
@synthesize _gamesDictionary;
@synthesize _gamesArray;
@synthesize _searchBar;

@synthesize fetchBatch;
@synthesize loading;
@synthesize noMoreResultsAvail;
@synthesize pageNum;

- (id)initWithIndex:(int)carouselIndex {
    self = [super init];
    if (self) {
        index = carouselIndex;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initNavBar:index];
    [self initSearchBar];
    [self initGamesTableView];
    
    // Needs to be changed to delegate function
    [_navBar._backButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    
    pageNum = 1;
    fetchBatch = 0;
    loading = NO;
    noMoreResultsAvail = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - load request from DataLoader
- (void)loadRequest:(NSString *)query
{
    DataLoader *loader = [[DataLoader alloc] init];
    loader.delegate = self;
    [loader loadData:query and:pageNum];
    pageNum++;
}

#pragma mark - custom init
- (void)initNavBar:(int)carouselIndex{
    _navBar = [[SGKNavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) andIndex:carouselIndex];
    [self.view addSubview:_navBar];
}

- (void)initSearchBar {
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navBar.frame), self.view.frame.size.width, 44)];
    _searchBar.tintColor = [UIColor darkGrayColor];
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
}

- (void)initGamesTableView {
    _gamesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchBar.frame), self.view.frame.size.width, self.view.frame.size.height - _navBar.frame.size.height - _searchBar.frame.size.height)];
    _gamesTableView.delegate = self;
    _gamesTableView.dataSource = self;
    [self.view addSubview:_gamesTableView];
}

#pragma mark - other
- (void)didPressButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITable Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (!_gamesArray) {
        return 0;
    }
    // extra cell is the loading cell
    return [self._gamesArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Check if we need to load more data
    if ((indexPath.row >= ([self._gamesArray count] /3 *2)) && !noMoreResultsAvail) {
        if (!loading) {
            loading = YES;
            // loadRequest is the method that loads the next batch of data.
            [self loadRequest:self._searchBar.text];
        }
    }

    if ([self._gamesArray count] != 0) {
        if (indexPath.row < [self._gamesArray count]) {
            NSDictionary *game = [_gamesArray objectAtIndex:indexPath.row];
            UIFont *sampleFont = [UIFont fontWithName:@"Helvetica" size:14.0];
            NSString *text = [game objectForKey:@"name"];
            [cell.textLabel setFont:sampleFont];
            cell.textLabel.text = text;
            return cell;
        } else {
            if (!noMoreResultsAvail) {
                // If there are results available, display @"Loading More..." in the last cell
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:CellIdentifier];
                cell.textLabel.text = @"Loading More...";
                cell.textLabel.font = [UIFont systemFontOfSize:18];
                return cell;
            } else {
                // If there are no results available, display @"Loading More..." in the last cell
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                               reuseIdentifier:CellIdentifier];
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.textLabel.text = @"(No More Results Available)";
                return cell;
            }
        }
    } else {
        [self._gamesTableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *game = [_gamesArray objectAtIndex:indexPath.row];
    NSString *apiDetailURL = [game objectForKey:@"api_detail_url"];
    NSLog(@"%@", apiDetailURL);
    SGKGameViewController *viewController = [[SGKGameViewController alloc] initWithURLDetail:apiDetailURL andIndex:index];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    pageNum = 1;
    noMoreResultsAvail = NO;
    _gamesDictionary = nil;
    _gamesArray = nil;
    _gamesDictionary = [NSMutableDictionary dictionary];
    _gamesArray = [NSMutableArray array];
    [self loadRequest:searchBar.text];
    [_searchBar resignFirstResponder];
}
@end
