//
//  RegistrationVC.m
//  SurveyApp
//
//  Created by C111 on 09/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "RegistrationVC.h"

#import "StartSurveyVC.h"
#import "ExpandableTableVC.h"

#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
#define REGEX_NAME @"[A-Za-z ]+"

@interface RegistrationVC ()<UIScrollViewDelegate>
{
    NSMutableArray *arrPreferences, *arrPreferencesID;
}

@end

@implementation RegistrationVC

@synthesize viewCredentials, viewOptions;
@synthesize txtEmail, txtName, txtPhone;
@synthesize btnNotice, btnIncentives, btnFutureSurvey, btnSubmit;

#pragma mark - View life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    
    arrPreferences = [[NSMutableArray alloc] init];
    arrPreferencesID = [[NSMutableArray alloc] init];
    [_btnEmailPref setSelected:NO];
    [_btnTelephonePref setSelected:NO];
   
    
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard:)];
    
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(hideKeyboard:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, SCREEN_WIDTH, 44.0)];
    toolbar.backgroundColor = [UIColor lightGrayColor];
    [toolbar setItems:[NSArray arrayWithObjects:btnCancel, flexibleSpace, btnDone, nil]];
    txtPhone.inputAccessoryView = toolbar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNavigation];
    
    [Function setIntegerValueToUserDefaults:([btnNotice isSelected] ? 1 : 0) ForKey:@"isNotice"];
    [Function setIntegerValueToUserDefaults:([btnIncentives isSelected] ? 1 : 0) ForKey:@"isIncentives"];
    [Function setIntegerValueToUserDefaults:([btnFutureSurvey isSelected] ? 1 : 0) ForKey:@"isFuture"];
    [Function setIntegerValueToUserDefaults:([_btnEmailPref isSelected] ? 1 : 0) ForKey:@"isEmail"];
    [Function setIntegerValueToUserDefaults:([_btnTelephonePref isSelected] ? 1 : 0) ForKey:@"isTelephone"];
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsFacebookLogin])
    {
        viewCredentials.hidden = YES;
        
        [viewOptions setFrame:({
            CGRect frame = viewOptions.frame;
            frame.origin.x = 8.0;
            frame.origin.y = 8.0;
            CGRectIntegral(frame);
        })];

        [_viewBottom setFrame:({
            CGRect frame = _viewBottom.frame;
            frame.origin.y = CGRectGetMaxY(viewOptions.frame) + 8.0;
            frame.size.height=CGRectGetMaxY(_imgLogo.frame) + 8.0;
            CGRectIntegral(frame);
        })];
        
    }
    else
    {
        viewCredentials.hidden = NO;
        
        [viewCredentials setFrame:({
            CGRect frame = viewCredentials.frame;
            frame.origin.x = 8.0;
            frame.origin.y = 8.0;
            CGRectIntegral(frame);
        })];
        
        [viewOptions setFrame:({
            CGRect frame = viewOptions.frame;
            frame.origin.x = 8.0;
            frame.origin.y = CGRectGetMaxY(viewCredentials.frame) + 8.0;
            CGRectIntegral(frame);
        })];
        
        [_viewBottom setFrame:({
            CGRect frame = _viewBottom.frame;
            frame.origin.y = CGRectGetMaxY(viewOptions.frame) + 8.0;
            frame.size.height=CGRectGetMaxY(_imgLogo.frame) + 8.0;
            CGRectIntegral(frame);
        })];
        
    }
    
    self.scrollView.delegate = self;
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width,CGRectGetMaxY(_viewBottom.frame) + 15.0)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    arrPreferences = [[CoreDataAdaptor fetchPreferencesFromCoreData:nil] mutableCopy];
    
    for (CDPreferences *preferences in arrPreferences)
    {
        if ([preferences.preferenceText containsString:kNotice])
            btnNotice.titleLabel.text = preferences.preferenceText;
        else if ([preferences.preferenceText containsString:kIncentives])
            btnIncentives.titleLabel.text = preferences.preferenceText;
        else if ([preferences.preferenceText containsString:kFuture  ])
            btnFutureSurvey.titleLabel.text = preferences.preferenceText;
        
        [arrPreferencesID addObject:preferences.preferenceId];
    }
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsEditingProfile] && [Function getBooleanValueFromUserDefaults_ForKey:kUserLoggedIn])
    {
        txtName.text = [Function getStringValueFromUserDefaults_ForKey:kUserName];
        txtEmail.text = [Function getStringValueFromUserDefaults_ForKey:kEmail];
        txtPhone.text = [Function getStringValueFromUserDefaults_ForKey:kPhone];
    }
    else
    {
         if (!self.isGuest) {
        
        if ([Function getBooleanValueFromUserDefaults_ForKey:kIsFacebookLogin] || [Function getBooleanValueFromUserDefaults_ForKey:kIsGoogleLogin] || [Function getBooleanValueFromUserDefaults_ForKey:kIsTwitterLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsLinkedinLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsAppleLogin])

        txtName.text = [Function getStringValueFromUserDefaults_ForKey:@"facebookName"];
        txtEmail.text = [Function getStringValueFromUserDefaults_ForKey:@"facebookEmail"];
        } }
        
    }


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action Methods

