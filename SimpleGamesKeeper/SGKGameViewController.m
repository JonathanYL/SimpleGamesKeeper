//
//  SGKGameViewController.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-11.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
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
    UILabel *gameDetailHeader;
    UILabel *addInfoPublisher;
    UILabel *addInfoDeveloper;
    UILabel *addInfoRating;
    UILabel *addInfoReleaseDate;
    UILabel *addInfoGenres;
    UILabel *addInfoPlatforms;
    UIButton *addButton;
    UILabel *buttonLabel;
}
@end

@implementation SGKGameViewController

#define screenWidth self.view.frame.size.width
#define screenHeight self.view.frame.size.height

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
    [self.view bringSubviewToFront:_navBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom init
- (void)initNavBar:(int)carouselIndex{
    _navBar = [[SGKNavView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 40) andIndex:carouselIndex];
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
    [self initScrollView];
    [self initPicture :^{
        [self initName];
        [self initDeveloper];
        [self initReleaseDate];
        [self initAddButton];
        [self initDescriptionHeader];
        [self initDescriptionLabel];
        [self initGameDetailsHeader];
        [self initAddInfoPublisher];
        [self initAddInfoDeveloper];
        [self initAddInfoAgeRating];
        [self initAddInfoReleaseDate];
        [self initAddInfoGenres];
        [self initAddInfoPlatforms];
        CGFloat size = CGRectGetHeight(imageView.frame) + CGRectGetHeight(addButton.frame) + CGRectGetHeight(descriptionHeader.frame) + CGRectGetHeight(descriptionLabel.frame) + CGRectGetHeight(gameDetailHeader.frame) + CGRectGetHeight(addInfoPublisher.frame) + CGRectGetHeight(addInfoDeveloper.frame) + CGRectGetHeight(addInfoRating.frame) + CGRectGetHeight(addInfoReleaseDate.frame) + CGRectGetHeight(addInfoGenres.frame) + CGRectGetHeight(addInfoPlatforms.frame) + 85.0f;
        _scrollView.contentSize = CGSizeMake(screenWidth, size);
    }];
    
    
}

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navBar.frame)+1, screenWidth, screenHeight - _navBar.frame.size.height)];
    [_scrollView setScrollEnabled:YES];
    [self.view addSubview:_scrollView];
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
            frame.origin.y = 10;
            imageView.frame = frame;
            [_scrollView addSubview:imageView];
            callback();
        });
    });
}

// Gonna create a nice reflection. Later
- (void)initAddButton {
    addButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(imageView.frame), MAX(CGRectGetMaxY(imageView.frame), CGRectGetMaxY(releaseDateLabel.frame))+10, 30, 30)];
    addButton.backgroundColor = [UIColor colorWithRed:141.0f/255.0f green:194.0f/255.0f blue:94.0f/255.0f alpha:1.0f];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    addButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    addButton.layer.cornerRadius = 10;
    
    buttonLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addButton.frame)+10, CGRectGetMinY(addButton.frame), screenWidth-CGRectGetWidth(addButton.frame)-20, CGRectGetHeight(addButton.frame))];
    buttonLabel.font = [UIFont systemFontOfSize:15.0f];
    buttonLabel.textColor = [UIColor blackColor];
    buttonLabel.text = @"Add Game to Collection";
    
    [_scrollView addSubview:addButton];
    [_scrollView addSubview:buttonLabel];
    
}

- (void)initName {
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+5, 6, CGRectGetWidth(self.view.frame) - CGRectGetWidth(imageView.frame) - 20, 400)];
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
    descriptionHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(addButton.frame)+10, screenWidth, 25)];
    descriptionHeader.text = @"  Description";
    UIFont *customFont = [UIFont fontWithName:@"Marker Felt" size:20.0f];
    descriptionHeader.textColor = [UIColor whiteColor];
    [descriptionHeader setFont:customFont];
    descriptionHeader.backgroundColor = _navBar.backgroundColor;
    
    // UIView
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, descriptionHeader.frame.origin.y, screenWidth, 1)];
    topBar.backgroundColor = [UIColor darkGrayColor];
    
    UIView *botBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(descriptionHeader.frame),screenWidth, 1)];
    botBar.backgroundColor = [UIColor darkGrayColor];
    
    [_scrollView addSubview:descriptionHeader];
    [_scrollView addSubview:topBar];
    [_scrollView addSubview:botBar];

}

- (void)initDescriptionLabel {
    descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(descriptionHeader.frame)+5, screenWidth-5, 25)];
    descriptionLabel.text = _game.deck;
    descriptionLabel.font = [UIFont systemFontOfSize:14.0f];
    [self customizeLabel:descriptionLabel];
}

- (void)initGameDetailsHeader {
    gameDetailHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(descriptionLabel.frame)+10, screenWidth, 25)];
    gameDetailHeader.text = @"  Additional Information";
    UIFont *customFont = [UIFont fontWithName:@"Marker Felt" size:20.0f];
    gameDetailHeader.textColor = [UIColor whiteColor];
    [gameDetailHeader setFont:customFont];
    gameDetailHeader.backgroundColor = _navBar.backgroundColor;
    
    // UIView
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, gameDetailHeader.frame.origin.y, screenWidth, 1)];
    topBar.backgroundColor = [UIColor darkGrayColor];
    
    UIView *botBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(gameDetailHeader.frame),screenWidth, 1)];
    botBar.backgroundColor = [UIColor darkGrayColor];
    
    [_scrollView addSubview:gameDetailHeader];
    [_scrollView addSubview:topBar];
    [_scrollView addSubview:botBar];
}

