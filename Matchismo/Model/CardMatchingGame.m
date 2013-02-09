//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Michael Bopp on 2/7/13.
//  Copyright (c) 2013 Michael Bopp. All rights reserved.
//

#import "CardMatchingGame.h"

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (nonatomic) NSString *message;
@property (nonatomic) enum GameMode gameMode;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count andGameMode:(enum GameMode)gameMode usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    self.gameMode = gameMode;
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}


- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *playedCards = [[NSMutableArray alloc] init];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            
            for (Card *otherCard in self.cards) {
            
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    
                    // create an array of just the cards to match
                    [playedCards addObject:otherCard];
                
                }
            
            }
            
            if (playedCards.count == self.gameMode) {
             
                NSLog(@"Game mode set to %d", self.gameMode);
                
                int matchScore = [card match:playedCards];
                
                if (matchScore) {
                    for (Card *playCard in playedCards) {
                        playCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    
                    self.score += matchScore * MATCH_BONUS;
                    self.message = [NSString stringWithFormat:@"Matched %@ %@ for %d points", card.contents, [playedCards componentsJoinedByString:@" "], matchScore * MATCH_BONUS];
                } else {
                    for (Card *playCard in playedCards) {
                        playCard.unplayable = NO;
                        playCard.faceUp = NO;
                    }
                    card.unplayable = NO;
                    card.faceUp = NO;
                    
                    self.score -= MISMATCH_PENALTY;
                    self.message = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!", card.contents, [playedCards componentsJoinedByString:@" "], MISMATCH_PENALTY];
                }                
                
            }
            
            self.score -= FLIP_COST;
            
        }
        card.faceUp = !card.faceUp;
    }
}



@end
