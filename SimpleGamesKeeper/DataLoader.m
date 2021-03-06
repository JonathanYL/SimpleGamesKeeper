//
//  DataLoader.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-07.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "DataLoader.h"


@implementation DataLoader

@synthesize delegate;
@synthesize gameDelegate;

// Game List Delegate
#define firstPartQueryString @"http://www.giantbomb.com/api/search/?api_key=509b211e07931409e7dc0a4297f1aa4b82c34802&format=json&query="
#define lastPartQueryString @"&resources=game&limit=25&field_list=name,api_detail_url,platforms,id,image&page="

// Game View Delegate
#define endArgument @"?api_key=509b211e07931409e7dc0a4297f1aa4b82c34802&format=json&field_list=api_detail_url,deck,developers,genres,id,image,name,original_game_rating,original_release_date,platforms,publishers"

// TODO: Need to take into account when we have no internet.
- (void)loadData:(NSString *)queryString and:(int)pageNum
{
    NSString *query = [queryString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSString *completeString = [NSString stringWithFormat:@"%@%@%@%d", firstPartQueryString, query, lastPartQueryString, pageNum];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:completeString]];
        NSError *error;
        
        delegate._gamesDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions
                                                       error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            // no results generated
            int dictionaryCount = [[delegate._gamesDictionary objectForKey:@"number_of_total_results"] intValue];
            
            if (dictionaryCount != 0) {
                [delegate._gamesArray addObjectsFromArray:[delegate._gamesDictionary objectForKey:@"results"]];
                NSLog(@"gamesarray: %d", [delegate._gamesArray count]);
                NSLog(@"gamesDict: %d", dictionaryCount);
                if ([delegate._gamesArray count] == dictionaryCount) {
                    delegate.noMoreResultsAvail = YES;
                }
            } else {
                [delegate._gamesArray removeAllObjects];
                UIAlertView *noResults = [[UIAlertView alloc] initWithTitle:@"No Search Results"
                                                                    message:@"Sorry! Your query did not yield any results."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Try again!"
                                                          otherButtonTitles: nil];
                [noResults show];
                delegate._gamesArray = nil;
            }
            [delegate._gamesTableView reloadData];
            delegate.loading = NO;
            [delegate._activityIndicator removeFromSuperview];
            [delegate._overlayView removeFromSuperview];
        });
        
    });
}

- (void)loadGameData:(NSString *)queryString {
    NSString *completeString = [NSString stringWithFormat:@"%@%@", queryString, endArgument];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:completeString]];
        NSError *error;
        
        gameDelegate._gameResult = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:kNilOptions
                                                                     error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            [gameDelegate initGameModelClassAndPushNavigationController];
            [gameDelegate initMainView];
            [gameDelegate._activityIndicator removeFromSuperview];
            [gameDelegate._overlayView removeFromSuperview];
            gameDelegate._overlayView = nil;
            gameDelegate._activityIndicator = nil;
        });
    });
}


@end
