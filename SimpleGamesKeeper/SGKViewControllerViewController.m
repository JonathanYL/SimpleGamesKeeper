//
//  SGKViewControllerViewController.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SGKViewControllerViewController.h"
#import "iCarousel.h"
#import "SGKTileReflectionView.h"
#import "SGKViewControllerAppDelegate.h"
#import "SGKGameCollectionViewController.h"

@interface SGKViewControllerViewController () <iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, retain) iCarousel *carousel;
@property (nonatomic, retain) UINavigationItem *navItem;
@property (nonatomic, assign) BOOL wrap;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, strong) UILabel *label;

@end

@implementation SGKViewControllerViewController

@synthesize carousel;
@synthesize navItem;
@synthesize wrap;
@synthesize items;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self initDisplayTiles];
    }
    return self;
}

- (void)initDisplayTiles
{
    self.items = [NSMutableArray array];
    
    // Add the titles. Will change to pictures.
    UIImage *pcImage = [UIImage imageNamed:@"logoPC.png"];
    UIImage *playstationImage = [UIImage imageNamed:@"logoPS.png"];
    UIImage *xboxImage = [UIImage imageNamed:@"logoXBOX.png"];
    UIImage *nintendoImage = [UIImage imageNamed:@"logoNintendo.png"];
    UIImage *miscImage = [UIImage imageNamed:@"logoEvery.png"];
    UIImage *collectionImage = [UIImage imageNamed:@"logoCollection.png"];
    
    [items addObject:pcImage];
    [items addObject:playstationImage];
    [items addObject:xboxImage];
    [items addObject:nintendoImage];
    [items addObject:miscImage];
    [items addObject:collectionImage];
}

- (void)dealloc
{
	//it's a good idea to set these to nil here to avoid
	//sending messages to a deallocated viewcontroller
	carousel.delegate = nil;
	carousel.dataSource = nil;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    wrap = YES;
    
    // add background
    UIImageView *backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.image = [UIImage imageNamed:@"newBackground.png"];
    [self.view addSubview:backgroundView];
    
    [self initTitle];
    //create carousel
	carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
	carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    carousel.type = iCarouselTypeRotary;
	carousel.delegate = self;
	carousel.dataSource = self;
    
    
    label = [[UILabel alloc] initWithFrame:(CGRectMake(0, 400, self.view.frame.size.width, 25))];
    label.backgroundColor = [UIColor clearColor];
    // [self.label setCenter:self.view.center];
	//add carousel to view
    label.font = [UIFont fontWithName:@"Roboto-Light" size:22.0f];
    label.text = @"Personal Computer";
    
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:carousel];
    [self.view addSubview:label];
    //[self printCoreData];
}

// FOR TESTING
- (void)printCoreData {
    SGKViewControllerAppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = app.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Game" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Core Data Name: %@", [info valueForKey:@"name"]);
    }
}

- (void)initTitle {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, 35)];
    title.font = [UIFont fontWithName:@"RobotoCondensed-Light" size:32.0f];
    title.text = @"Simple Games Keeper";
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor darkGrayColor];
    [self.view addSubview:title];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
    self.navItem = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate functions
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    UIImage *consolePic = [items objectAtIndex:index];
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
//        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        
        view = [[SGKTileReflectionView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
    
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    // ((UIImageView *)view).image = consolePic;
    [((SGKTileReflectionView *)view) initImage:consolePic];
    return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel {
    int currentIndex = carousel.currentItemIndex;
    if (currentIndex == 0) {
        self.label.text = @"Personal Computer";
    } else if (currentIndex == 1) {
        self.label.text = @"Sony";
    } else if (currentIndex == 2) {
        self.label.text = @"Microsoft";
    } else if (currentIndex == 3) {
        self.label.text = @"Nintendo";
    } else if (currentIndex == 4) {
        self.label.text = @"All";
    } else if (currentIndex == 5) {
        self.label.text = @"My Collection";
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"Clicked:%d", index);
    
    if (index == 5) {
        SGKGameCollectionViewController *viewController = [[SGKGameCollectionViewController alloc] initWithIndex:index];
        [self.navigationController pushViewController:viewController animated:YES];
    } else {    
        SGKListViewController *viewController = [[SGKListViewController alloc] initWithIndex:index];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        default:
        {
            return value;
        }
    }
}


@end
