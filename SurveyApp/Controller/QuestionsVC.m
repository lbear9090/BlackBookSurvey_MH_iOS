//
//  QuestionsVC.m
//  SurveyApp
//
//  Created by C111 on 10/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "QuestionsVC.h"

#import "ScoreVC.h"

@interface QuestionsVC ()
{
    
    NSMutableArray *arrKeyQuestions;
    NSInteger questionNumber, questionIndex;
    
    CDQuestions *currentQuestion;
}

@end

@implementation QuestionsVC

@synthesize scrollView;
@synthesize viewOptions, viewSliders;
@synthesize lblProgress, lblTitle, lblDescription;
@synthesize btnNext, btnPrevious;
@synthesize btn0, btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9, btn10;

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
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createSurvay];
    
    [self setupNavigation];
    
    arrKeyQuestions = [[NSMutableArray alloc] init];
    arrKeyQuestions = [[CoreDataAdaptor fetchQuestionsFromCoreData:@"questionType = 'KPI'"] mutableCopy];
    
    currentQuestion = (CDQuestions *)[arrKeyQuestions firstObject];
    questionNumber = 1;
    questionIndex = 0;
    
    [self setNextPreviousButtons];
    
    lblTitle.text = [NSString stringWithFormat:@"%@) %@", currentQuestion.questionId, [currentQuestion.questionTitle capitalizedString]];
    lblTitle.numberOfLines = 0;
    [lblTitle sizeToFit];
    [lblTitle setFrame:({
        CGRect frame = lblTitle.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    lblDescription.text = currentQuestion.questionDescription;
    lblDescription.font = SFUITextRegular(14.0);
    lblDescription.numberOfLines = 0;
    [lblDescription sizeToFit];
    [lblDescription setFrame:({
        CGRect frame = lblDescription.frame;
        frame.origin.y = CGRectGetMaxY(lblTitle.frame) + 8.0;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 8.0;
        CGRectIntegral(frame);
    })];
    [viewSliders setFrame:({
        CGRect frame = viewSliders.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 16.0;
        CGRectIntegral(frame);
    })];
   /* if (self.slider1 == nil)
    {
        self.slider1 = [[UISlider alloc] initWithFrame:CGRectMake(49.0, 5.0, 21.0, (viewOptions.frame.size.height - 10.0))];
        CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
        self.slider1.transform = trans;
        self.slider1.minimumTrackTintColor = [UIColor clearColor];
        self.slider1.maximumTrackTintColor = [UIColor clearColor];
        [self.slider1 setThumbImage:[UIImage imageNamed:@"SliderThumb"] forState:UIControlStateNormal];
        self.slider1.continuous = YES;
        self.slider1.userInteractionEnabled = NO;
        self.slider1.frame = CGRectMake(49.0, 5.0, 21.0, (viewOptions.frame.size.height - 10.0));
        UIImage *sliderThumb = [UIImage imageNamed:@"sliderThumb.png"];
        [self.slider1 setThumbImage:sliderThumb forState:UIControlStateNormal];
        [self.slider1 setThumbImage:sliderThumb forState:UIControlStateHighlighted];
        
        
        [viewOptions addSubview:self.slider1];
    }
    */
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.frame), (CGRectGetMaxY(viewSliders.frame) + 16.0))];
    
    [self updateProgress];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    lblTitle.text = [NSString stringWithFormat:@"%@) %@", currentQuestion.questionId, [currentQuestion.questionTitle capitalizedString]];
    lblTitle.numberOfLines = 0;
    [lblTitle sizeToFit];
    [lblTitle setFrame:({
        CGRect frame = lblTitle.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    lblDescription.text = currentQuestion.questionDescription;
    lblDescription.font = SFUITextRegular(14.0);
    lblDescription.numberOfLines = 0;
    [lblDescription sizeToFit];
    [lblDescription setFrame:({
        CGRect frame = lblDescription.frame;
        frame.origin.y = CGRectGetMaxY(lblTitle.frame) + 8.0;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 8.0;
        CGRectIntegral(frame);
    })];
    [viewSliders setFrame:({
        CGRect frame = viewSliders.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 16.0;
        CGRectIntegral(frame);
    })];
    [self updateProgress];
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
    
    [self updateProgress];
}

- (IBAction)btnNext:(id)sender
{
    /* ScoringKeyVC *scoringKeyVC = iPhoneStoryboard(@"ScoringKeyVC");
    scoringKeyVC.isFromDropdown = NO;
    [self.navigationController pushViewController:scoringKeyVC animated:YES];
    return; */
  

    
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
    
    
    
    if (questionNumber == 18)
    {
        NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]]];
        
        if ([array count] == 18)
        {
            ScoreVC *scoreVC = iPhoneStoryboard(@"ScoreVC");
            [self.navigationController pushViewController:scoreVC animated:YES];
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:@"Please complete the Survey"];
//            ScoreVC *scoreVC = iPhoneStoryboard(@"ScoreVC");
//            [self.navigationController pushViewController:scoreVC animated:YES];
        }
        
        return;
    }
    
   
    currentQuestion = (CDQuestions *)[arrKeyQuestions objectAtIndex:questionNumber];
    
    questionNumber = [currentQuestion.questionId integerValue];
    questionIndex++;
    
    NSArray *array1 = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array1 count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array1 firstObject];
        NSInteger answer = [surveyResponse.responseText integerValue];
        
