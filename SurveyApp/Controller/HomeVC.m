//
//  HomeVC.m
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import <GoogleSignIn/GoogleSignIn.h>

#import "HomeVC.h"

#import "ProfileVC.h"
#import "StartSurveyVC.h"
#import "RegistrationVC.h"
#import "PrivacyPolicyVC.h"
#import <LSHeader.h>

@interface HomeVC ()
{
    ACAccountStore *accountStore;
    ACAccount *facebookAccount;
  
//    GPPSignIn * signIn;

    NSString *accessToken;
    LinkedinSwiftHelper *linkedinHelper;
}

@end

@implementation HomeVC

@synthesize btnFacebookLogin, btnGoogleLogin, btnTwitterLogin, btnLinkedinLogin;

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigation];
    linkedinHelper = [[LinkedinSwiftHelper alloc] initWithConfiguration: [[LinkedinSwiftConfiguration alloc] initWithClientId:@"78i3tvz9gostz5" clientSecret:@"1DI6u1EhB2jUq3HJ" state:@"20200511" permissions:@[@"r_liteprofile", @"r_emailaddress"] redirectUrl:@"http://localhost:3000/auth/linkedin/callback"] nativeAppChecker:[[WebLoginOnly alloc] init]];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnFacebookLogin:)];
    tap.numberOfTapsRequired = 1;
    [btnFacebookLogin setUserInteractionEnabled:YES];
    [btnFacebookLogin addGestureRecognizer:tap];

    //Google Button Gesture
    UITapGestureRecognizer *googleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnGoogleLogin:)];
    googleTap.numberOfTapsRequired = 1;
    [btnGoogleLogin setUserInteractionEnabled:YES];
    [btnGoogleLogin addGestureRecognizer:googleTap];
    
    //Twitter Button Gesture
    UITapGestureRecognizer *twitterTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTwitterLogin:)];
    twitterTap.numberOfTapsRequired = 1;
    [btnTwitterLogin setUserInteractionEnabled:YES];
    [btnTwitterLogin addGestureRecognizer:twitterTap];
    
    //Twitter Button Gesture
    UITapGestureRecognizer *linkedinTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnLinkedinLogin:)];
    linkedinTap.numberOfTapsRequired = 1;
    [btnLinkedinLogin setUserInteractionEnabled:YES];
    [btnLinkedinLogin addGestureRecognizer:linkedinTap];
    //  [self facebook];
    
    GIDSignIn* signIn = [GIDSignIn sharedInstance];
//    if (self.fetchEmailToggle.isEnabled) {
        signIn.shouldFetchBasicProfile = YES;
//    }
    signIn.clientID = kClientId;
    signIn.scopes = @[ @"profile", @"email" ];
    signIn.delegate = self;
    signIn.presentingViewController = self;
//    self.statusField.text = @"Initialized auth2...";
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupNavigation];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action Method

- (IBAction)btnGuestLogin:(id)sender
{
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsFacebookLogin];
    
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
    [Function removeUserDefaultsForKey:kIsEditingProfile];
    
    
//    StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
//    [self.navigationController pushViewController:startSurveyVC animated:YES];
    RegistrationVC *registrationVC = iPhoneStoryboard(@"RegistrationVC");
    registrationVC.isGuest = true;
    [self.navigationController pushViewController:registrationVC animated:YES];
}

