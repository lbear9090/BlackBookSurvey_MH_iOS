//
//  ScoreVC.m
//  SurveyApp
//
//  Created by C111 on 30/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "ScoreVC.h"

#import "LoyaltyQuestionsVC.h"

#import "KeyPerformanceCell.h"

@interface ScoreVC ()
{
    NSMutableArray *arrQuestions;
    NSMutableArray *arrResponse;
    NSMutableArray *arrScores;
}

@end

@implementation ScoreVC

@synthesize tblScores;

#pragma mark - View life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    
    arrQuestions = [[NSMutableArray alloc] init];
    arrResponse = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNavigation];
    
    arrQuestions = [[CoreDataAdaptor fetchQuestionsFromCoreData:@"questionType = 'KPI'"] mutableCopy];
    
    arrResponse = [[CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]]] mutableCopy];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"questionId.integerValue" ascending:YES];
    arrResponse = [[arrResponse sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]] mutableCopy];
    
    arrScores = [[NSMutableArray alloc] init];
    
    for (CDSurveyResponse *response in arrResponse)
    {
        NSArray *array = [CoreDataAdaptor fetchQuestionsFromCoreData:[NSString stringWithFormat:@"questionId = '%@' AND questionType = 'KPI'", response.questionId]];
        
        if ([array count] > 0)
            [arrScores addObject:[NSNumber numberWithFloat:[response.responseText floatValue]]];
    }
    
    NSNumber *mean = [arrScores valueForKeyPath:@"@avg.floatValue"];
    NSLog(@"Mean - %@", mean);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode: NSNumberFormatterRoundUp];
    
    NSArray *array = [CoreDataAdaptor fetchScoreMatrixFromCoreData:nil];
    
    for (CDScoreMatrix *scoreMatrix in array)
    {
        if (Between([[numberFormatter stringFromNumber:mean] floatValue], [scoreMatrix.startRange floatValue], [scoreMatrix.endRange floatValue]))
            [Function setIntegerValueToUserDefaults:[scoreMatrix.scoreMatrixId intValue] ForKey:kScoreMatrixID];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrResponse count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ((KeyPerformanceCell *)[self getKeyPerformanceCellForRowAtIndexPath:indexPath]).contentView.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getKeyPerformanceCellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableView Helper Methods

- (UITableViewCell *)getKeyPerformanceCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KeyPerformanceCell *cell = (KeyPerformanceCell *)[tblScores dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"keyPerformanceCell_%ld",(long)indexPath.row]];
    
    if (cell == nil)
    {
        cell = [[KeyPerformanceCell alloc] initWithStyleForKeyPerformanceIndicator:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"keyPerformanceCell_%ld",(long)indexPath.row]];
    }
    
    if (indexPath.row % 2 == 0)
        cell.backgroundColor = RGB(242.0, 242.0, 242.0);
    else
        cell.backgroundColor = [UIColor whiteColor];
    
    CDSurveyResponse *response = [arrResponse objectAtIndex:indexPath.row];
    
    cell.lblPoints.text = response.responseText;
    cell.lblPoints.backgroundColor = RGB(212.0, 212.0, 212.0);
    cell.lblPoints.layer.cornerRadius = 5.0;
    cell.lblPoints.layer.masksToBounds = YES;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"questionId = %@", response.questionId];
    NSArray *filterArray = [arrQuestions filteredArrayUsingPredicate:predicate];
    
    CDQuestions *question = [filterArray firstObject];
    
    cell.lblKeyPerformanceIndicator.text = [NSString stringWithFormat:@"%d) %@", (indexPath.row + 1), [question.questionTitle capitalizedString]];
    
    cell.lblKeyPerformanceIndicator.numberOfLines = 0;
    [cell.lblKeyPerformanceIndicator sizeToFit];
    
    if (cell.lblKeyPerformanceIndicator.frame.size.height > 46.0)
    {
        cell.contentView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, CGRectGetMaxY(cell.lblKeyPerformanceIndicator.frame) + 10.0);
        
        [cell.lblKeyPerformanceIndicator setFrame:({
            CGRect frame = cell.lblKeyPerformanceIndicator.frame;
            frame.origin.y = cell.contentView.frame.size.height/2 - cell.lblKeyPerformanceIndicator.frame.size.height/2;
            CGRectIntegral(frame);
        })];
        
        [cell.lblPoints setFrame:({
            CGRect frame = cell.lblPoints.frame;
            frame.origin.y = cell.contentView.frame.size.height/2 - cell.lblPoints.frame.size.height/2;
            CGRectIntegral(frame);
        })];
    }
    else
    {
        cell.contentView.frame = CGRectMake(0.0, 0.0, SCREEN_WIDTH, 46.0);
        
        [cell.lblKeyPerformanceIndicator setFrame:({
            CGRect frame = cell.lblKeyPerformanceIndicator.frame;
            frame.size.height = 46.0;
            CGRectIntegral(frame);
        })];
        
        [cell.lblPoints setFrame:({
            CGRect frame = cell.lblPoints.frame;
            frame.origin.y = cell.contentView.frame.size.height/2 - cell.lblPoints.frame.size.height/2;
            CGRectIntegral(frame);
        })];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Button Action Methods

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnNext:(id)sender
{
    LoyaltyQuestionsVC *loyaltyQuestionsVC = iPhoneStoryboard(@"LoyaltyQuestionsVC");
    [self.navigationController pushViewController:loyaltyQuestionsVC animated:YES];
}

#pragma mark - Helper Methods

- (void)setupNavigation
{
    self.title = @"Your Scoring Summary";
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"TopNext"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnNext:)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0.0, 0.0, 58.0, 22.0)];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
}

@end