//        [self setOptions:answer];
        [self.slider1 setValue:answer animated:YES];
    }
    else
    {
//        [self setOptions:15];
        
      
        
        [self.slider1 setValue:0 animated:YES];
    }
    
    [self setNextPreviousButtons];
    
    lblTitle.text = [NSString stringWithFormat:@"%@) %@", currentQuestion.questionId, [currentQuestion.questionTitle capitalizedString]];
    lblTitle.numberOfLines = 0;
    [lblTitle sizeToFit];
    [lblTitle setFrame:({
        CGRect frame = lblTitle.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    lblDescription.text = currentQuestion.questionDescription;
    lblDescription.font = SFUITextRegular(14.0);
    lblDescription.numberOfLines = 0;
    [lblDescription sizeToFit];
    [lblDescription setFrame:({
        CGRect frame = lblDescription.frame;
        frame.origin.y = CGRectGetMaxY(lblTitle.frame) + 8.0;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 8.0;
        CGRectIntegral(frame);
    })];
    
    [viewSliders setFrame:({
        CGRect frame = viewSliders.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 16.0;
        CGRectIntegral(frame);
    })];
    
    [self updateProgress];
    
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.frame), (CGRectGetMaxY(viewSliders.frame) + 16.0))];
    
    [scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
        
    //fetch proper index of question to which object pointing
    /* wsquestion.useranswer = txtanswer.text; */
}