- (IBAction)btnLinkedinLogin:(id)sender
{
    self.isFb = false;
    
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsGoogleLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsTwitterLogin];
    [Function setBooleanValueToUserDefaults:YES ForKey:kIsLinkedinLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsFacebookLogin];
    
    [linkedinHelper authorizeSuccess:^(LSLinkedinToken * _Nonnull token) {
        [SVProgressHUD showWithStatus:@"Fetching Data"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [self->linkedinHelper requestURL:@"https://api.linkedin.com/v2/me?projection=(id,localizedFirstName,localizedLastName)" requestType:LinkedinSwiftRequestGet success:^(LSResponse * _Nonnull response) {
            NSString *firstName = response.jsonObject[@"localizedFirstName"];
            NSString *lastName = response.jsonObject[@"localizedLastName"];
            NSString *linkedinID = response.jsonObject[@"id"];
            
            [self->linkedinHelper requestURL:@"https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))" requestType:LinkedinSwiftRequestGet success:^(LSResponse * _Nonnull response) {
                [SVProgressHUD dismiss];
                NSString *email = response.jsonObject[@"elements"][0][@"handle~"][@"emailAddress"];
                
                [Function setStringValueToUserDefaults:email ForKey:@"facebookEmail"];
                [Function setStringValueToUserDefaults:[NSString stringWithFormat:@"%@ %@", firstName, lastName] ForKey:@"facebookName"];
                [Function setStringValueToUserDefaults:linkedinID ForKey:kFacebookID];
                
                NSMutableDictionary *postDictionary = [NSMutableDictionary new];
                
                [postDictionary setObject:linkedinID forKey:@"facebookID"];
                                
                if ([[NetworkAvailability instance] isReachable])
                {
                    [[WebServiceConnector alloc] init:WSCheckExistingUser withParameters:postDictionary withObject:self withSelector:@selector(getCheckExistingUserResponse:) forServiceType:@"JSON" showDisplayMsg:nil];
                }
                
            }error:^(NSError * _Nonnull error) {
                NSLog(@"Error %@", error.debugDescription);
                [SVProgressHUD dismiss];
            }];
        } error:^(NSError * _Nonnull error) {
            NSLog(@"Error %@", error.debugDescription);
            [SVProgressHUD dismiss];
        }];
    } error:^(NSError * _Nonnull error) {
        NSLog(@"Error %@", error.debugDescription);
    } cancel:^{
        NSLog(@"Cancel");
    }];
}

