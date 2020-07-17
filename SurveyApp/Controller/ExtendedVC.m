//
//  ExtendedVC.m
//  SurveyApp
//
//  Created by C111 on 11/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "ExtendedVC.h"

#import "HomeVC.h"
#import "StartSurveyVC.h"

#import "CSVParser.h"

@interface ExtendedVC ()

@end

@implementation ExtendedVC

#pragma mark - View life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"Documents Directory - %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSGetPredefinedData withParameters:nil withObject:self withSelector:@selector(getPredefinedDataResponse:) forServiceType:@"POST" showDisplayMsg:nil];
            
            if (![Function getBooleanValueFromUserDefaults_ForKey:kFirstRun])
            {
                NSLog(@"Not First");
                dispatch_sync(dispatch_get_main_queue(), ^
                {
                    [self showHome];
                });
            }
        }
        else
        {
            if (![Function getBooleanValueFromUserDefaults_ForKey:kServicesParsed])
            {
                [CSVParser parseCSVFileForType:kServices];
                [Function setBooleanValueToUserDefaults:YES ForKey:kServicesParsed];
            }
            
            if (![Function getBooleanValueFromUserDefaults_ForKey:kVendorsParsed])
            {
                [CSVParser parseCSVFileForType:kVendors];
                [Function setBooleanValueToUserDefaults:YES ForKey:kVendorsParsed];
            }
            
            if (![Function getBooleanValueFromUserDefaults_ForKey:kOrganizationsParsed])
            {
                [CSVParser parseCSVFileForType:kOrganizations];
                [Function setBooleanValueToUserDefaults:YES ForKey:kOrganizationsParsed];
            }
            
            if (![Function getBooleanValueFromUserDefaults_ForKey:kRolesParsed])
            {
                [CSVParser parseCSVFileForType:kRoles];
                [Function setBooleanValueToUserDefaults:YES ForKey:kRolesParsed];
            }
            if (![Function getBooleanValueFromUserDefaults_ForKey:kRatingParsed])
            {
                [CSVParser parseCSVFileForType:kRating];
                [Function setBooleanValueToUserDefaults:YES ForKey:kRatingParsed];
            }
            if (![Function getBooleanValueFromUserDefaults_ForKey:kPreferencesParsed])
            {
                [CSVParser parseCSVFileForType:kPreferences];
                [Function setBooleanValueToUserDefaults:YES ForKey:kPreferencesParsed];
            }
            
            if (![Function getBooleanValueFromUserDefaults_ForKey:kQuestionsParsed])
            {
                [CSVParser parseCSVFileForType:kQuestions];
                [Function setBooleanValueToUserDefaults:YES ForKey:kQuestionsParsed];
            }
            
            if (![Function getBooleanValueFromUserDefaults_ForKey:kScoreMatrixParsed])
            {
                [CSVParser parseCSVFileForType:kScoreMatrix];
                [Function setBooleanValueToUserDefaults:YES ForKey:kScoreMatrixParsed];
            }
            
            dispatch_sync(dispatch_get_main_queue(), ^
            {
                [self showHome];
            });
        }
    }
                   );
    
    /* dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSGetSurveyType withParameters:nil withObject:self withSelector:@selector(getSurveyTypeResponse:) forServiceType:@"POST" showDisplayMsg:nil];
        }
        else
        {
            if (![Function getBooleanValueFromUserDefaults_ForKey:kServicesParsed])
            {
                [CSVParser parseCSVFileForType:kServices];
                [Function setBooleanValueToUserDefaults:YES ForKey:kServicesParsed];
            }
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSGetVendors withParameters:nil withObject:self withSelector:@selector(getVendorsResponse:) forServiceType:@"POST" showDisplayMsg:nil];
        }
        else
        {
            if (![Function getBooleanValueFromUserDefaults_ForKey:kVendorsParsed])
            {
                [CSVParser parseCSVFileForType:kVendors];
                [Function setBooleanValueToUserDefaults:YES ForKey:kVendorsParsed];
            }
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSGetOrganizationType withParameters:nil withObject:self withSelector:@selector(getOrganizationTypeResponse:) forServiceType:@"POST" showDisplayMsg:nil];
        }
        else
        {
            if (![Function getBooleanValueFromUserDefaults_ForKey:kOrganizationsParsed])
            {
                [CSVParser parseCSVFileForType:kOrganizations];
                [Function setBooleanValueToUserDefaults:YES ForKey:kOrganizationsParsed];
            }
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSGetRoles withParameters:nil withObject:self withSelector:@selector(getRolesResponse:) forServiceType:@"POST" showDisplayMsg:nil];
        }
        else
        {
            if (![Function getBooleanValueFromUserDefaults_ForKey:kRolesParsed])
            {
                [CSVParser parseCSVFileForType:kRoles];
                [Function setBooleanValueToUserDefaults:YES ForKey:kRolesParsed];
            }
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSGetScoreMatrix withParameters:nil withObject:self withSelector:@selector(getScoreMatrixResponse:) forServiceType:@"POST" showDisplayMsg:nil];
        }
        
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSGetPreferences withParameters:nil withObject:self withSelector:@selector(getPreferencesResponse:) forServiceType:@"POST" showDisplayMsg:nil];
        }
    });
    
    if ([[NetworkAvailability instance] isReachable])
    {
        [[WebServiceConnector alloc] init:WSGetKeyQuestions withParameters:nil withObject:self withSelector:@selector(getKeyQuestions:) forServiceType:@"POST" showDisplayMsg:nil];
    }
    
    if ([[NetworkAvailability instance] isReachable])
    {
        [[WebServiceConnector alloc] init:WSGetLoyaltyQuestions withParameters:nil withObject:self withSelector:@selector(getLoyaltyQuestions:) forServiceType:@"POST" showDisplayMsg:nil];
    } */
}

