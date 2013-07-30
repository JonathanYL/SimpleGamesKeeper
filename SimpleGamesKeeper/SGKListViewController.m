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

- (id)initWithIndex:(int)carouselIndex {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        [self initNavBar:carouselIndex];
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

#pragma mark - other
- (void)didPressButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
