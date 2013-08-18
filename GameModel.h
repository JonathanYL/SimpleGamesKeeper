//
//  GameModel.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-11.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameModel : NSObject

@property (nonatomic) int id;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString* deck;
@property (nonatomic, strong) NSURL* imageURL;
@property (nonatomic, strong) NSString* genres;
@property (nonatomic, strong) NSString* developers;
@property (nonatomic, strong) NSString* publishers;
@property (nonatomic, strong) NSString* ageRating;
@property (nonatomic, strong) NSString* releaseDate;
@property (nonatomic, strong) NSString* platforms;

- (id)initWithDictionary:(NSDictionary *)results;
@end
