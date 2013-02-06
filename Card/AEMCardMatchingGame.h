//
//  AEMCardMatchingGame.h
//  Card
//
//  Created by Arthur Mayes on 2/3/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface AEMCardMatchingGame : NSObject
//designated initializer
-(id)initWithCardCount:(NSUInteger)count
             usingDeck:(Deck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) int score;
@property (nonatomic) int requiredMatches;
@property (nonatomic, strong) NSString *moveDescription;
@end