- (IBAction)btnNotice:(UIButton *)sender
{
    if ([btnNotice isSelected])
        [btnNotice setSelected:NO];
    else
        [btnNotice setSelected:YES];
    
    [Function setIntegerValueToUserDefaults:([btnNotice isSelected] ? 1 : 0) ForKey:@"isNotice"];
}

- (IBAction)btnIncentives:(UIButton *)sender
{
    if ([btnIncentives isSelected])
        [btnIncentives setSelected:NO];
    else
        [btnIncentives setSelected:YES];
    
    [Function setIntegerValueToUserDefaults:([btnIncentives isSelected] ? 1 : 0) ForKey:@"isIncentives"];
}

- (IBAction)btnFutureSurveys:(UIButton *)sender
{
    if ([btnFutureSurvey isSelected])
        [btnFutureSurvey setSelected:NO];
    else
        [btnFutureSurvey setSelected:YES];
    
    [Function setIntegerValueToUserDefaults:([btnFutureSurvey isSelected] ? 1 : 0) ForKey:@"isFuture"];
}

- (IBAction)btnSubmit:(UIButton *)sender
{
    if (self.isGuest) {
        if (txtName.text.length < 1)
        {
            [SVProgressHUD showErrorWithStatus:@"Please enter your name"];
        }
        else if (![self isNameValid:txtName.text])
        {
            [SVProgressHUD showErrorWithStatus:@"Name should contain only Alphabets"];
        }
        else if (txtEmail.text.length < 1)
        {
            [SVProgressHUD showErrorWithStatus:@"Please enter your email"];
        }
        else if (![self isEmailValid:txtEmail.text])
        {
            [SVProgressHUD showErrorWithStatus:@"Please enter a valid email"];
        }
        else if (txtPhone.text.length < 1)
        {
            [SVProgressHUD showErrorWithStatus:@"Please enter a phone number"];
        }
        else if (![self validatePhone:txtPhone.text])
        {
            [SVProgressHUD showErrorWithStatus:@"Please enter a valid phone number"];
        }
        /*
        else if (!self.btnNotice.isSelected)
        {
            [SVProgressHUD showErrorWithStatus:@"Please check you'd like to receive notice"];
        }
        else if (!self.btnIncentives.isSelected)
        {
            [SVProgressHUD showErrorWithStatus:@"Please check you'd like to eligible for incentives"];
        }
        else if (!self.btnFutureSurvey.isSelected)
        {
            [SVProgressHUD showErrorWithStatus:@"Please check you'd like to more information"];
        }*/
        
        else
        {
            NSMutableDictionary *postDictionary = [[NSMutableDictionary alloc] init];

            [postDictionary setObject:txtName.text forKey:@"username"];
            [postDictionary setObject:txtEmail.text forKey:@"emailID"];
            [postDictionary setObject:txtPhone.text forKey:@"phone"];

            NSLog(@"Post Dictionary - %@", postDictionary);

           // [SVProgressHUD showWithStatus:@"Please wait..."];
          //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
              [self saveProfile];
           // StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
            //[self.navigationController pushViewController:startSurveyVC animated:YES];
        }
        return;
    }
    if (_isCompleteProfile) {
        
         [self saveProfile];
        
          return;
    
    }
    
    
    //  Calculating Score and creatign array for Question IDs and Response Texts
    NSMutableArray *arrResponse = [[CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]]] mutableCopy];
    
    NSMutableArray *arrQuestionIDs = [[NSMutableArray alloc] init];
    NSMutableArray *arrResponseTexts = [[NSMutableArray alloc] init];
    
    for (CDSurveyResponse *response in arrResponse)
    {
        CDQuestions *question = (CDQuestions *)[[CoreDataAdaptor fetchQuestionsFromCoreData:[NSString stringWithFormat:@"questionId = '%@'", response.questionId]] firstObject];
        
        [arrQuestionIDs addObject:question.questionId];
        [arrResponseTexts addObject:response.responseText];
    }
    
    NSMutableArray *arrScores = [[NSMutableArray alloc] init];
    
    NSMutableArray *arrOtherResponse = [[CoreDataAdaptor fetchSurveyResponseFromCoreData:[NSString stringWithFormat:@"surveyId = '%d'", [Function getIntegerValueFromUserDefaults_ForKey:kSurveyID]]] mutableCopy];
    
    for (CDSurveyResponse *response in arrOtherResponse)
    {
        NSArray *array = [CoreDataAdaptor fetchQuestionsFromCoreData:[NSString stringWithFormat:@"questionId = '%@' AND questionType = 'KPI'", response.questionId]];
        
        if ([array count] > 0)
        {
            [arrScores addObject:[NSNumber numberWithFloat:[response.responseText floatValue]]];
        }
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode: NSNumberFormatterRoundUp];
    
    //  Creating array for USER PREFERENCES
    
    NSNumber *numberNotice = [NSNumber numberWithInt:[Function getIntegerValueFromUserDefaults_ForKey:@"isNotice"]];
    NSNumber *numberIncentives = [NSNumber numberWithInt:[Function getIntegerValueFromUserDefaults_ForKey:@"isIncentives"]];
    NSNumber *numberFuture = [NSNumber numberWithInt:[Function getIntegerValueFromUserDefaults_ForKey:@"isFuture"]];
    NSNumber *numberEmail = [NSNumber numberWithInt:[Function getIntegerValueFromUserDefaults_ForKey:@"isEmail"]];
    NSNumber *numberTelephone = [NSNumber numberWithInt:[Function getIntegerValueFromUserDefaults_ForKey:@"isTelephone"]];
    
    NSArray *arrUserPreferences = [NSArray arrayWithObjects:numberNotice, numberIncentives, numberFuture,numberEmail,numberTelephone,nil];
    
    NSMutableDictionary *postDictionary = [[NSMutableDictionary alloc] init];
    
    NSArray *arrOther = [CoreDataAdaptor fetchOrganizationTypeFromCoreData:[NSString stringWithFormat:@"organizationTypeName = 'Other' AND level = '%@'", [NSNumber numberWithInteger:0]]];
    
    if ([arrOther count] > 0)
    {
        CDOrganizationType *organizationType = (CDOrganizationType *)[arrOther firstObject];
        
        if ([organizationType.organizationTypeId isEqualToString:[Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizationsID]])
            [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kOtherOrgaizationTitle] forKey:@"otherTitle"];
    }
    
  
    if([[Function getStringValueFromUserDefaults_ForKey:kSelectedVendorID] isEqualToString:@"974"])
    {
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedVendor] forKey:@"otherVendorTitle"];
    }
    
    [postDictionary setObject:@"" forKey:@"deviceToken"];
    [postDictionary setObject:kDeviceType forKey:@"deviceType"];
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedRolesID].length > 0) {
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedRolesID] forKey:@"roleID"];
    }
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizationsID].length > 0) {
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizationsID] forKey:@"organizationTypeID"];
    }

    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedServicesID].length > 0) {
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedServicesID] forKey:@"surveyTypeID"];

    }
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedVendorID].length > 0) {
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedVendorID] forKey:@"vendorID"];
    }
    if ([numberFormatter stringFromNumber:[arrScores valueForKeyPath:@"@avg.floatValue"]].length > 0) {
        [postDictionary setObject:[numberFormatter stringFromNumber:[arrScores valueForKeyPath:@"@avg.floatValue"]] forKey:@"surveyScoreObtained"];
    }
    if ([NSNumber numberWithInt:[Function getIntegerValueFromUserDefaults_ForKey:kScoreMatrixID]] > 0) {
        [postDictionary setObject:[NSNumber numberWithInt:[Function getIntegerValueFromUserDefaults_ForKey:kScoreMatrixID]] forKey:@"scoreMatrixID"];
    }
    [postDictionary setObject:[arrPreferencesID componentsJoinedByString:@","] forKey:@"preferences"];
    [postDictionary setObject:[arrUserPreferences componentsJoinedByString:@","] forKey:@"userPreferences"];
    [postDictionary setObject:[arrQuestionIDs componentsJoinedByString:@","] forKey:@"questionIDs"];
    [postDictionary setObject:[arrResponseTexts componentsJoinedByString:@","] forKey:@"responseTexts"];
    
    if ([[NetworkAvailability instance] isReachable])
    {
        if ([Function getBooleanValueFromUserDefaults_ForKey:kIsFacebookLogin] || [Function getBooleanValueFromUserDefaults_ForKey:kIsGoogleLogin] || [Function getBooleanValueFromUserDefaults_ForKey:kIsTwitterLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsLinkedinLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsAppleLogin])
        {
            if ([Function getStringValueFromUserDefaults_ForKey:kUID].length > 0) {
                [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kUID] forKey:@"userID"];
            }
            
            NSLog(@"Post Dictionary - %@", postDictionary);
            
            [SVProgressHUD showWithStatus:@"Please wait..."];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            
            [[WebServiceConnector alloc] init:WSSetSurveyStatisticsForUser withParameters:postDictionary withObject:self withSelector:@selector(getSurveyDataResponse:) forServiceType:@"JSON" showDisplayMsg:nil];
        }
        else
        {
            if (txtName.text.length < 1)
            {
                [SVProgressHUD showErrorWithStatus:@"Please enter your name"];
            }
            else if (![self isNameValid:txtName.text])
            {
                [SVProgressHUD showErrorWithStatus:@"Name should contain only Aplphabets"];
            }
            else if (txtEmail.text.length < 1)
            {
                [SVProgressHUD showErrorWithStatus:@"Please enter your email"];
            }
            else if (![self isEmailValid:txtEmail.text])
            {
                [SVProgressHUD showErrorWithStatus:@"Please enter a valid email"];
            }
            else if (txtPhone.text.length < 1)
            {
                [SVProgressHUD showErrorWithStatus:@"Please enter a phone number"];
            }
            else if (![self validatePhone:txtPhone.text])
            {
                [SVProgressHUD showErrorWithStatus:@"Please enter a valid phone number"];
            }/*
            else if (!self.btnNotice.isSelected)
            {
                [SVProgressHUD showErrorWithStatus:@"Please check you'd like to receive notice"];
            }
            else if (!self.btnIncentives.isSelected)
            {
                [SVProgressHUD showErrorWithStatus:@"Please check you'd like to eligible for incentives"];
            }
            else if (!self.btnFutureSurvey.isSelected)
            {
                [SVProgressHUD showErrorWithStatus:@"Please check you'd like to more information"];
            }*/
            else
            {
                [postDictionary setObject:txtName.text forKey:@"username"];
                [postDictionary setObject:txtEmail.text forKey:@"emailID"];
                [postDictionary setObject:txtPhone.text forKey:@"phone"];
                
                NSLog(@"Post Dictionary - %@", postDictionary);
                
                [SVProgressHUD showWithStatus:@"Please wait..."];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
                
                [[WebServiceConnector alloc]
                                   init:WSSetSurveyStatistics
                                   withParameters:postDictionary
                                   withObject:self
                                   withSelector:@selector(getSurveyDataResponse:)
                                   forServiceType:@"JSON"
                                   showDisplayMsg:nil];
                
                
               

            }
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"No Internet Connection"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD dismissWithDelay:1.5];
    }
}


