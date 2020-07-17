//
//  NetworkAvailability.m
//  NIPLiOSFramework
//
//  Created by Prerna on 5/25/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import "NetworkAvailability.h"


#define StatusString @"statusString"
#define StatusImage  @"statusImage"
#define ReachabilityStatus @"reachabilityStatus"

#define StatusStringValueForWifi @"Connected to Wifi"
#define StatusStringValueForWWAN @"Connected to 3G/2G"
#define StatusStringValueForNoNetwork @"No Internet Connection"

#define StatusImageForWifi @"Airport.png"
#define StatusImageForWWAN @"WWAN5.png"
#define StatusImageNoNetwork @"stop-32.png"

BOOL reachabilityStatus;
@implementation NetworkAvailability

+ (instancetype)instance
{
    static dispatch_once_t pred;
    static id shared = nil;
    dispatch_once(&pred, ^{
        shared = [[super alloc] initSingletonInstance];
        
    });
    return shared;
}

- (instancetype)initSingletonInstance
{
    [self registerReachabilityNotification];
    self.hostReachability = [Reachability reachabilityWithHostName:@"www.apple.com"];
    [self.hostReachability startNotifier];
    [self configureReachabilityStatus:self.hostReachability];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];
    [self configureReachabilityStatus:self.internetReachability];
    
    self.wifiReachability = [Reachability reachabilityForLocalWiFi];
    [self.wifiReachability startNotifier];
    [self configureReachabilityStatus:self.wifiReachability];
    
    return [super init];
}

#pragma mark - Reachability Notification methods

-(void)dealloc
{
    [self unRegisterReachabilityNotification];
}

- (void)registerReachabilityNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
}
- (void)unRegisterReachabilityNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self configureReachabilityStatus:curReach];
}
#pragma mark - Reachability Setup
- (void)configureReachabilityStatus:(Reachability *)reachability
{
    if (reachability == self.hostReachability)
    {
        [self reachabilityStatusDisplay:reachability];
        BOOL connectionRequired = [reachability connectionRequired];
        
        NSString* baseLabelText = @"";
        if (connectionRequired)
        {
            baseLabelText = NSLocalizedString(@"Cellular data network is available.\nInternet traffic will be routed through it after a connection is established.", @"Reachability text if a connection is required");
        }
        else
        {
            baseLabelText = NSLocalizedString(@"Cellular data network is active.\nInternet traffic will be routed through it.", @"Reachability text if a connection is not required");
        }
    }
    if (reachability == self.internetReachability)
    {
        [self reachabilityStatusDisplay:reachability];
    }
    
    if (reachability == self.wifiReachability)
    {
        [self reachabilityStatusDisplay:reachability];
    }
}



#pragma mark - Reachability action methods
- (NSDictionary *)reachabilityStatusDisplay:(Reachability *)reachability;
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    NSString* statusString = @"";
    NSString* imageName = @"";
    
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = StatusStringValueForNoNetwork;
            imageName = StatusImageNoNetwork ;
            reachabilityStatus = NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = StatusStringValueForWWAN;
            imageName  = StatusImageForWWAN;
            reachabilityStatus = YES;
            break;
        }
        case ReachableViaWiFi:        {
            statusString= StatusStringValueForWifi;
            imageName = StatusImageForWifi;
            reachabilityStatus = YES;
            break;
        }
    }
    NSDictionary *dictionary = @{StatusString:statusString,
                                 StatusImage:imageName,
                                 ReachabilityStatus:[NSNumber numberWithBool:reachabilityStatus]};
    return dictionary;
}

- (BOOL) isReachable
{
    return reachabilityStatus;
}


@end
