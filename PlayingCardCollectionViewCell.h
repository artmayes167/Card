//
//  PlayingCardCollectionViewCell.h
//  Card
//
//  Created by Arthur Mayes on 2/14/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardView.h"

@interface PlayingCardCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end
