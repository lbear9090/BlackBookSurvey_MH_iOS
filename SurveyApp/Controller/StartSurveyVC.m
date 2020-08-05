//
//  StartSurveyVC.m
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "StartSurveyVC.h"

#import "ExpandableTableVC.h"
#import "ScoringKeyVC.h"
#import "QuestionsVC.h"
#import "VendorVC.h"

#import "HomeVC.h"
#import "ProfileVC.h"

#import "MISDropdownMenuView.h"
#import "MISDropdownViewController.h"
//#import <GooglePlus/GooglePlus.h>
#import "FHSTwitterEngine.h"

@interface StartSurveyVC ()
{
    UIBarButtonItem *settingsItem;
    NSInteger selectedIndex;
}

@end

@implementation StartSurveyVC

@synthesize lblOrganization, lblRole, lblService, lblVendor;
@synthesize btnOrganization, btnRole, btnService, btnVendor, btnRating;
@synthesize dropdownViewController, dropdownMenuView;

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    [Function removeUserDefaultsForKey:kSelectedRatingID];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetView) name:@"resetView" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavigation];
    [self setupTitles];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    int height = self.view.frame.size.height + 50;
    self.scrollView.contentSize = CGSizeMake(0, height);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma MailComposer Delegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
            
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
            
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
            
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
            
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Button Action Methods

- (IBAction)btnService:(id)sender
{
    [Function setStringValueToUserDefaults:kComingFromService ForKey:kComingFrom];
    
    ExpandableTableVC *expandableVC = iPhoneStoryboard(@"ExpandableTableVC");
    [self.navigationController pushViewController:expandableVC animated:YES];
}

- (IBAction)btnVendor:(id)sender
{
    VendorVC *vendorVC = iPhoneStoryboard(@"VendorVC");
    [self.navigationController pushViewController:vendorVC animated:YES];
}

- (IBAction)btnOrganization:(id)sender
{
    [Function setStringValueToUserDefaults:kComingFromOrganization ForKey:kComingFrom];
    
    ExpandableTableVC *expandableVC = iPhoneStoryboard(@"ExpandableTableVC");
    [self.navigationController pushViewController:expandableVC animated:YES];
}

- (IBAction)btnRole:(id)sender
{
    [Function setStringValueToUserDefaults:kComingFromRole ForKey:kComingFrom];
    
    ExpandableTableVC *expandableVC = iPhoneStoryboard(@"ExpandableTableVC");
    [self.navigationController pushViewController:expandableVC animated:YES];
}
- (IBAction)btnRating:(id)sender
{
    [Function setStringValueToUserDefaults:kComingFromRting ForKey:kComingFrom];
    
    ExpandableTableVC *expandableVC = iPhoneStoryboard(@"ExpandableTableVC");
    [self.navigationController pushViewController:expandableVC animated:YES];
}

- (IBAction)btnStartSurvey:(id)sender
{
    /* QuestionsVC *questionsVC = iPhoneStoryboard(@"QuestionsVC");
     [self.navigationController pushViewController:questionsVC animated:YES];
     return; */

    
    NSString *strVendor = [Function getStringValueFromUserDefaults_ForKey:kSelectedVendor];
    NSString *strService = [Function getStringValueFromUserDefaults_ForKey:kSelectedServices];
    NSString *strOrganization = [Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizations];
    NSString *strRole = [Function getStringValueFromUserDefaults_ForKey:kSelectedRoles];
    NSString *strRating = [Function getStringValueFromUserDefaults_ForKey:kSelectedRatings];

    if ([Function stringIsEmpty:strService])
    {
        [SVProgressHUD showInfoWithStatus:@"Please select Service"];
    }
    else if ([Function stringIsEmpty:strVendor])
    {
        [SVProgressHUD showInfoWithStatus:@"Please select Vendor"];
    }
    else if ([Function stringIsEmpty:strOrganization])
    {
        [SVProgressHUD showInfoWithStatus:@"Please select Organization"];
    }
    else if ([Function stringIsEmpty:strRole])
    {
        [SVProgressHUD showInfoWithStatus:@"Please select Role"];
    }
    else if ([Function stringIsEmpty:strRating])
    {
        [SVProgressHUD showInfoWithStatus:@"Please select Rating"];
    }
    else
    {
        
        dispatch_async( dispatch_get_main_queue(), ^
                       {
                           QuestionsVC *questionsVC = iPhoneStoryboard(@"QuestionsVC");
                           [self.navigationController pushViewController:questionsVC animated:YES];
                       });
        /*
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
                QuestionsVC *questionsVC = iPhoneStoryboard(@"QuestionsVC");
                [self.navigationController pushViewController:questionsVC animated:YES];
            });
        });*/
    }
}

