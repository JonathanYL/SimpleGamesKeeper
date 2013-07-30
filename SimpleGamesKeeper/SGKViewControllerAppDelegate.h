//
//  SGKViewControllerAppDelegate.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-07-27.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SGKViewControllerViewController;

@interface SGKViewControllerAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SGKViewControllerViewController *viewController;
@property (nonatomic, strong) UINavigationController *navigationController;
@end
