//
//  HomeVC.h
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <GooglePlus/GooglePlus.h>
//#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GoogleSignIn/GoogleSignIn.h>

#import "FHSTwitterEngine.h"

static NSString * const kClientId = @"688992366945-4nde42cphb4045u9m81i2d0vhg03lqc0.apps.googleusercontent.com";

//@interface HomeVC : UIViewController<GPPSignInDelegate, FHSTwitterEngineAccessTokenDelegate>
@interface HomeVC : UIViewController<FHSTwitterEngineAccessTokenDelegate, GIDSignInDelegate>

@property BOOL isFb;

@property (strong, nonatomic) IBOutlet UIImageView *imgBlackBookResearch;

@property (strong, nonatomic) IBOutlet UILabel *lblWelcomeMessage;

@property (strong, nonatomic) IBOutlet UIImageView *btnFacebookLogin;

@property (strong, nonatomic) IBOutlet UIImageView *btnGoogleLogin;

@property (strong, nonatomic) IBOutlet UIImageView *btnTwitterLogin;

@property (weak, nonatomic) IBOutlet UIImageView *btnLinkedinLogin;

@end