- (void)resetView
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
    [Function removeUserDefaultsForKey:@"facebookName"];
    [Function removeUserDefaultsForKey:@"facebookEmail"];


    [self setupTitles];
}

#pragma mark - Dropdown Menu Methods

- (void)dropMenuChanged:(MISDropdownMenuView *)dropDownMenuView
{
    selectedIndex = [dropDownMenuView selectedItemIndex];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
    {
        switch (selectedIndex)
        {
            case 0:
            {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kScoringKeyURL]])
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kScoringKeyURL]];
            }
                break;
                
            case 1:
            {
                ScoringKeyVC *scoringKeyVC = iPhoneStoryboard(@"ScoringKeyVC");
                [self.navigationController pushViewController:scoringKeyVC animated:YES];
            }
                break;
                
            case 2:
            {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:kVendorsURL]])
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kVendorsURL]];
            }
                break;
                
            case 3:
            {
                if ([Function getBooleanValueFromUserDefaults_ForKey:kIsFacebookLogin] ||[Function getBooleanValueFromUserDefaults_ForKey:kIsGoogleLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsTwitterLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsLinkedinLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsAppleLogin] )

                {
                    [Function setBooleanValueToUserDefaults:YES ForKey:kIsEditingProfile];
                    [Function setBooleanValueToUserDefaults:NO ForKey:kComingFromLogin];
                    
                    ProfileVC *profileVC = iPhoneStoryboard(@"ProfileVC");
                    [self.navigationController pushViewController:profileVC animated:YES];
                }
                else
                {
                    if ([MFMailComposeViewController canSendMail])
                    {
                        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                        mail.mailComposeDelegate = self;
                        [mail setSubject:@"Feedback for Black Book Survey App"];
                        [mail setToRecipients:@[@"info@brown-wilson.com"]];
                        
                        [self presentViewController:mail animated:YES completion:NULL];
                    }
                    else
                    {
                        [SVProgressHUD showInfoWithStatus:@"This device does not support sending mails"];
                    }
                }
            }
                break;
                
            case 4:
            {
                if ([MFMailComposeViewController canSendMail])
                {
                    MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
                    mail.mailComposeDelegate = self;
                    [mail setSubject:@"Feedback for Black Book Survey App"];
                    [mail setToRecipients:@[@"info@brown-wilson.com"]];
                    
                    [self presentViewController:mail animated:YES completion:NULL];
                }
                else
                {
                    [SVProgressHUD showInfoWithStatus:@"This device does not support sending mails"];
                }
            }
                break;
                
            case 5:
            {
                FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
                
//                if ([[GPPSignIn sharedInstance] authentication]) {
//                    GPPSignIn* signIn = [GPPSignIn sharedInstance];
//                    [signIn signOut];
//                    [Function removeUserDefaultsForKey:kUID];
//                    [Function removeUserDefaultsForKey:kUserLoggedIn];
//                    
//                    [SVProgressHUD dismiss];
//                    dispatch_async(dispatch_get_main_queue(),^
//                                   {
//                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"resetView" object:nil];
//                                   });
//                    
//                    
//                }
               
                if ([[FHSTwitterEngine sharedEngine]accessToken]) {
                   
                    [[FHSTwitterEngine sharedEngine]clearConsumer];
                    [[FHSTwitterEngine sharedEngine]clearAccessToken];
                    [Function removeUserDefaultsForKey:kUID];
                    [Function removeUserDefaultsForKey:kUserLoggedIn];
                    
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(),^
                                   {
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"resetView" object:nil];
                                   });
                    
                 
                }
                
                if ([FBSDKAccessToken currentAccessToken])
                {
                    [loginManager logOut];
                    
                    [SVProgressHUD dismiss];
                    dispatch_async(dispatch_get_main_queue(),^
                                   {
                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"resetView" object:nil];
                                   });
                    
                    [Function removeUserDefaultsForKey:kUID];
                    [Function removeUserDefaultsForKey:kUserLoggedIn];
                    
                    HomeVC *homeVC = iPhoneStoryboard(@"HomeVC");
                    [self.navigationController pushViewController:homeVC animated:NO];
                }
                
                HomeVC *homeVC = iPhoneStoryboard(@"HomeVC");
                [self.navigationController pushViewController:homeVC animated:NO];
                
            }
                break;
                
            default:
                break;
        }
        
        [self.dropdownViewController dismissDropdownAnimated:YES];
    });
}