#pragma mark - Additional Information

- (void)initAddInfoPublisher {
    // Publisher Title
    UILabel *publisherTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(gameDetailHeader.frame)+5, 100, 20)];
    publisherTitle.text = @"Publisher:";
    publisherTitle.font = [UIFont boldSystemFontOfSize:14.0f];
    // publisherTitle.backgroundColor = [UIColor blueColor];
    [_scrollView addSubview:publisherTitle];
    
    
    // Publisher info
    addInfoPublisher = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(publisherTitle.frame)+5, CGRectGetMaxY(gameDetailHeader.frame)+5, screenWidth-CGRectGetWidth(publisherTitle.frame)-10, 20)];
    addInfoPublisher.text = _game.publishers;
    addInfoPublisher.font = [UIFont systemFontOfSize:15.0f];
    //addInfoPublisher.backgroundColor = [UIColor redColor];
    [self customizeLabel:addInfoPublisher];
    
}

- (void)initAddInfoDeveloper {
    UILabel *developerTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(addInfoPublisher.frame)+5, 100, 20)];
    developerTitle.text = @"Developer:";
    developerTitle.font = [UIFont boldSystemFontOfSize:14.0f];
    [_scrollView addSubview:developerTitle];
    
    addInfoDeveloper = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(developerTitle.frame)+5, CGRectGetMaxY(addInfoPublisher.frame)+5, screenWidth-CGRectGetWidth(developerTitle.frame)-10, 20)];
    addInfoDeveloper.text = _game.developers;
    addInfoDeveloper.font = [UIFont systemFontOfSize:15.0f];
    [self customizeLabel:addInfoDeveloper];    
}

- (void)initAddInfoAgeRating {
    UILabel *ageRatingTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(addInfoDeveloper.frame)+5, 100, 20)];
    ageRatingTitle.text = @"Age Rating:";
    ageRatingTitle.font = [UIFont boldSystemFontOfSize:14.0f];
    [_scrollView addSubview:ageRatingTitle];
    
    addInfoRating = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ageRatingTitle.frame)+5, CGRectGetMaxY(addInfoDeveloper.frame)+5, screenWidth-CGRectGetWidth(ageRatingTitle.frame)-10, 20)];
    addInfoRating.text = _game.ageRating;
    addInfoRating.font = [UIFont systemFontOfSize:15.0f];
    [self customizeLabel:addInfoRating];
}

- (void)initAddInfoReleaseDate {
    UILabel *releaseDateTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(addInfoRating.frame)+5, 100, 20)];
    releaseDateTitle.text = @"Release Date:";
    releaseDateTitle.font = [UIFont boldSystemFontOfSize:14.0f];
    [_scrollView addSubview:releaseDateTitle];
    
    addInfoReleaseDate = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(releaseDateTitle.frame)+5, CGRectGetMaxY(addInfoRating.frame)+5, screenWidth-CGRectGetWidth(releaseDateTitle.frame)-10, 20)];
    addInfoReleaseDate.text = _game.releaseDate;
    addInfoReleaseDate.font = [UIFont systemFontOfSize:15.0f];
    [self customizeLabel:addInfoReleaseDate];
}

- (void)initAddInfoGenres {
    UILabel *genreTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(addInfoReleaseDate.frame)+5, 100, 20)];
    genreTitle.text = @"Genres:";
    genreTitle.font = [UIFont boldSystemFontOfSize:14.0f];
    [_scrollView addSubview:genreTitle];
    
    addInfoGenres = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(genreTitle.frame)+5, CGRectGetMaxY(addInfoReleaseDate.frame)+5, screenWidth-CGRectGetWidth(genreTitle.frame)-10, 20)];
    addInfoGenres.text = _game.genres;
    addInfoGenres.font = [UIFont systemFontOfSize:15.0f];
    [self customizeLabel:addInfoGenres];
}

- (void)initAddInfoPlatforms {
    UILabel *platformTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(addInfoGenres.frame)+5, 100, 20)];
    platformTitle.text = @"Platforms:";
    platformTitle.font = [UIFont boldSystemFontOfSize:14.0f];
    [_scrollView addSubview:platformTitle];
    
    addInfoPlatforms = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(platformTitle.frame)+5, CGRectGetMaxY(addInfoGenres.frame)+5, screenWidth-CGRectGetWidth(platformTitle.frame)-10,20)];
    addInfoPlatforms.text = _game.platforms;
    addInfoPlatforms.font = [UIFont systemFontOfSize:15.0f];
    [self customizeLabel:addInfoPlatforms];
}

#pragma mark - customization

- (void)customizeLabel:(UILabel *)label {
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:CGSizeMake(label.frame.size.width,FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    label.frame = CGRectMake(label.frame.origin.x,label.frame.origin.y,label.frame.size.width,size.height);
    [_scrollView addSubview:label];
}

#pragma mark - press events
- (void)didPressButton:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
