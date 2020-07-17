//
//  StartSurveyVC.h
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MessageUI/MessageUI.h>

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "MISDropdownViewController.h"
#import "MISDropdownMenuView.h"

@interface StartSurveyVC : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) MISDropdownViewController *dropdownViewController;
@property (strong, nonatomic) MISDropdownMenuView *dropdownMenuView;

@property (strong, nonatomic) IBOutlet UILabel *lblService;
@property (strong, nonatomic) IBOutlet UILabel *lblVendor;
@property (strong, nonatomic) IBOutlet UILabel *lblOrganization;
@property (strong, nonatomic) IBOutlet UILabel *lblRole;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *btnService;
@property (strong, nonatomic) IBOutlet UIButton *btnVendor;
@property (strong, nonatomic) IBOutlet UIButton *btnOrganization;
@property (strong, nonatomic) IBOutlet UIButton *btnRole;
@property (strong, nonatomic) IBOutlet UIButton *btnRating;

@property (strong, nonatomic) IBOutlet UIButton *btnStartSurvey;

@end
