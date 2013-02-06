//
//  AEMCardMatchingGame.m
//  Card
//
//  Created by Arthur Mayes on 2/3/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "AEMCardMatchingGame.h"

@interface AEMCardMatchingGame()
@property (strong, nonatomic)NSMutableArray *cards; // of Card
@property (strong, nonatomic)NSMutableArray *currentCardsToMatch;
@end

@implementation AEMCardMatchingGame
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

-(NSMutableArray *)cards{
    if (!_cards) _cards = [NSMutableArray new];
        
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self)
    {
        for (int i = 0; i < count; i++)
        {
            Card *card = [deck drawRandomCard];
            if (card)
            {
                self.cards[i] = card;
            } else
            {
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if (card.isUnplayable) return;
    
    int cardsFaceDown = 0;
    
    card.faceUp = !card.isFaceUp;
    if (card.isFaceUp)
    {
        cardsFaceDown++;
        NSMutableArray *faceUpCards = [[NSMutableArray alloc] init];
        
        for (Card *otherCard in self.cards)
        {
            if (otherCard.isFaceUp && !otherCard.isUnplayable)
            {
                [faceUpCards addObject: otherCard];
            }
        }
        
        if ([faceUpCards count] < self.requiredMatches)
        {
            self.score -= FLIP_COST;
            self.moveDescription = [NSString stringWithFormat:@"You flipped %@", [card nameForCard]];
        }
        else
        {
            int matchscore = [card match:faceUpCards];
            
            if (matchscore == 0)
            {
                NSMutableArray *cardsMatched = [NSMutableArray new];
                for (Card *c in faceUpCards)
                {
                    c.faceUp = NO;
                    [cardsMatched addObject:[c nameForCard]];
                }
                card.faceUp = YES;
                self.score -= MISMATCH_PENALTY;
                NSString *mismatches = [cardsMatched componentsJoinedByString:@" & "];
                self.moveDescription = [NSString stringWithFormat:@"%@ don't match! %d point penalty", mismatches, MISMATCH_PENALTY];
            }
            else
            {
                NSMutableArray *cardsMatched = [NSMutableArray new];
                self.score += matchscore * MATCH_BONUS;
                for (Card *c in faceUpCards)
                {
                    c.unplayable = YES;
                    card.unplayable = YES;
                    [cardsMatched addObject:[c nameForCard]];
                }
                NSString *matches = [cardsMatched componentsJoinedByString:@" & "];
                self.moveDescription = [NSString stringWithFormat:@"Matched %@ for %d points!", matches, matchscore * MATCH_BONUS];
                cardsFaceDown--;
            }
        }
        
        faceUpCards = nil;
    } else
    {
        self.moveDescription = @"";
        int matchScore = 0;
        for (Card *otherCard in self.cards)
        {
            if (!otherCard.isFaceUp && !otherCard.isUnplayable)
            {
                for (Card *otherOtherCard in self.cards)
                {
                    if (!otherOtherCard.isFaceUp && !otherOtherCard.isUnplayable)
                    {
                        if (!(otherCard == otherOtherCard)) // If I'm not testing the card against itself
                        {
                            matchScore += [otherCard match:@[otherOtherCard]];
                        }
                    }
                }
            }
        }
        if (!matchScore)
        {
            for (Card *eachCard in self.cards)
            {
                eachCard.unplayable = YES;
                self.moveDescription = @"No More Matches!";
            }
        }
    }
    for (Card *otherCard in self.cards)
    {
        if (!otherCard.isFaceUp) cardsFaceDown++;
    }
    if (cardsFaceDown <= 1)
    {
        
        self.moveDescription = @"No More Matches!";
        if (!cardsFaceDown)
        {
            self.moveDescription = @"Completion Bonus! 40 points!";
            self.score += 40;
        }
        
    }
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil; // compact if/else statement
}

@end
