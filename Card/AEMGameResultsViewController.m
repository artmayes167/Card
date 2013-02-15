//
//  AEMGameResultsViewController.m
//  Card
//
//  Created by Arthur Mayes on 2/7/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "AEMGameResultsViewController.h"
#import "AEMGameResult.h"

@interface AEMGameResultsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *scoresTextView;

@end

@implementation AEMGameResultsViewController

-(void)updateUI
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString;
    NSString *displayText = @"";
    for (AEMGameResult *result in [AEMGameResult allGameResults]) {
        
        dateString = [dateFormatter stringFromDate:result.end];
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, dateString, round(result.duration)];
    }
    self.scoresTextView.text = displayText;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)setUp
{
    // inititalization that can't wait until viewDidLoad
}
-(void)awakeFromNib
{
    [self setUp];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setUp];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
