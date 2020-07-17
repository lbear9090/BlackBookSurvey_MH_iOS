//
//  SubmitVC.m
//  SurveyApp
//
//  Created by Harsh on 15/12/17.
//  Copyright © 2017 C111. All rights reserved.
//

#import "SubmitVC.h"
#import "StartSurveyVC.h"
#import "ExpandableTableVC.h"

#import "ExitVC.h"

@interface SubmitVC ()

@end

@implementation SubmitVC
{
    NSMutableArray *arrPreferences, *arrPreferencesID;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigation];
    arrPreferences = [[NSMutableArray alloc] init];
    arrPreferencesID = [[NSMutableArray alloc] init];
}
-(void)viewWillAppear:(BOOL)animated{
    
    arrPreferences = [[CoreDataAdaptor fetchPreferencesFromCoreData:nil] mutableCopy];
    
    [self.navigationItem setHidesBackButton:YES];
    
    for (CDPreferences *preferences in arrPreferences)
    {
        if ([preferences.preferenceText containsString:kNotice])
        
        
        [arrPreferencesID addObject:preferences.preferenceId];
    }

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupNavigation
{
    self.title = kApplicationName;
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationItem.hidesBackButton = YES;

    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
   //self.navigationItem.leftBarButtonItem = nil;
}
- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)sumbitbtn:(id)sender {
    
    [SVProgressHUD show];
    
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
        [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kSelectedRatingID] forKey:@"rate_id"];
        
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
       // if ([Function getBooleanValueFromUserDefaults_ForKey:kIsFacebookLogin] || [Function getBooleanValueFromUserDefaults_ForKey:kIsGoogleLogin] || [Function getBooleanValueFromUserDefaults_ForKey:kIsTwitterLogin])
       // {
            if ([Function getStringValueFromUserDefaults_ForKey:kUID].length > 0) {
                [postDictionary setObject:[Function getStringValueFromUserDefaults_ForKey:kUID] forKey:@"userID"];
            }
            
            NSLog(@"Post Dictionary - %@", postDictionary);
            
            [SVProgressHUD showWithStatus:@"Please wait..."];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            
            [[WebServiceConnector alloc] init:WSSetSurveyStatisticsForUser withParameters:postDictionary withObject:self withSelector:@selector(getSurveyDataResponse:) forServiceType:@"JSON" showDisplayMsg:nil];
        //}
    }else{
        
             [self performSelector:@selector(hideHudFromViewWithStringError:) withObject:@"There's some issue with Internet connection. Please try again after sometime" afterDelay:1.0];
    }
    
}
#pragma mark - Webservice Response Methods
-(void)hideHudFromViewWithStringError:(NSString *)string{
    [SVProgressHUD showErrorWithStatus:string];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD dismissWithDelay:1.5];
}
-(void)hideHudFromViewWithStringSucess:(NSString *)string{
    [SVProgressHUD showSuccessWithStatus:string];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD dismissWithDelay:1.5];
}

- (void)getSurveyDataResponse:(id)sender
    {
        NSDictionary *responseDictionary = [[sender responseDict] valueForKey:@"Result"];
        
        NSLog(@"responseDictionary = %@",responseDictionary);
        
        
        if ([responseDictionary isKindOfClass:[NSNull class]] || responseDictionary == nil)
        {
            [SVProgressHUD show];
            [self performSelector:@selector(hideHudFromViewWithStringError:) withObject:@"There's some issue with Server. Please try again after sometime" afterDelay:1.0];
            return;
          
            
        }
        
        if ([[responseDictionary valueForKey:@"status"] isEqualToString:@"DONE"] && [[responseDictionary valueForKey:@"error_status"] isEqualToString:@"NO"])
        {
           
                
                dispatch_async(dispatch_get_main_queue(),^
                               {
              [SVProgressHUD show];
          [self performSelector:@selector(hideHudFromViewWithStringSucess:) withObject:@"Your survey has already been submitted. thank you" afterDelay:0];

                                   
                                   [[NSNotificationCenter defaultCenter] postNotificationName:@"resetView" object:nil];
                                  
                                   double delayInSeconds = 1.6;
                                   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                                   dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                       
                                       ExitVC *exVC = iPhoneStoryboard(@"ExitVC");
                                       [self.navigationController pushViewController:exVC animated:YES];
                                   });
                                  

                               });
            
            
          
            //        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.blackbookmarketresearch.com/"]])
            //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.blackbookmarketresearch.com/"]];
            //        [[self navigationController] popToRootViewControllerAnimated:NO];
        }
        else{
             [SVProgressHUD dismiss];
        }
    }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
