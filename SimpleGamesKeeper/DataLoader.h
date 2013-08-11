//
//  DataLoader.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-07.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGKListViewController.h"

@interface DataLoader : NSObject

@property (strong, nonatomic) SGKListViewController *delegate;
- (void)loadData:(NSString*)queryString and:(int)pageNum;

@end
