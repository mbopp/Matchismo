//
//  Card.m
//  Matchismo
//
//  Created by Michael Bopp on 2/2/13.
//  Copyright (c) 2013 Michael Bopp. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
