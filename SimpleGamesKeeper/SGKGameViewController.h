//
//  SGKGameViewController.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-11.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGKNavView.h"

@interface SGKGameViewController : UIViewController

@property (nonatomic, strong) SGKNavView *navBar;


- (id)initWithURLDetail:(NSString *)urlString;

@end
