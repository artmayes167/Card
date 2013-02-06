//
//  PlayingCard.m
//  Card
//
//  Created by Arthur Mayes on 1/26/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// @synthesize need not be written unless you implement the setter and the getter

-(int)match:(NSArray *)otherCards
{
    
    
    int score = 0;
    
    if (otherCards.count == 1)
    {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) { // check to make sure is a PlayingCard
            PlayingCard *otherPlayingCard = (PlayingCard *) otherCard; // cast to a PlayingCard
            
            if ([otherPlayingCard.suit isEqualToString:self.suit]) score = 1;
            else if (otherPlayingCard.rank == self.rank) score = 4;
        }
        
        
    }
    else
    {
        for (Card *scoreCard in otherCards)
        {
            int cardScore = [self match:@[scoreCard]];
            if (!cardScore) return 0;
            else score += cardScore;
        }
    }
    
    return score;
    
}

-(NSString *)nameForCard
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [NSString stringWithFormat:@"%@ of %@", rankStrings[self.rank], self.suit];
}

-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [NSString stringWithFormat:@"%@-%@", self.suit, rankStrings[self.rank]];
}

@synthesize suit = _suit;

+(NSArray *)validSuits // sent to Class, not instance
{
    return @[@"spades", @"hearts", @"diamonds", @"clubs"];
}

-(void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) _suit = suit;
}

-(NSString *)suit
{
    return _suit ? _suit : @"?"; // if/else
}

+(NSArray *)rankStrings
{
    return @[@"?", @"a", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"10", @"j", @"q", @"k"]; //New in iOS6
}

+(NSUInteger)maxRank { return [self rankStrings].count-1;}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) _rank = rank;
}
-(NSString *)imageName
{
    return [self.contents stringByAppendingString:@"-75.png"];
}

@end
