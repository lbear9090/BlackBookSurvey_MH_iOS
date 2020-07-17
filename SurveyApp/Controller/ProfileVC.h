//
//  ProfileVC.h
//  SurveyApp
//
//  Created by C111 on 18/04/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileVC : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;

@property (strong, nonatomic) IBOutlet UIButton *btnSaveProfile;

@end