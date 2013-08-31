//
//  Game.h
//  SimpleGamesKeeper
//
//  Created by Jonathan Yeung on 2013-08-26.
//  Copyright (c) 2013 Jonathan Yeung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * deck;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * genres;
@property (nonatomic, retain) NSString * ageRating;
@property (nonatomic, retain) NSString * releaseDate;
@property (nonatomic, retain) NSString * platforms;
@property (nonatomic, retain) NSString * developers;
@property (nonatomic, retain) NSString * publishers;
@end
