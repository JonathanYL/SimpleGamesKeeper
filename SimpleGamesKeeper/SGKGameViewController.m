//
//  SGKGameViewController.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-11.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "SGKGameViewController.h"
#import "DataLoader.h"
#import "GameModel.h"

@interface SGKGameViewController () {
    int index;
    NSString *partURL;
    UIImageView *imageView;
    UIImageView *imageReflection;
    UILabel *nameLabel;
    UILabel *developerLabel;
    UILabel *releaseDateLabel;
    UILabel *descriptionHeader;
    UILabel *descriptionLabel;
}
@end

@implementation SGKGameViewController

@synthesize _gameResult;
@synthesize _scrollView;
@synthesize _game;

- (id)initWithURLDetail:(NSString *)urlString andIndex:(int)carouselIndex{
    self = [super init];
    if (self) {
        index = carouselIndex;
        partURL = urlString;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavBar:index];
    [self callAPI];
    // [self performSelectorOnMainThread:@selector(callAPI) withObject:nil waitUntilDone:YES];

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
    _navBar = [[SGKNavView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100) andIndex:carouselIndex];
    [self.view addSubview:_navBar];
}

- (void)initGameModelClassAndPushNavigationController{
    _game = [[GameModel alloc] initWithDictionary:[_gameResult objectForKey:@"results"]];
    NSLog(@"%@", _game.name);
    NSLog(@"%@", _game.deck);
    NSLog(@"%@", _game.genres);
    NSLog(@"%@", _game.developers);
    NSLog(@"%@", _game.publishers);
    NSLog(@"%@", _game.ageRating);
    NSLog(@"%@", _game.platforms);
}

- (void)callAPI {
    _gameResult = [NSMutableDictionary dictionary];
    DataLoader *loader = [[DataLoader alloc] init];
    loader.gameDelegate = self;
    [loader loadGameData:partURL];
    
    // Need some check to when its finished.
}

#pragma mark - custom init

- (void)initMainView {
    [self initPicture :^{
        [self initName];
        [self initDeveloper];
        [self initReleaseDate];
        [self initDescriptionHeader];
        [self initDescriptionLabel];
    }];

}

- (void)initPicture:(void(^)(void))callback {
    // Download the image
    dispatch_queue_t backgroundThread = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(backgroundThread, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:_game.imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView = [[UIImageView alloc] initWithImage:image];
            CGRect frame = imageView.frame;
            frame.origin.x = 10;
            frame.origin.y = CGRectGetMaxY(_navBar.frame)+10;
            imageView.frame = frame;
            [self.view addSubview:imageView];
            callback();
        });
    });
}

// Gonna create a nice reflection. Later
- (void)initReflection {
    
}

- (void)initName {
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, CGRectGetMaxY(_navBar.frame)+6, CGRectGetWidth(self.view.frame) - CGRectGetWidth(imageView.frame) - 20, 400)];
    nameLabel.text = _game.name;
    nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self customizeLabel:nameLabel];
}

- (void)initDeveloper {
    developerLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame)+2, nameLabel.frame.size.width, 0)];
    developerLabel.text = _game.developers;
    developerLabel.font = [UIFont systemFontOfSize:12.0f];
    [self customizeLabel:developerLabel];
}

- (void)initReleaseDate {
    releaseDateLabel = [[UILabel alloc] initWithFrame:CGRectMake((CGRectGetMinX(developerLabel.frame)), CGRectGetMaxY(developerLabel.frame)+2, developerLabel.frame.size.width, 0)];
    releaseDateLabel.text = _game.releaseDate;
    releaseDateLabel.font = [UIFont systemFontOfSize:12.0f];
    [self customizeLabel:releaseDateLabel];
    
}

- (void)initDescriptionHeader {
    descriptionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, MAX(CGRectGetMaxY(imageView.frame), CGRectGetMaxY(releaseDateLabel.frame))+10, self.view.frame.size.width, 25)];
    descriptionHeader.text = @"  Description";
    UIFont *customFont = [UIFont fontWithName:@"Marker Felt" size:20.0f];
    descriptionHeader.textColor = [UIColor whiteColor];
    [descriptionHeader setFont:customFont];
    descriptionHeader.backgroundColor = _navBar.backgroundColor;
    
    // UIView
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, descriptionHeader.frame.origin.y, self.view.frame.size.width, 1)];
    topBar.backgroundColor = [UIColor darkGrayColor];
    
    UIView *botBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(descriptionHeader.frame),self.view.frame.size.width, 1)];
    botBar.backgroundColor = [UIColor darkGrayColor];
    
    [self.view addSubview:descriptionHeader];
    [self.view addSubview:topBar];
    [self.view addSubview:botBar];
}

- (void)initDescriptionLabel {
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(descriptionHeader.frame)+5, self.view.frame.size.width-5, 25)];
    descriptionLabel.text = _game.deck;
    descriptionLabel.font = [UIFont systemFontOfSize:14.0f];
    [self customizeLabel:descriptionLabel];
}

#pragma mark - customization

- (void)customizeLabel:(UILabel *)label {
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width,FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    label.frame = CGRectMake(label.frame.origin.x,label.frame.origin.y,label.frame.size.width,size.height);
    [self.view addSubview:label];
}

#pragma mark - press events
- (void)didPressButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