- (IBAction)btnFacebookLogin:(id)sender
{
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsGoogleLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsTwitterLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsLinkedinLogin];
    [Function setBooleanValueToUserDefaults:YES ForKey:kIsFacebookLogin];

    self.isFb = true;
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logInWithPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {

        if (error)
        {
            NSLog(@"Facebook - Process error");
        }
        else if (result.isCancelled)
        {
            NSLog(@"Facebook - Cancelled");
        }
        else
        {
            [SVProgressHUD showWithStatus:@"Fetching Data"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            
            FBSDKGraphRequest *requestMe = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:[NSDictionary dictionaryWithObject:@"id,email,name,picture.type(large)" forKey:@"fields"]];
            
            FBSDKGraphRequestConnection *connection = [[FBSDKGraphRequestConnection alloc] init];
            
            [connection addRequest:requestMe completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
            {
                if (result)
                {
                    [SVProgressHUD dismiss];
                    
                    if ([result objectForKey:@"id"])
                        [Function setStringValueToUserDefaults:[result objectForKey:@"id"] ForKey:kFacebookID];
                    
                    NSMutableDictionary *postDictionary = [NSMutableDictionary new];
                    [postDictionary setObject:[result objectForKey:@"id"] forKey:@"facebookID"];
                    
                    if ([result objectForKey:@"name"])
                        [Function setStringValueToUserDefaults:[result objectForKey:@"name"] ForKey:@"facebookName"];
                    
                    if ([result objectForKey:@"email"])
                        [Function setStringValueToUserDefaults:[result objectForKey:@"email"] ForKey:@"facebookEmail"];
                    
                    if ([[NetworkAvailability instance] isReachable])
                    {
                        [[WebServiceConnector alloc] init:WSCheckExistingUser withParameters:postDictionary withObject:self withSelector:@selector(getCheckExistingUserResponse:) forServiceType:@"JSON" showDisplayMsg:nil];
                    }
                }
            }];
            
            [connection start];
        }
    }];
}
- (IBAction)btnGoogleLogin:(id)sender
{
    [Function setBooleanValueToUserDefaults:YES ForKey:kIsGoogleLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsTwitterLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsLinkedinLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsFacebookLogin];

    [[GIDSignIn sharedInstance] signIn];
    
//    if ([[GPPSignIn sharedInstance] authentication]) {
//        return;
//    }

    [SVProgressHUD show];
//    signIn = [GPPSignIn sharedInstance];
//    self.isFb = false;
//    signIn.shouldFetchGooglePlusUser = YES;
//    signIn.shouldFetchGoogleUserEmail = YES;
//    
//    signIn.clientID = kClientId;
//    
//    signIn.scopes = @[@"profile"];
//    
//    signIn.delegate = self;
//    
//    [signIn authenticate];
}
- (IBAction)btnTwitterLogin:(id)sender
{
    self.isFb = false;
    
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsGoogleLogin];
    [Function setBooleanValueToUserDefaults:YES ForKey:kIsTwitterLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsLinkedinLogin];
    [Function setBooleanValueToUserDefaults:NO ForKey:kIsFacebookLogin];
    
    [[FHSTwitterEngine sharedEngine]permanentlySetConsumerKey:@"p3synMX4pCPc2Bp7eTqs5wuWG" andSecret:@"ifpaPJZFinCuxstx8GTsr43WH3kYkwxitz6VFbcKZg1NzOH6Qx"];
    [[FHSTwitterEngine sharedEngine]setDelegate:self];
    UIViewController *loginController = [[FHSTwitterEngine sharedEngine]loginControllerWithCompletionHandler:^(BOOL success) {
        NSLog(success?@"L0L success":@"O noes!!! Loggen faylur!!!");
        NSString *ID = [[FHSTwitterEngine sharedEngine]authenticatedID];// self.engine.loggedInUsername;
        NSString *userName = [[FHSTwitterEngine sharedEngine]authenticatedUsername];// self.engine.loggedInUsername;
        NSLog(@"Login user : %@",userName);
        if (success) {
            [SVProgressHUD show];
            if (ID.length > 0) {
                NSString *userID = [NSString stringWithFormat:@"%@",ID];
                [Function setStringValueToUserDefaults:ID ForKey:kFacebookID];
                NSLog(@"%@",userID);
            }
            
                NSMutableDictionary *postDictionary = [NSMutableDictionary new];
                [postDictionary setObject:ID forKey:@"twitterID"];
                
            if (userName.length > 0) {
                    [Function setStringValueToUserDefaults:userName ForKey:@"facebookName"];
            }
            
                [Function setStringValueToUserDefaults:@"" ForKey:@"facebookEmail"];
            
                if ([[NetworkAvailability instance] isReachable])
                {
                    [[WebServiceConnector alloc] init:WSCheckExistingUser withParameters:postDictionary withObject:self withSelector:@selector(getCheckExistingUserResponse:) forServiceType:@"JSON" showDisplayMsg:nil];
                }
        }
        if (ID.length > 0) {
            NSString *userID = [NSString stringWithFormat:@"%@",ID];
            NSLog(@"%@",userID);
        }
        else
        {
            NSLog(@"Not Logged In");
        }
        NSLog(success?@"L0L success":@"O noes!!! Log in failure!!!");
    }];
    [self presentViewController:loginController animated:YES completion:nil];
}

- (IBAction)privacyPolicyAndTearmsOfUse:(id)sender
{
    UIButton *button = (UIButton*)sender;
    PrivacyPolicyVC *privacyPolicyVC = iPhoneStoryboard(@"PrivacyPolicyVC");
    if ([button.currentTitle isEqualToString:@"PRIVACY POLICY"]) {
    }else{
        
    }
    privacyPolicyVC.strTitle = button.currentTitle;
    [self.navigationController pushViewController:privacyPolicyVC animated:YES];

}
#pragma mark - Webservice Response Methods

