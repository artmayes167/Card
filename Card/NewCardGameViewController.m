//
//  NewCardGameViewController.m
//  Card
//
//  Created by Arthur Mayes on 2/14/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "NewCardGameViewController.h"
#import "AEMCardMatchingGame.h"
#import "AEMGameResult.h"

@interface NewCardGameViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) int priorScore;
@property (strong, nonatomic) AEMCardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) AEMGameResult *gameResult;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
- (IBAction)deal:(UIButton *)sender;


@end

@implementation NewCardGameViewController

#pragma mark - UICollectionViewDataSource
//@optional
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


//@required
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount; // Controller interpreting the Model for the View
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.cardCollectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    // indexPath contains .item and .section
    [self updateCell:cell usingCard:card animate:YES];
    return cell;
}

-(void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card animate:(BOOL)animate
{
    //abstract
}

-(AEMGameResult *)gameResult{
    if (!_gameResult) {
        _gameResult = [[AEMGameResult alloc] init];
    }
    return _gameResult;
}

-(Deck *)createDeck { return nil;} // abstract (won't work if not called)

-(AEMCardMatchingGame *)game
{
    if (!_game) {
        _game = [[AEMCardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                     usingDeck:[self createDeck]];
    }
    if (self.priorScore) _game.score = self.priorScore;
    
    _game.requiredMatches = self.matchesNeeded; //Maintains selection between deals
    self.priorScore = nil;
    return _game;
}

-(void)updateUI
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell usingCard:card animate:YES];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)matchesChanged:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        self.game.requiredMatches = 2;
        self.matchesNeeded = 2;
    } else
    {
        self.game.requiredMatches = 3;
        self.matchesNeeded = 3;
    }
}

- (IBAction)deal:(UIButton *)sender {
    self.priorScore = self.game.score;
    self.game = nil;
    [self updateUI];
}

-(IBAction)flipCard:(UITapGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath) {
        [self.game flipCardAtIndex:indexPath.item];
        Card *card = [self.game cardAtIndex:indexPath.item];
        if (card.isFaceUp) self.flipCount++;
        [self updateUI];
        self.gameResult.score = self.game.score;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    self.game.requiredMatches = 2;
    self.matchesNeeded = 2;
    [super viewDidAppear:YES];
}


@end
