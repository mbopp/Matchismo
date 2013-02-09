//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Michael Bopp on 2/7/13.
//  Copyright (c) 2013 Michael Bopp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

enum GameMode {
    twoCardMatch = 1,
    threeCardMatch = 2
};

- (id)initWithCardCount:(NSUInteger)cardCount
            andGameMode:(enum GameMode)gameMode
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *message;

@end
