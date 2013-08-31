//
//  SGKGameCollectionViewController.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-28.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKGameCollectionViewController.h"
#import "SGKViewControllerAppDelegate.h"
#import "SGKOwnedGameViewController.h"
#import "Game.h"

@interface SGKGameCollectionViewController () {
    int index;
    BOOL firstTimeViewed;
    NSArray *fetchedGames;
}
@end

@implementation SGKGameCollectionViewController

@synthesize _gamesCollectionTableView;

- (id)initWithIndex:(int)carouselIndex {
    self = [super init];
    if (self) {
        index = carouselIndex;
        self.view.backgroundColor = [UIColor whiteColor];
        firstTimeViewed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initCoreDatabase];
    [self initNavBar:index];
    [self initGamesTableView];
    [_navBar._backButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:_navBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"TADA!");
    animated = NO;
    if (firstTimeViewed == NO) {
        NSLog(@"Reloading Table");
        [self initCoreDatabase];
        [_gamesCollectionTableView reloadData];
    }
    firstTimeViewed = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom init
- (void)initNavBar:(int)carouselIndex{
    _navBar = [[SGKNavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) andIndex:carouselIndex];
    [self.view addSubview:_navBar];
}

- (void)initGamesTableView {
    _gamesCollectionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navBar.frame), self.view.frame.size.width, self.view.frame.size.height - _navBar.frame.size.height)];
    _gamesCollectionTableView.delegate = self;
    _gamesCollectionTableView.dataSource = self;
    [self.view addSubview:_gamesCollectionTableView];
}

- (void)initCoreDatabase {
    SGKViewControllerAppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = app.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Game" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    fetchedGames = [context executeFetchRequest:fetchRequest error:&error];
}

#pragma mark - UITable Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [fetchedGames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Game *retrievedGame = [fetchedGames objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIFont *sampleFont = [UIFont fontWithName:@"Roboto-Regular" size:15.0f];
    [cell.textLabel setFont:sampleFont];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = retrievedGame.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Game *game = [fetchedGames objectAtIndex:indexPath.row];
    SGKOwnedGameViewController *viewController = [[SGKOwnedGameViewController alloc] initWithGame:game with:index];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - press events
- (void)didPressButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