- (void)toggleMenu:(id)sender
{
    dropdownMenuView.selectedItemIndex = 1;
    selectedIndex = 1;
    
    if (dropdownViewController == nil)
    {
        // Prepare content view
        CGFloat width = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 320.0 : self.view.bounds.size.width;
        CGSize size = [dropdownMenuView sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
        dropdownMenuView.frame = CGRectMake(dropdownMenuView.frame.origin.x, dropdownMenuView.frame.origin.y, size.width, size.height+20);
        
        dropdownViewController = [[MISDropdownViewController alloc] initWithPresentationMode:MISDropdownViewControllerPresentationModeAutomatic];
        dropdownViewController.contentView = dropdownMenuView;
    }
    
    // Show/hide dropdown view
    if ([dropdownViewController isDropdownVisible])
    {
        [dropdownViewController dismissDropdownAnimated:YES];
        return;
    }
    
    // Sender is UIBarButtonItem
    if ([sender isKindOfClass:[UIBarButtonItem class]])
    {
        [dropdownViewController presentDropdownFromBarButtonItem:sender inViewController:self position:MISDropdownViewControllerPositionTop];
        return;
    }
    
    // Sender is UIButton
    [dropdownViewController presentDropdownFromBarButtonItem:self.navigationItem.leftBarButtonItem inViewController:self position:MISDropdownViewControllerPositionTop];
}

#pragma mark - Helper Methods

- (void)setupNavigation
{
    self.title = kApplicationName;
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.hidesBackButton = YES;
    
    UIBarButtonItem *btnSettings = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Settings"] style:UIBarButtonItemStyleDone target:self action:@selector(toggleMenu:)];
    btnSettings.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnSettings;
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsFacebookLogin] ||[Function getBooleanValueFromUserDefaults_ForKey:kIsGoogleLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsTwitterLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsLinkedinLogin]||[Function getBooleanValueFromUserDefaults_ForKey:kIsAppleLogin] )

        dropdownMenuView = [[MISDropdownMenuView alloc] initWithItems:@[@"Key Performance Indicators", @"Scoring Keys", @"Vendors", @"Edit Profile", @"Support", @"Logout"]];
    else
        dropdownMenuView = [[MISDropdownMenuView alloc] initWithItems:@[@"Key Performance Indicators", @"Scoring Keys", @"Vendors", @"Support"]];
    
    dropdownMenuView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [dropdownMenuView addTarget:self action:@selector(dropMenuChanged:) forControlEvents:UIControlEventValueChanged];
    
    [dropdownMenuView setSelectedItemIndex:0];
    
    if ([Function getBooleanValueFromUserDefaults_ForKey:kIsFacebookLogin])
        [self.navigationController setViewControllers:[NSArray arrayWithObject:self] animated:YES];
}

- (void)setupTitles
{
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedVendor])
        [btnVendor setTitle:[Function getStringValueFromUserDefaults_ForKey:kSelectedVendor] forState:UIControlStateNormal];
    else
        [btnVendor setTitle:@"Select Vendor" forState:UIControlStateNormal];
    
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedServices])
        [btnService setTitle:[Function getStringValueFromUserDefaults_ForKey:kSelectedServices] forState:UIControlStateNormal];
    else
        [btnService setTitle:@"Select Service" forState:UIControlStateNormal];
    
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizations])
        [btnOrganization setTitle:[Function getStringValueFromUserDefaults_ForKey:kSelectedOrganizations] forState:UIControlStateNormal];
    else
        [btnOrganization setTitle:@"Select Organization" forState:UIControlStateNormal];
    
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedRoles])
        [btnRole setTitle:[Function getStringValueFromUserDefaults_ForKey:kSelectedRoles] forState:UIControlStateNormal];
    else
        [btnRole setTitle:@"Select Role" forState:UIControlStateNormal];
    
    
    if ([Function getStringValueFromUserDefaults_ForKey:kSelectedRatings])
        [btnRating setTitle:[Function getStringValueFromUserDefaults_ForKey:kSelectedRatings] forState:UIControlStateNormal];
    else
        [btnRating setTitle:@"Select Rating" forState:UIControlStateNormal];
}

@end
