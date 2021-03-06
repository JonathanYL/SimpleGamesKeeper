//
//  GameModel.m
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-11.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

- (id)initWithDictionary:(NSDictionary *)results {
    self = [super init];
    if (self) {
        self.id = [[results objectForKey:@"id"] intValue];
        self.name = [results objectForKey:@"name"];
        
        self.deck = @"";
        if ([results objectForKey:@"deck"] != [NSNull null]) {
            self.deck = [results objectForKey:@"deck"];
        }
        
        if ([results objectForKey:@"image"] != [NSNull null]) {
            self.imageURL = [NSURL URLWithString:[[results objectForKey:@"image"] objectForKey:@"thumb_url"]];
        }
        
        self.genres = @"";
        if ([results objectForKey:@"genres"] != [NSNull null]) {
            for (int i = 0; i < [[results objectForKey:@"genres"] count]; i++) {
                if (i == 0) {
                    self.genres = [[[results objectForKey:@"genres"] objectAtIndex:i] objectForKey:@"name"];
                } else {
                    self.genres = [NSString stringWithFormat:@"%@, %@", self.genres, [[[results objectForKey:@"genres"] objectAtIndex:i] objectForKey:@"name"]];
                }
            }
        }
        
        self.developers = @"";
        if ([results objectForKey:@"developers"] != [NSNull null]) {
            for (int i = 0; i < [[results objectForKey:@"developers"] count]; i++) {
                if (i == 0) {
                    self.developers = [[[results objectForKey:@"developers"] objectAtIndex:i] objectForKey:@"name"];
                } else {
                    self.developers = [NSString stringWithFormat:@"%@, %@", self.developers, [[[results objectForKey:@"developers"] objectAtIndex:i] objectForKey:@"name"]];
                }
            }
        }
        
        self.publishers = @"";
        if ([results objectForKey:@"publishers"] != [NSNull null]) {
            for (int i = 0; i < [[results objectForKey:@"publishers"] count]; i++) {
                if (i == 0) {
                    self.publishers = [[[results objectForKey:@"publishers"] objectAtIndex:i] objectForKey:@"name"];
                } else {
                    self.publishers = [NSString stringWithFormat:@"%@, %@", self.publishers, [[[results objectForKey:@"publishers"] objectAtIndex:i] objectForKey:@"name"]];
                }
            }
        }
        self.ageRating = @"";
        if ([results objectForKey:@"original_game_rating"] != [NSNull null]) {
            self.ageRating = [[[results objectForKey:@"original_game_rating"] objectAtIndex:0] objectForKey:@"name"];
        }
        
        // need to check if doesn't exist.
        self.releaseDate = @"";
        
        if ([results objectForKey:@"original_release_date"] != [NSNull null]) {
            NSString *dateString = [results objectForKey:@"original_release_date"];
            if (dateString) {
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                
                [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
                
                NSDate *date = [dateFormatter dateFromString:dateString];
                [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
                [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
                self.releaseDate = [dateFormatter stringFromDate:date];
            }
        }
        
        self.platforms = @"";
        if ([results objectForKey:@"platforms"] != [NSNull null]) {
            for (int i = 0; i < [[results objectForKey:@"platforms"] count]; i++) {
                if (i == 0) {
                    self.platforms = [[[results objectForKey:@"platforms"] objectAtIndex:i] objectForKey:@"name"];
                } else {
                    self.platforms = [NSString stringWithFormat:@"%@, %@", self.platforms, [[[results objectForKey:@"platforms"] objectAtIndex:i] objectForKey:@"name"]];
                }
            }
        }
        
    }
    return self;
}

@end
