//
//  PrivacyPolicyVC.m
//  SurveyApp
//
//  Created by Harsh on 07/12/17.
//  Copyright © 2017 C111. All rights reserved.
//

#import "PrivacyPolicyVC.h"

@interface PrivacyPolicyVC ()

@end

@implementation PrivacyPolicyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    if ([self.strTitle isEqualToString:@"PRIVACY POLICY"]) {
        
        self.textView.text = @"Black Book Market Research is committed to protecting the privacy of your information collected with you use our website or any of our survey and polling applications. If you do not accept the terms set out in this Privacy Policy, you should cease all usage of our services. We reserve the right to modify this policy at our sole discretion at any time. You are advised to check back at this page for any updates.\n\nWhile you are using our surveying and polling services, we may collect certain information about you including name, email address, phone number, place of employment, geographic location, number of surveys taken, and/or position title. We use this information for verifying account information, identifying frauds, sending survey announcements and results, and revealing trends. In addition, we may collect certain statistical information and share the outcomes with subscribers and report purchasers.\n\nThis statistical information is not linked to any personally identifiable information.\n\nOur website or mobile applications may contain links to third party websites or mobile applications. Please be aware that these other sites and applications have their own privacy policies and Black Book is not responsible for their privacy practices.\n\nWe may set and access cookies on your device, which are small text files to help us recognize you the next time you visit us. We may also use these cookies to customize our sites for user’s preferences and statuses.\n\nBlack Book commits to protect your privacy and security from any unauthorized disclosure and uses a variety of secure techniques for the purpose. However, you should be aware that cyberthreats are changing rapidly and we cannot guarantee that our safeguards are failsafe, You hereby acknowledged that Black Book is not responsible for the use of your personal information disclosed in any unauthorized manner.\n\nSurvey Serving Technology\n\nThis app uses various online survey platforms through which we conduct surveys including Pollfish and Survey Monkey for ad hoc polling.  By downloading this application, you give your consent for the processing of your submitted data by third party ballot verifications as well. Black Book utilizes various.\n\n";
    }else{
        self.textView.text = @"Any use of this application, our website and/or other services that Black Book provides assumes that you agree to these Terms of Use. These terms also apply to all iOS and Android mobile applications that Black Book provides. If you do not accept these terms, you should cease all usage of our services. We reserve the right to change these Terms of Use in our sole direction at any time. You are advised to check back at this page for any updates.\n\nA user is allowed to have only one account. An email address may only be used by one user. You agree to provide accurate information including email address, phone number, employer or company/organization where the software or services are implemented, position title, and location. Failure to do so may result in the termination of your account.\n\nYou may not use Virtual Private Networks (VPNs), proxies or any other methods to manipulate your IP addresses, locations, device types, or other profile information fraudulently.\n\nYour account will be terminated at any time without notice if it is believed or has been determined that you have violated these Terms of Use or suspicious activity is detected. We also reserve the right to contact you via phone or email to confirm identities.\n\nYou hereby acknowledge that Black Book and its founders and staff are not responsible or liable for any damages, losses or problems caused by or related to our website or mobile applications. ";
    }
    
    // Do any additional setup after loading the view.
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.textView.textContainerInset = UIEdgeInsetsMake(5, 0, 0, 0);
    [self.textView setContentOffset: CGPointMake(0,0) animated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Helper Methods

- (void)setupNavigation
{
    self.title = self.strTitle;
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = btnBack;
}
#pragma mark - Button Action Methods

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
