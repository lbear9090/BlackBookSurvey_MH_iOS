//
//  LoyaltyQuestionsVC.m
//  SurveyApp
//
//  Created by C111 on 09/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "LoyaltyQuestionsVC.h"

#import "SubmitVC.h"

@interface LoyaltyQuestionsVC ()<UIScrollViewDelegate>
{
    UISlider *slider;
    
    NSMutableArray *arrLoyaltyQuestions;
    NSInteger questionNumber, questionIndex, questionAnswered;
    
    CDQuestions *currentQuestion;
}

@end

@implementation LoyaltyQuestionsVC

@synthesize viewOptions;
@synthesize lblQuestion;
@synthesize btn0, btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn10,btn11;

#pragma mark - View life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigation];
    // customize slider 1
    self.slider1.maximumValue = 10;
    self.slider1.minimumValue = 0;
    self.slider1.value = 0.0;
    self.slider1.delegate = self;
    self.slider1.popUpViewCornerRadius = 10.0;
    [self.slider1 setMaxFractionDigitsDisplayed:0];
    self.slider1.popUpViewColor = [UIColor blackColor];
    self.slider1.font = SFUITextRegular(16.0);;
    self.slider1.textColor = [UIColor whiteColor];
    self.slider1.popUpViewWidthPaddingFactor = 1.5;
    
    UIImage *sliderThumb = [self imageWithImage:[UIImage imageNamed:@"SelectedRadio.png"] scaledToSize:CGSizeMake(10, 10)];
    [self.slider1 setThumbImage:sliderThumb forState:UIControlStateNormal];
    [self.slider1 setThumbImage:sliderThumb forState:UIControlStateHighlighted];
    
    arrLoyaltyQuestions = [[NSMutableArray alloc] init];
    questionAnswered = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.scrollView.delegate = self;
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width,CGRectGetMaxY(_lbl11.frame) +15.0)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self setupNavigation];
    
     [self setNextPreviousButtons];
    
    arrLoyaltyQuestions = [[CoreDataAdaptor fetchQuestionsFromCoreData:[NSString stringWithFormat:@"questionType = 'Loyalty'"]] mutableCopy];
    
    currentQuestion = (CDQuestions *)[arrLoyaltyQuestions firstObject];
    questionNumber = 19;
    questionIndex = 0;
    
    [self setButtonTitlesForType:kRenew];
    
    lblQuestion.text = [NSString stringWithFormat:@"%@", currentQuestion.questionTitle];
    lblQuestion.numberOfLines = 0;
    [lblQuestion sizeToFit];
    [lblQuestion setFrame:({
        CGRect frame = lblQuestion.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblQuestion.frame) + 8.0;
        CGRectIntegral(frame);
    })];
    
    slider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMinX(_imgSliderView.frame) - 5.0, 5.0, 19.0, (viewOptions.frame.size.height - 10.0))];
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    slider.transform = trans;
    slider.minimumTrackTintColor = [UIColor clearColor];
    slider.maximumTrackTintColor = [UIColor clearColor];
    [slider setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
    slider.continuous = YES;
    slider.userInteractionEnabled = NO;
    slider.frame = CGRectMake(CGRectGetMinX(_imgSliderView.frame) - 5.0, 5.0, 19.0, (viewOptions.frame.size.height - 10.0));
    [viewOptions addSubview:slider];
    [_scrollView addSubview:slider];

    
    
    
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
        NSInteger answer = [surveyResponse.responseText integerValue];
        [self.slider1 setValue:answer];
        [self setOptions:answer];
    }
    else
    {
        [self.slider1 setValue:0];
        [self setOptions:15];
    }
   
    [self startCounter];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action Methods

- (IBAction)answerSelected:(UIButton *)sender
{
    [self setOptions:[sender tag]];
    
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
        surveyResponse.responseText = [NSString stringWithFormat:@"%ld", (long)[sender tag]];
        
        [CoreDataHelper save];
    }
    else
    {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[NSNumber numberWithInteger:[Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]] forKey:@"surveyId"];
        [dictionary setObject:[NSNumber numberWithInteger:questionNumber] forKey:@"questionId"];
        [dictionary setObject:[NSNumber numberWithInteger:[sender tag]] forKey:@"responseText"];
        
        [CoreDataAdaptor saveSurveyResponseInCoreData:dictionary];
    }
}