- (IBAction)btnPrevious:(id)sender
{
    currentQuestion = (CDQuestions *)[arrKeyQuestions objectAtIndex:questionIndex-1];
    
    questionNumber = [currentQuestion.questionId integerValue];
    questionIndex--;
    
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d' AND questionId = '%ld'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID], (long)questionNumber]];
    
    if ([array count] > 0)
    {
        CDSurveyResponse *surveyResponse = (CDSurveyResponse *)[array firstObject];
//        NSInteger answer = [surveyResponse.responseText integerValue];
        float answer = [surveyResponse.responseText floatValue];
        
//        [self setOptions:answer];
        [self.slider1 setValue:answer animated:YES];
    }
    else
    {
//        [self setOptions:15];
        [self.slider1 setValue:0.0 animated:YES];
    }
    
    [self setNextPreviousButtons];
    
    lblTitle.text = [NSString stringWithFormat:@"%@) %@", currentQuestion.questionId, [currentQuestion.questionTitle capitalizedString]];
    lblTitle.numberOfLines = 0;
    [lblTitle sizeToFit];
    [lblTitle setFrame:({
        CGRect frame = lblTitle.frame;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    lblDescription.text = currentQuestion.questionDescription;
    lblDescription.font = SFUITextRegular(14.0);
    lblDescription.numberOfLines = 0;
    [lblDescription sizeToFit];
    [lblDescription setFrame:({
        CGRect frame = lblDescription.frame;
        frame.origin.y = CGRectGetMaxY(lblTitle.frame) + 8.0;
        frame.size.width = SCREEN_WIDTH - 20.0;
        CGRectIntegral(frame);
    })];
    
    [viewOptions setFrame:({
        CGRect frame = viewOptions.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 8.0;
        CGRectIntegral(frame);
    })];
    
    [viewSliders setFrame:({
        CGRect frame = viewSliders.frame;
        frame.origin.y = CGRectGetMaxY(lblDescription.frame) + 16.0;
        CGRectIntegral(frame);
    })];
    
    [self updateProgress];
    
    [scrollView setContentSize:CGSizeMake(CGRectGetWidth(scrollView.frame), (CGRectGetMaxY(viewSliders.frame) + 16.0))];
    
    [scrollView setContentOffset:CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Helper Methods

- (void)setupNavigation
{
    self.title = @"Survey Key Performance Indicator";
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(17.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnBack;
}

- (void)setNextPreviousButtons
{
    if (questionNumber == 1)
    {
        [btnPrevious setHidden:YES];
        [btnNext setHidden:NO];
        
        [btnNext setBackgroundImage:[UIImage imageNamed:@"Next"] forState:UIControlStateNormal];
    }
    else if (questionNumber == 18)
    {
        [btnPrevious setHidden:NO];
        [btnNext setHidden:false];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"Finish"] forState:UIControlStateNormal];
        [btnPrevious setBackgroundImage:[UIImage imageNamed:@"Previous"] forState:UIControlStateNormal];
    }
    else
    {
        [btnPrevious setHidden:NO];
        [btnNext setHidden:NO];
        
        [btnNext setBackgroundImage:[UIImage imageNamed:@"Next"] forState:UIControlStateNormal];
        [btnPrevious setBackgroundImage:[UIImage imageNamed:@"Previous"] forState:UIControlStateNormal];
    }
}

- (void)updateProgress
{
    NSArray *array = [CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]]];
    
    NSLog(@"%@",array);
    
    lblProgress.text = [NSString stringWithFormat:@"%d%% completed", (int)(([array count]/18.0) * 100.0)];
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
            
        default:
            break;
    }
    
    if (option <= 10)
    {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self.slider1 setValue:option/10.0 animated:YES];
        } completion:nil];
    }
    else
    {
        [self.slider1 setValue:0.0 animated:YES];
    }
}
#pragma mark - ASValueTrackingSliderDataSource

- (IBAction)sliderValue:(id)sender {

    if (self.slider1.value < 4) {
        
        self.slider1.minimumTrackTintColor = [UIColor redColor];
    }
    else if (self.slider1.value < 6){
        
        self.slider1.minimumTrackTintColor = [UIColor yellowColor];
    }
    else if (self.slider1.value < 7){
        
    self.slider1.minimumTrackTintColor = [UIColor whiteColor];
    }
    else{
        self.slider1.minimumTrackTintColor = [UIColor greenColor];
    }
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
    
    [self updateProgress];
}
- (void)sliderDidHidePopUpView:(ASValueTrackingSlider *)slider{
    NSLog(@" WillHide :%f",slider.value);
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
- (void)createSurvay{
    NSString *surveyName = [NSString stringWithFormat:@"Survey_%@_%@_%@_%@_%@_%@", [Function getStringValueFromUserDefaults_ForKey:kSelectedServicesID], [Function getStringValueFromUserDefaults_ForKey:kSelectedVendorID], [Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizationsID], [Function getStringValueFromUserDefaults_ForKey:kSelectedRolesID],[Function getStringValueFromUserDefaults_ForKey:kSelectedRatingID], TimeStamp];
    
    NSInteger surveyID = [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID] + 1;
    
    [Function setIntegerValueToUserDefaults:(int)surveyID ForKey:kSurveyID];
    [Function setStringValueToUserDefaults:surveyName ForKey:kSurveyName];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       NSMutableDictionary *dictionary = [NSMutableDictionary new];
                       [dictionary setObject:[NSNumber numberWithInteger:surveyID] forKey:@"surveyId"];
                       [dictionary setObject:surveyName forKey:@"surveyName"];
                       [dictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedServicesID] forKey:@"surveyTypeId"];
                       [dictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedVendorID] forKey:@"vendorId"];
                       [dictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizationsID] forKey:@"organizationTypeId"];
                       [dictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedRolesID] forKey:@"roleId"];
                       
                       if ([Function getStringValueFromUserDefaults_ForKey:kSelectedRatingID].length > 0) {
                           [dictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedRatingID] forKey:@"ratingId"];
                       }
                       
                       [CoreDataAdaptor saveSurveysInCoreData:dictionary];
                       
                       dispatch_async( dispatch_get_main_queue(), ^
                                      {
                                        
                                      });
                   });
}
@end
