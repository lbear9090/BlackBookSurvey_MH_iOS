//
//  AppDelegate.m
//  SurveyApp
//
//  Created by C111 on 08/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "AppDelegate.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
//#import <GooglePlus/GooglePlus.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import <linkedin-sdk/LISDK.h>
#import <LinkedinSwift/LSHeader.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    
    if (![Function getBooleanValueFromUserDefaults_ForKey:kHasLaunchedOnce])
    {
        [Function setIntegerValueToUserDefaults:0 ForKey:kSurveyID];
        
        [Function setBooleanValueToUserDefaults:NO ForKey:kVendorsParsed];
        [Function setBooleanValueToUserDefaults:NO ForKey:kServicesParsed];
        [Function setBooleanValueToUserDefaults:NO ForKey:kOrganizationsParsed];
        [Function setBooleanValueToUserDefaults:NO ForKey:kRolesParsed];
        [Function setBooleanValueToUserDefaults:NO ForKey:kPreferencesParsed];
        [Function setBooleanValueToUserDefaults:NO ForKey:kScoreMatrix];
        [Function setBooleanValueToUserDefaults:NO ForKey:kQuestions];
        
        [Function setBooleanValueToUserDefaults:YES ForKey:kFirstRun];
        
        [Function setBooleanValueToUserDefaults:YES ForKey:kHasLaunchedOnce];
    }
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [CoreDataHelper save];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [CoreDataHelper save];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    if ([[url scheme]hasPrefix:@"fb"]) {
        return [[FBSDKApplicationDelegate sharedInstance] application:app
        openURL:url
        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
        annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
        ];
    }else if([LISDKCallbackHandler shouldHandleUrl:url]){
        return [LISDKCallbackHandler application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }else if([LinkedinSwiftHelper shouldHandleUrl:url]){
        return [LinkedinSwiftHelper application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    }else{
        return [[GIDSignIn sharedInstance] handleURL:url];
    }
    
    // Add any custom logic here.
    return YES;
}

//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    BOOL wasHandle = NO;
//    if ([[url scheme]hasPrefix:@"fb"]) {
//        wasHandle = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
//    }else{
//        wasHandle = [[GIDSignIn sharedInstance] handleURL:url];
////        wasHandle = [GPPURLHandler handleURL:url sourceApplication:sourceApplication annotation:annotation];
//    }
//    return  wasHandle;
//}

#pragma mark - Remote Notification Methods

//- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
//{
//   /*
//    NSString *deviceUDID;
//    const unsigned *tokenBytes = [deviceToken bytes];
//    deviceUDID = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
//                  ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
//                  ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
//                  ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
//    NSLog(@"####################### Device Token : %@", deviceUDID);
//
//    [Function setStringValueToUserDefaults:deviceUDID ForKey:@"deviceToken"];  */
//}



@end