- (IBAction)btnBack:(id)sender
{
   
    
    if (questionNumber == 19)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    currentQuestion = (CDQuestions *)[arrLoyaltyQuestions objectAtIndex:questionIndex-1];
    
    questionNumber = [currentQuestion.questionId integerValue];
    questionIndex--;
    
    if (questionNumber == 19)
        [self setButtonTitlesForType:kRenew];
    else if (questionNumber == 20)
        [self setButtonTitlesForType:kRecommend];
    else if (questionNumber == 21)
        [self setButtonTitlesForType:kBuyMore];
    
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
        NSInteger answer = [surveyResponse.responseText integerValue];
        
        [self setOptions:answer];
        [self.slider1 setValue:answer];
        
    }
    else
    {
        [self.slider1 setValue:0];
        [self setOptions:15];
    }
    
    lblQuestion.text = [NSString stringWithFormat:@"%@", currentQuestion.questionTitle];
    lblQuestion.numberOfLines = 0;
    [lblQuestion sizeToFit];
    [lblQuestion setFrame:({
        CGRect frame = lblQuestion.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblQuestion.frame) + 8.0;
        CGRectIntegral(frame);
    })];
      [self setNextPreviousButtons];
}

//- (IBAction)btnNext:(id)sender
//{
//    if (questionNumber == 21)
//    {
//        NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]]];
//
//        if ([array count] >= 18)
//        {
//            [Function removeUserDefaultsForKey:@"callingCode"];
//            [Function removeUserDefaultsForKey:@"countryName"];
//
//            RegistrationVC *registrationVC = iPhoneStoryboard(@"RegistrationVC");
//            [self.navigationController pushViewController:registrationVC animated:YES];
//        }
//
//        return;
//    }
//
//    questionIndex++;
//
//    currentQuestion = (CDQuestions *)[arrLoyaltyQuestions objectAtIndex:questionIndex];
//
//    questionNumber = [currentQuestion.questionId integerValue];
//
//    if (questionNumber == 19)
//        [self setButtonTitlesForType:kRenew];
//    else if (questionNumber == 20)
//        [self setButtonTitlesForType:kRecommend];
//    else if (questionNumber == 21)
//        [self setButtonTitlesForType:kBuyMore];
//
//    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
//
//    if ([array count] > 0)
//    {
//        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
//        NSInteger answer = [surveyResponse.responseText integerValue];
//
//        [self setOptions:answer];
//    }
//    else
//    {
//        [self setOptions:15];
//    }
//
//    lblQuestion.text = [NSString stringWithFormat:@"%@", currentQuestion.questionTitle];
//    lblQuestion.numberOfLines = 0;
//    [lblQuestion sizeToFit];
//    [lblQuestion setFrame:({
//        CGRect frame = lblQuestion.frame;
//        frame.size.width = SCREEN_WIDTH - 20.0;
//        CGRectIntegral(frame);
//    })];
//
//    [viewOptions setFrame:({
//        CGRect frame = viewOptions.frame;
//        frame.origin.y = CGRectGetMaxY(lblQuestion.frame) + 8.0;
//        CGRectIntegral(frame);
//    })];
//}

#pragma mark - Helper Methods

- (void)setupNavigation
{
    self.title = @"Loyalty Questions";
    
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
   // self.navigationItem.rightBarButtonItem = barButton;
}

- (void)setButtonTitlesForType:(NSString *)type
{
    if ([type isEqualToString:kRenew])
    {
        [btn0 setTitle:@"0 Not Renewing" forState:UIControlStateNormal];
        [btn10 setTitle:@"10 Confidently Renewing" forState:UIControlStateNormal];
        
    }
    else if ([type isEqualToString:kRecommend])
    {
        [btn0 setTitle:@"0 Can Not Recommend" forState:UIControlStateNormal];
        [btn10 setTitle:@"10 Confidently Recommend" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:kBuyMore])
    {
        [btn0 setTitle:@"0 Not Renewing" forState:UIControlStateNormal];
        [btn10 setTitle:@"10 Confidently Renewing" forState:UIControlStateNormal];
    }
}

