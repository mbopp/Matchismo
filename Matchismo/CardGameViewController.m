//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Michael Bopp on 2/1/13.
//  Copyright (c) 2013 Michael Bopp. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointDescriptionLabel;
@end

@implementation CardGameViewController


- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        andGameMode:[self gameMode]
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (enum GameMode)gameMode
{
    // Only going to have two card match at this point, remove option for three
    return twoCardMatch;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    BOOL playStarted = NO;
    UIImage *cardBackImage = [UIImage imageNamed:@"rdg-logo_square.png"];
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        if (card.isFaceUp) {
            playStarted = YES;
            [cardButton setImage:nil forState:UIControlStateNormal];
        } else {
            [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.pointDescriptionLabel.text = self.game.message;
    
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)clickDeal:(UIButton *)sender {
    self.game = nil;
    self.scoreLabel.text = @"Score: 0";
    self.flipCount = 0;
    
    [self updateUI];
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender {
    self.game = nil;
    [self updateUI];
}

@end
