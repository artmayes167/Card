//
//  NewCardGameViewController.h
//  Card
//
//  Created by Arthur Mayes on 2/14/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface NewCardGameViewController : UIViewController

@property (nonatomic) NSUInteger startingCardCount; // abstract
@property (nonatomic)int matchesNeeded;
-(Deck *)createDeck; // abstract
-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate; //abstract

@end
