//
//  RegistrationVC.h
//  SurveyApp
//
//  Created by C111 on 09/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationVC : UIViewController

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property BOOL isGuest;
@property BOOL isCompleteProfile;

@property (strong, nonatomic) IBOutlet UIView *viewCredentials;
@property (strong, nonatomic) IBOutlet UIView *viewOptions;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;

@property (strong, nonatomic) IBOutlet UIButton *btnNotice;
@property (strong, nonatomic) IBOutlet UIButton *btnIncentives;
@property (strong, nonatomic) IBOutlet UIButton *btnFutureSurvey;

@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;

- (IBAction)btnEmailPref:(id)sender;
- (IBAction)btnTelephonePref:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *btnEmailPref;
@property (weak, nonatomic) IBOutlet UIButton *btnTelephonePref;

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@end