#pragma mark - Validate Phone Number

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}


- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Webservice Response Methods

- (IBAction)getSurveyDataResponse:(id)sender
{
    NSDictionary *responseDictionary = [[sender responseDict] valueForKey:@"Result"];
    
    if ([responseDictionary isKindOfClass:[NSNull class]] || responseDictionary == nil)
    {
        [SVProgressHUD showErrorWithStatus:@"Ther e's some issue with Server. Please try again after sometime"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    if ([[responseDictionary valueForKey:@"status"] isEqualToString:@"DONE"] && [[responseDictionary valueForKey:@"error_status"] isEqualToString:@"NO"])
    {
        [SVProgressHUD dismiss];
        dispatch_async(dispatch_get_main_queue(),^
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"resetView" object:nil];
        });
            StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
            [self.navigationController pushViewController:startSurveyVC animated:YES];

//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.blackbookmarketresearch.com/"]])
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.blackbookmarketresearch.com/"]];
//        [[self navigationController] popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - Validation Methods

- (BOOL)isEmailValid:(NSString *)email
{
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_EMAIL];
    BOOL isValid = [emailTest evaluateWithObject:email];
    return isValid;
}

- (BOOL)isNameValid:(NSString *)email
{
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", REGEX_NAME];
    BOOL isValid = [nameTest evaluateWithObject:email];
    return isValid;
}

#pragma mark - Helper Methods

- (void)setupNavigation
{
    self.title = @"Registration";
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnBack;
}

- (IBAction)hideKeyboard:(id)sender
{
    [txtPhone resignFirstResponder];
}

- (IBAction)btnEmailPref:(id)sender {
    
    if(_btnEmailPref.isSelected)
    {
        [_btnEmailPref setSelected:NO];
        [_btnEmailPref setImage:[UIImage imageNamed:@"UnselectedCheckbox"] forState:UIControlStateNormal];
    }
    else
    {
        [_btnEmailPref setSelected:YES];
        [_btnEmailPref setImage:[UIImage imageNamed:@"SelectedCheckbox"] forState:UIControlStateNormal];
    }
    
    [Function setIntegerValueToUserDefaults:([_btnEmailPref isSelected] ? 1 : 0) ForKey:@"isEmail"];
}

- (IBAction)btnTelephonePref:(id)sender {
    if(_btnTelephonePref.isSelected)
    {
        [_btnTelephonePref setSelected:NO];
        [_btnTelephonePref setImage:[UIImage imageNamed:@"UnselectedCheckbox"] forState:UIControlStateNormal];
    }
    else
    {
        [_btnTelephonePref setSelected:YES];
        [_btnTelephonePref setImage:[UIImage imageNamed:@"SelectedCheckbox"] forState:UIControlStateNormal];
    }
    
    [Function setIntegerValueToUserDefaults:([_btnTelephonePref isSelected] ? 1 : 0) ForKey:@"isTelephone"];

}
- (void)saveProfile{
    NSMutableDictionary *postDictionary = [[NSMutableDictionary alloc] init];
    
    [postDictionary setObject:txtName.text forKey:@"username"];
    [postDictionary setObject:txtEmail.text forKey:@"emailID"];
    [postDictionary setObject:txtPhone.text forKey:@"phone"];
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsEditingProfile]){
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kUID] forKey:@"userID"];
    }
    [postDictionary setObject:@"" forKey:@"deviceToken"];
    [postDictionary setObject:kDeviceType forKey:@"deviceType"];
    
      if (!self.isGuest) {
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsGoogleLogin]){
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kFacebookID] forKey:@"googleID"];
        
    }else if ([Function getBooleanValueFromUserDefaults_ForKey:kIsTwitterLogin]){
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kFacebookID] forKey:@"twitterID"];
    }else if ([Function getBooleanValueFromUserDefaults_ForKey:kIsLinkedinLogin]){
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kFacebookID] forKey:@"linkedinID"];
    }else if ([Function getBooleanValueFromUserDefaults_ForKey:kIsAppleLogin]){
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kFacebookID] forKey:@"appleID"];
    }else{
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kFacebookID] forKey:@"facebookID"];
    }
      }
    NSLog(@"Post Dictionary - %@", postDictionary);
    
    if ([[NetworkAvailability instance] isReachable])
    {
        [SVProgressHUD showWithStatus:@"Saving Profile"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        
        [[WebServiceConnector alloc] init:WSSetProfile withParameters:postDictionary withObject:self withSelector:@selector(getSaveProfileResponse:) forServiceType:@"JSON" showDisplayMsg:nil];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"No Internet Connection"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD dismissWithDelay:1.5];
    }
}
#pragma mark - Webservice Response methods

