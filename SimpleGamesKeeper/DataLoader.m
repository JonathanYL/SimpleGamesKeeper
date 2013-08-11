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

#define firstPartQueryString @"http://www.giantbomb.com/api/search/?api_key=509b211e07931409e7dc0a4297f1aa4b82c34802&format=json&query="
#define lastPartQueryString @"&resources=game&limit=25&field_list=name,api_detail_url,platforms,id,image&page="


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
//            if ([[delegate._gamesDictionary objectForKey:@"results"] count] == 0) {
//                delegate._gamesArray = nil;
//            // new dictionary, so we just add it.
//            } else {
                [delegate._gamesArray addObjectsFromArray:[delegate._gamesDictionary objectForKey:@"results"]];
//            }
            
            int dictionaryCount = [[delegate._gamesDictionary objectForKey:@"number_of_total_results"] intValue];
            NSLog(@"gamesarray: %d", [delegate._gamesArray count]);
            NSLog(@"gamesDict: %d", dictionaryCount);
            if ([delegate._gamesArray count] == dictionaryCount) {
                delegate.noMoreResultsAvail = YES;
            }
            [delegate._gamesTableView reloadData];
            delegate.loading = NO;
        });
        
    });
}


@end
