//
//  PlayingCard.h
//  Card
//
//  Created by Arthur Mayes on 1/26/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;


+(NSArray *)validSuits;
+(NSArray *)rankStrings;
+(NSUInteger)maxRank;

@end
