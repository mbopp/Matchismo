//
//  PlayingCard.h
//  Matchismo
//
//  Created by Michael Bopp on 2/2/13.
//  Copyright (c) 2013 Michael Bopp. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
