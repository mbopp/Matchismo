//
//  PlayingCard.m
//  Matchismo
//
//  Created by Michael Bopp on 2/2/13.
//  Copyright (c) 2013 Michael Bopp. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if (otherCards.count == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    } else if (otherCards.count == 2) {
        PlayingCard *otherCard1 = [otherCards objectAtIndex:0];
        PlayingCard *otherCard2 = [otherCards objectAtIndex:1];
        if ([otherCard1.suit isEqualToString:self.suit] && [otherCard2.suit isEqualToString:self.suit]) {
            score = 3;
        } else if (otherCard1.rank == self.rank && otherCard2.rank == self.rank) {
            score = 16;
        }
    }
    
    return score;
}

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString: self.suit];
}

- (NSString *)description
{
    return self.contents;
}

@synthesize suit = _suit;

+ (NSArray *)validSuits
{
    static NSArray *validSuits = nil;
    if (!validSuits) validSuits = @[@"♥",@"♦",@"♠",@"♣"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings
{
    static NSArray *rankStrings = nil;
    if (!rankStrings) rankStrings = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return rankStrings;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

@end