- (void)setOptions:(NSInteger)option
{
    [btn0 setSelected:NO];
    [btn1 setSelected:NO];
    [btn2 setSelected:NO];
    [btn3 setSelected:NO];
    [btn4 setSelected:NO];
    [btn5 setSelected:NO];
    [btn6 setSelected:NO];
    [btn7 setSelected:NO];
    [btn8 setSelected:NO];
    [btn9 setSelected:NO];
    [btn10 setSelected:NO];
    [btn11 setSelected:NO];
    
    switch (option)
    {
        case 0:
            [btn0 setSelected:YES];
            break;
            
        case 1:
            [btn1 setSelected:YES];
            break;
            
        case 2:
            [btn2 setSelected:YES];
            break;
            
        case 3:
            [btn3 setSelected:YES];
            break;
            
        case 4:
            [btn4 setSelected:YES];
            break;
            
        case 5:
            [btn5 setSelected:YES];
            break;
            
        case 6:
            [btn6 setSelected:YES];
            break;
            
        case 7:
            [btn7 setSelected:YES];
            break;
            
        case 8:
            [btn8 setSelected:YES];
            break;
            
        case 9:
            [btn9 setSelected:YES];
            break;
            
        case 10:
            [btn10 setSelected:YES];
            break;
        case 11:
            [btn11 setSelected:YES];
            break;
            
        default:
            break;
    }
    
    if (option <= 11)
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [slider setValue:option/11.0    animated:YES];
        } completion:nil];
    }
    else
    {
        [slider setValue:0.0 animated:YES];
    }
}
#pragma mark - ASValueTrackingSliderDataSource

- (IBAction)sliderValue:(id)sender {

   
}
- (void)animateSlider:(ASValueTrackingSlider*)slider toValue:(float)value
{
    
    [slider setValue:value animated:YES];
}
- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider{
    
    int intValue = (int)ceil(slider.value);
    NSLog(@"%d",intValue);
    
    
}
- (void)sliderWillHidePopUpView:(ASValueTrackingSlider *)slider
{
    int intValue = (int)roundf(slider.value );
    
    NSLog(@"DidHide : %d",intValue);
    
    
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
        surveyResponse.responseText = [NSString stringWithFormat:@"%ld", (long)intValue];
        
        [CoreDataHelper save];
    }
    else
    {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[NSNumber numberWithInteger:[Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]] forKey:@"surveyId"];
        [dictionary setObject:[NSNumber numberWithInteger:questionNumber] forKey:@"questionId"];
        [dictionary setObject:[NSNumber numberWithInteger:intValue] forKey:@"responseText"];
        
        [CoreDataAdaptor saveSurveyResponseInCoreData:dictionary];
    }
    
    ////
    
   // [self updateProgress];
}
-(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (IBAction)btnPrevious:(id)sender
{
    if (questionNumber == 19)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
   
    
    currentQuestion = (CDQuestions *)[arrLoyaltyQuestions objectAtIndex:questionIndex-1];
    
    questionNumber = [currentQuestion.questionId integerValue];
    questionIndex--;
    
    if (questionNumber == 19)
        [self setButtonTitlesForType:kRenew];
    else if (questionNumber == 20)
        [self setButtonTitlesForType:kRecommend];
    else if (questionNumber == 21)
        [self setButtonTitlesForType:kBuyMore];
    
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
        NSInteger answer = [surveyResponse.responseText integerValue];
        
        [self setOptions:answer];
        [self.slider1 setValue:answer];
    }
    else
    {
        [self setOptions:15];
          [self.slider1 setValue:0];
    }
    
    lblQuestion.text = [NSString stringWithFormat:@"%@", currentQuestion.questionTitle];
    lblQuestion.numberOfLines = 0;
    [lblQuestion sizeToFit];
    [lblQuestion setFrame:({
        CGRect frame = lblQuestion.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblQuestion.frame) + 8.0;
        CGRectIntegral(frame);
    })];
}
-(void)CheckifZeroAnser{
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
        surveyResponse.responseText = [NSString stringWithFormat:@"%ld", (long)self.slider1.value];
        
        [CoreDataHelper save];
    }
    else
    {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
        [dictionary setObject:[NSNumber numberWithInteger:[Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]] forKey:@"surveyId"];
        [dictionary setObject:[NSNumber numberWithInteger:questionNumber] forKey:@"questionId"];
        [dictionary setObject:[NSNumber numberWithInteger:self.slider1.value] forKey:@"responseText"];
        
        [CoreDataAdaptor saveSurveyResponseInCoreData:dictionary];
    }
     [self setNextPreviousButtons];
}
- (IBAction)btnNext:(id)sender

