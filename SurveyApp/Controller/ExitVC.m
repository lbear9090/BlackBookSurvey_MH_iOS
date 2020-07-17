//
//  ExitVC.m
//  SurveyApp
//
//  Created by Harsh on 15/12/17.
//  Copyright © 2017 C111. All rights reserved.
//

#import "ExitVC.h"
#import "StartSurveyVC.h"
#import "ExpandableTableVC.h"

@interface ExitVC ()

@end

@implementation ExitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self setupNavigation];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setHidesBackButton:YES];

}
- (void)setupNavigation
{
    self.title = kApplicationName;
       self.navigationController.navigationItem.hidesBackButton = YES;
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:RGB(253.0, 174.0, 17.0), NSForegroundColorAttributeName, SFUITextBold(20.0), NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = navbarTitleTextAttributes;
    
    self.navigationController.navigationBar.tintColor = RGB(253.0, 174.0, 17.0);
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationItem.hidesBackButton = YES;
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStyleDone target:self action:@selector(btnBack:)];
    btnBack.tintColor = [UIColor whiteColor];
   // self.navigationItem.leftBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exitBtn:(id)sender {
    
    UIApplication *mySafari = [UIApplication sharedApplication];
    NSURL *myURL = [[NSURL alloc]initWithString:@"http://www.blackbookmarketresearch.com/"];
    [mySafari openURL:myURL];
    
}
- (IBAction)emailBtn:(id)sender {
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:@"2020-2021 Black Book Survey"];
        [mail setToRecipients:@[@"research@blackbookmarketresearch.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"This device does not support sending mails"];
    }
}
    

- (IBAction)takeanotherBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