- (void)showHome
{
    if ([Function getBooleanValueFromUserDefaults_ForKey:kUserLoggedIn])
    {
        [Function removeUserDefaultsForKey:kSelectedVendor];
        [Function removeUserDefaultsForKey:kSelectedServices];
        [Function removeUserDefaultsForKey:kSelectedOrganizations];
        [Function removeUserDefaultsForKey:kSelectedRoles];
        [Function removeUserDefaultsForKey:kSelectedRatings];

        [Function removeUserDefaultsForKey:kOtherOrgaizationTitle];
        
        [Function removeUserDefaultsForKey:kSelectedVendorID];
        [Function removeUserDefaultsForKey:kSelectedServicesID];
        [Function removeUserDefaultsForKey:kSelectedOrganizationsID];
        [Function removeUserDefaultsForKey:kSelectedRolesID];
        [Function removeUserDefaultsForKey:kSelectedRatingID];

        [Function removeUserDefaultsForKey:kNotice];
        [Function removeUserDefaultsForKey:kIncentives];
        [Function removeUserDefaultsForKey:kFuture];
        
        [Function removeUserDefaultsForKey:kRenew];
        [Function removeUserDefaultsForKey:kRecommend];
        [Function removeUserDefaultsForKey:kBuyMore];
        
        [Function removeUserDefaultsForKey:kScoreMatrixID];
        
        StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:startSurveyVC animated:NO];
    }
    else
    {
        [Function removeUserDefaultsForKey:kIsFacebookLogin];
        
        HomeVC *homeVC = iPhoneStoryboard(@"HomeVC");
        self.navigationController.navigationBarHidden = NO;
        [self.navigationController pushViewController:homeVC animated:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Webservice Response Methods

- (IBAction)getPredefinedDataResponse:(id)sender
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
        if ([Function getBooleanValueFromUserDefaults_ForKey:kFirstRun])
        {
            NSLog(@"First");
            [self showHome];
            [Function setBooleanValueToUserDefaults:NO ForKey:kFirstRun];
        }
    }
}

@end
