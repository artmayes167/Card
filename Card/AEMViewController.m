//
//  AEMViewController.m
//  Card
//
//  Created by Arthur Mayes on 1/26/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "AEMViewController.h"
#import "PlayingCardDeck.h"
#import "AEMCardMatchingGame.h"
#import "AEMGameResult.h"

@interface AEMViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) int priorScore;
@property (strong, nonatomic) AEMCardMatchingGame *game;
@property (strong, nonatomic) AEMGameResult *gameResult;
@end

@implementation AEMViewController

-(AEMGameResult *)gameResult
{
    if (!_gameResult) _gameResult = [[AEMGameResult alloc] init];
    return _gameResult;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.game.requiredMatches = 2;
    self.matchesNeeded = 2;
    [super viewDidAppear:YES];
}

-(AEMCardMatchingGame *)game
{
    if (!_game) _game = [[AEMCardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[PlayingCardDeck new]];
    
    if (self.priorScore) _game.score = self.priorScore;
    
    _game.requiredMatches = self.matchesNeeded; //Maintains selection between deals
    self.priorScore = nil;
    return _game;
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

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}
- (IBAction)redeal:(id)sender
{
    self.priorScore = self.game.score;
    self.game = nil;
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setImage:[UIImage imageNamed:card.imageName] forState:UIControlStateSelected];
        [cardButton setImage:[UIImage imageNamed:card.imageName] forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0); // if/else
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.messageLabel.text = self.game.moveDescription;
}

-(void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    if (!sender.isSelected) self.flipCount++;
    
    [self updateUI];
    
    self.gameResult.score = self.game.score;
}


@end
