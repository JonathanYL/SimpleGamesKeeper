//
//  SGKListViewController.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKListViewController.h"

@interface SGKListViewController () {
    int index;
}
@end

@implementation SGKListViewController

@synthesize navBar = _navBar;
@synthesize _gamesTableView;
@synthesize _gamesList;

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
    [self fetchGamesList];
    [self initNavBar:index];
    [self initGamesTableView];
    
    // Needs to be changed to delegate function
    [_navBar._backButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom init
- (void)initNavBar:(int)carouselIndex{
    _navBar = [[SGKNavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    switch (carouselIndex) {
        case 0:
            _navBar.backgroundColor = [UIColor purpleColor];
            _navBar._systemName.text = @"PC Games List";
            break;
        case 1:
            _navBar.backgroundColor = [UIColor blueColor];
            _navBar._systemName.text = @"Sony Games List";
            break;
        case 2:
            _navBar.backgroundColor = [UIColor greenColor];
            _navBar._systemName.text = @"Microsoft Games List";
            break;
        case 3:
            _navBar.backgroundColor = [UIColor redColor];
            _navBar._systemName.text = @"Sony Games List";
            break;
        case 4:
            _navBar.backgroundColor = [UIColor orangeColor];
            _navBar._systemName.text = @"Misc Games List";
            break;
        default:
            _navBar.backgroundColor = [UIColor grayColor];
            break;
    }
    [self.view addSubview:_navBar];
}

- (void)initGamesTableView {
    _gamesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navBar.frame), self.view.frame.size.width, self.view.frame.size.height - _navBar.frame.size.height)];
    _gamesTableView.delegate = self;
    _gamesTableView.dataSource = self;
    [self.view addSubview:_gamesTableView];
}

#pragma mark - other
- (void)didPressButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fetchGamesList {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.giantbomb.com/api/games/3045-35/?api_key=509b211e07931409e7dc0a4297f1aa4b82c34802&format=json&field_list=name"]];
        NSError *error;
        _gamesList = [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions
                                                       error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self._gamesTableView reloadData];
        });
        
    });
}

#pragma mark - UITable Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self._gamesList objectForKey:@"results"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *games = [[_gamesList objectForKey:@"results"] objectAtIndex:indexPath.row];
    UIFont *sampleFont = [UIFont fontWithName:@"Helvetica" size:14.0];
    NSString *text = [games objectForKey:@"name"];
    [cell.textLabel setFont:sampleFont];
    cell.textLabel.text = text;
    return cell;
}
@end
