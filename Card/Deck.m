//
//  Deck.m
//  Card
//
//  Created by Arthur Mayes on 1/26/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

-(NSMutableArray *) cards
{
    if (!_cards) _cards = [NSMutableArray new];
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (card)
    {
        if (atTop) [self.cards insertObject:card atIndex:0];
        else [self.cards addObject:card];
    }

}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if (self.cards.count)
    {
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index]; // new in iOS6
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
