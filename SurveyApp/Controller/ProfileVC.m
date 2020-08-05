//
//  ProfileVC.m
//  SurveyApp
//
//  Created by C111 on 18/04/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "ProfileVC.h"

#import "StartSurveyVC.h"

#import "NSString+Base64.h"

#define REGEX_EMAIL @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
#define REGEX_NAME @"[A-Za-z ]+"

@interface ProfileVC ()

@end

@implementation ProfileVC

@synthesize txtName, txtEmail, txtPhone;
@synthesize btnSaveProfile;

#pragma mark - View life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    
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
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsEditingProfile] && [Function getBooleanValueFromUserDefaults_ForKey:kUserLoggedIn])
    {
        txtName.text = [Function getStringValueFromUserDefaults_ForKey:kUserName];
        txtEmail.text = [Function getStringValueFromUserDefaults_ForKey:kEmail];
        txtPhone.text = [Function getStringValueFromUserDefaults_ForKey:kPhone];
    }
    else
    {
        txtName.text = [Function getStringValueFromUserDefaults_ForKey:@"facebookName"];
        txtEmail.text = [Function getStringValueFromUserDefaults_ForKey:@"facebookEmail"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action Methods

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSkip:(id)sender
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
    
    StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
    [self.navigationController pushViewController:startSurveyVC animated:YES];
}

- (IBAction)btnSaveProfile:(id)sender
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
    }

    else
    {
        NSMutableDictionary *postDictionary = [[NSMutableDictionary alloc] init];
        
        [postDictionary setObject:txtName.text forKey:@"username"];
        [postDictionary setObject:txtEmail.text forKey:@"emailID"];
        [postDictionary setObject:txtPhone.text forKey:@"phone"];
        
        if ([Function getBooleanValueFromUserDefaults_ForKey:kIsEditingProfile])
            [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kUID] forKey:@"userID"];
        
        [postDictionary setObject:@"" forKey:@"deviceToken"];
        [postDictionary setObject:kDeviceType forKey:@"deviceType"];
       
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
}
#pragma mark - Validate Phone Number

- (BOOL)validatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
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
            
            StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
            [self.navigationController pushViewController:startSurveyVC animated:YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
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
    self.title = @"Profile";
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{NSForegroundColorAttributeName:[UIColor redColor],
//       NSFontAttributeName:[UIFont fontWithName:@"mplus-1c-regular" size:21]}];

    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnBack;
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsEditingProfile] && [Function getBooleanValueFromUserDefaults_ForKey:kComingFromLogin])
    {
        UIBarButtonItem *btnSkip = [[UIBarButtonItem alloc] initWithTitle:@"Skip" style:UIBarButtonItemStylePlain target:self action:@selector(btnSkip:)];
        btnSkip.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = btnSkip;
    }
}

- (IBAction)hideKeyboard:(id)sender
{
    [txtPhone resignFirstResponder];
}

@end
