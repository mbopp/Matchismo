//
//  Deck.h
//  Matchismo
//
//  Created by Michael Bopp on 2/2/13.
//  Copyright (c) 2013 Michael Bopp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