- (IBAction)getSaveProfileResponse:(id)sender
{
    NSDictionary *responseDictionary = [[sender responseDict] valueForKey:@"Result"];
    if ([responseDictionary isKindOfClass:[NSNull class]] || responseDictionary == nil)
    {
        [SVProgressHUD showErrorWithStatus:kIssueWithServer];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    if ([[responseDictionary valueForKey:@"status"] isEqualToString:@"DONE"] && [[responseDictionary valueForKey:@"error_status"] isEqualToString:@"NO"])
    {
        [SVProgressHUD dismiss];
        NSDictionary *userDictionary = [[responseDictionary valueForKey:@"User"] objectAtIndex:0];
        
        [Function setBooleanValueToUserDefaults:YES ForKey:kUserLoggedIn];
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"id"] ForKey:kUID];
        
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"username"] ForKey:kUserName];
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"email_id"] ForKey:kEmail];
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"phone_number"] ForKey:kPhone];
        
        if ([Function getBooleanValueFromUserDefaults_ForKey:kComingFromLogin])
        {
            [Function removeUserDefaultsForKey:kSelectedVendor];
            [Function removeUserDefaultsForKey:kSelectedServices];
            [Function removeUserDefaultsForKey:kSelectedOrganizations];
            [Function removeUserDefaultsForKey:kSelectedRoles];
            
            [Function removeUserDefaultsForKey:kOtherOrgaizationTitle];
            
            [Function removeUserDefaultsForKey:kSelectedVendorID];
            [Function removeUserDefaultsForKey:kSelectedServicesID];
            [Function removeUserDefaultsForKey:kSelectedOrganizationsID];
            [Function removeUserDefaultsForKey:kSelectedRolesID];
            
            [Function removeUserDefaultsForKey:kNotice];
            [Function removeUserDefaultsForKey:kIncentives];
            [Function removeUserDefaultsForKey:kFuture];
            
            [Function removeUserDefaultsForKey:kRenew];
            [Function removeUserDefaultsForKey:kRecommend];
            [Function removeUserDefaultsForKey:kBuyMore];
            
            [Function removeUserDefaultsForKey:kScoreMatrixID];
            
            [Function removeUserDefaultsForKey:@"facebookName"];
            [Function removeUserDefaultsForKey:@"facebookEmail"];
            
            StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
            [self.navigationController pushViewController:startSurveyVC animated:YES];
        }
        else
        {
            StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
            [self.navigationController pushViewController:startSurveyVC animated:YES];
            //[self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