{
    
    [self CheckifZeroAnser];
    
    
    if (questionNumber == 21)
    {
        NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]]];
        
        if ([array count] >= 18)
        {
            [Function removeUserDefaultsForKey:@"callingCode"];
            [Function removeUserDefaultsForKey:@"countryName"];
            
            SubmitVC *submitVC = iPhoneStoryboard(@"SubmitVC");
            [self.navigationController pushViewController:submitVC animated:YES];
        }
        
        return;
    }
    
    questionIndex++;
    
    currentQuestion = (CDQuestions *)[arrLoyaltyQuestions objectAtIndex:questionIndex];
    
    
    
    questionNumber = [currentQuestion.questionId integerValue];
    
    if (questionNumber == 19)
        [self setButtonTitlesForType:kRenew];
    else if (questionNumber == 20)
        [self setButtonTitlesForType:kRecommend];
    else if (questionNumber == 21)
        [self setButtonTitlesForType:kBuyMore];
    
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
        NSInteger answer = [surveyResponse.responseText integerValue];
        [self.slider1 setValue:answer];
        [self setOptions:answer];
    }
    else
    {
        [self.slider1 setValue:0];
        [self setOptions:15];
    }
    
    lblQuestion.text = [NSString stringWithFormat:@"%@", currentQuestion.questionTitle];
    lblQuestion.numberOfLines = 0;
    [lblQuestion sizeToFit];
    [lblQuestion setFrame:({
        CGRect frame = lblQuestion.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblQuestion.frame) + 8.0;
        CGRectIntegral(frame);
    })];
    
    [self setNextPreviousButtons];
    
}
- (void)setNextPreviousButtons
{
    if (questionNumber == 19)
    {
       // [_btnPrevious setHidden:YES];
       // [_btnNext setHidden:NO];
        
        [_btnNext setBackgroundImage:[UIImage imageNamed:@"Next"] forState:UIControlStateNormal];
    }
    else if (questionNumber == 21)
    {
       // [self.btnPrevious setHidden:NO];
       // [self.btnNext setHidden:false];
        [self.btnNext setBackgroundImage:[UIImage imageNamed:@"Finish"] forState:UIControlStateNormal];
        [self.btnPrevious setBackgroundImage:[UIImage imageNamed:@"Previous"] forState:UIControlStateNormal];
    }
    else
    {
       // [self.btnPrevious setHidden:NO];
       // [self.btnNext setHidden:NO];
        
        [self.btnNext setBackgroundImage:[UIImage imageNamed:@"Next"] forState:UIControlStateNormal];
        [self.btnPrevious setBackgroundImage:[UIImage imageNamed:@"Previous"] forState:UIControlStateNormal];
    }
    
    [self changeCounter];
}

#pragma mark - Counters
- (void)startCounter{
    
    self.counterLabel.text = [NSString stringWithFormat:@"%@ of %@", [NSNumber numberWithUnsignedInteger:1], [NSNumber numberWithUnsignedInteger:arrLoyaltyQuestions.count]];
    
}

- (void)changeCounter{
    
        self.counterLabel.text = [NSString stringWithFormat:@"%@ of %@", [NSNumber numberWithUnsignedInteger:questionIndex+1], [NSNumber numberWithUnsignedInteger:arrLoyaltyQuestions.count]];
    
}

@end
