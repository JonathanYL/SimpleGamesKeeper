//
//  SGKListViewController.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKListViewController.h"

@interface SGKListViewController ()

@end

@implementation SGKListViewController

@synthesize navBar = _navBar;
@synthesize _gamesTableView;

- (id)initWithIndex:(int)carouselIndex {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self initNavBar:carouselIndex];
        self._gamesList = [NSArray arrayWithObjects:@"Brave new world",@"Call of the Wild",@"Catch-22",@"Atlas Shrugged",@"The Great Gatsby",@"The Art of War",@"The Catcher in the Rye",@"The Picture of Dorian Gray",@"The Grapes of Wrath", @"The Metamorphosis",nil];
        [self initGamesTableView];
        
        // Needs to be changed to delegate function
        [_navBar._backButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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

#pragma mark - UITable Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self._gamesList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [self._gamesList objectAtIndex:indexPath.row];
    return cell;
}
@end