- (IBAction)getCheckExistingUserResponse:(id)sender
{
    NSDictionary *responseDictionary = [[sender responseDict] valueForKey:@"Result"];
    NSLog(@"%@",responseDictionary);
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
        
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"username"] ForKey:kUserName];
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"email_id"] ForKey:kEmail];
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"phone_number"] ForKey:kPhone];
        [Function setStringValueToUserDefaults:[userDictionary valueForKey:@"id"] ForKey:kUID];
        
        [Function setBooleanValueToUserDefaults:YES ForKey:kUserLoggedIn];
        
        [Function setBooleanValueToUserDefaults:YES ForKey:kIsEditingProfile];
        [Function setBooleanValueToUserDefaults:YES ForKey:kComingFromLogin];
        
        StartSurveyVC *startSurveyVC = iPhoneStoryboard(@"StartSurveyVC");
        [self.navigationController pushViewController:startSurveyVC animated:YES];

    }
    else
    {
        [Function setBooleanValueToUserDefaults:NO ForKey:kIsEditingProfile];
        [Function setBooleanValueToUserDefaults:YES ForKey:kComingFromLogin];
        
        
        RegistrationVC *registrationVC = iPhoneStoryboard(@"RegistrationVC");
        registrationVC.isGuest = false;
        registrationVC.isCompleteProfile = true;
        [self.navigationController pushViewController:registrationVC animated:YES];
        
//        if (self.isFb) {
//            ProfileVC *profileVc = iPhoneStoryboard(@"ProfileVC");
//            [self.navigationController pushViewController:profileVc animated:YES];
//        }else{
//            ProfileVC *profileVc = iPhoneStoryboard(@"ProfileVC");
//            [self.navigationController pushViewController:profileVc animated:YES];
//          //  RegistrationVC *registrationVC = iPhoneStoryboard(@"RegistrationVC");
//            //registrationVC.isGuest = false;
//            //[self.navigationController pushViewController:registrationVC animated:YES];
       // }
    }
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
}

#pragma mark ::
#pragma mark - Google Plus Delegates
#pragma mark ::
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    if(error){
        
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        
    }else{
        
        NSLog(@"signIn: %@", signIn);
        NSLog(@"user: %@", user);

        NSString * fullName;
        
        if ([user.profile.familyName isEqualToString:@""] || user.profile.familyName == nil) {
            fullName = user.profile.givenName;
            [Function setStringValueToUserDefaults:fullName ForKey:@"facebookName"];
        }
        else{
            fullName = [NSString stringWithFormat:@"%@ %@",user.profile.givenName,user.profile.familyName];
            [Function setStringValueToUserDefaults:fullName ForKey:@"facebookName"];
            
        }
//        NSString *newString = [images.url stringByReplacingOccurrencesOfString:@"sz=50" withString:@"sz=500"];
//        NSLog(@"New String %@",newString);
        
        NSString * emailString = user.profile.email;
        
        NSMutableDictionary *dictResponse = [[NSMutableDictionary alloc]init];
        if (![user.profile.familyName isEqualToString:@""] && user.profile.familyName != nil) {
            [dictResponse setObject:user.profile.familyName forKey:@"last_name"];
        }
        if (![user.profile.givenName isEqualToString:@""] && user.profile.givenName != nil) {
            [dictResponse setObject:user.profile.givenName forKey:@"first_name"];
        }
//        if (![person.gender isEqualToString:@""] && person.gender != nil) {
//            [dictResponse setObject:person.gender forKey:@"gender"];
//        }
        if (![emailString isEqualToString:@""] && emailString != nil) {
            [dictResponse setObject:emailString forKey:@"email"];
        }
        
        [Function setStringValueToUserDefaults:emailString ForKey:@"facebookEmail"];
        [dictResponse setObject:user.userID forKey:@"id"];
        
        if (user.profile.hasImage){
            [dictResponse setObject:[user.profile imageURLWithDimension:500] forKey:@"image_url"];
        }
//        if (signIn.authentication.userID.length > 0) {
//            NSString *userID = [NSString stringWithFormat:@"%@",signIn.authentication.userID];
//            NSLog(@"%@",userID);
//        }
        
        NSMutableDictionary *postDictionary = [NSMutableDictionary new];
        [Function setStringValueToUserDefaults:user.userID ForKey:kFacebookID];
        
        [postDictionary setObject:user.userID forKey:@"googleID"];
        
        if (user.profile.givenName.length > 0) {
            [Function setStringValueToUserDefaults:user.profile.givenName ForKey:@"facebookName"];
        }
        
        if ([[NetworkAvailability instance] isReachable])
        {
            [[WebServiceConnector alloc] init:WSCheckExistingUser withParameters:postDictionary withObject:self withSelector:@selector(getCheckExistingUserResponse:) forServiceType:@"JSON" showDisplayMsg:nil];
        }
        
        
    }
    
}
- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
//    self.statusField.text = @"Disconnected user";
}

@end
