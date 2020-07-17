//
//  NetworkAvailability.h
//  NIPLiOSFramework
//
//  Created by Prerna on 5/25/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkAvailability : NSObject

@property (nonatomic) Reachability *hostReachability;
@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *wifiReachability;


- (BOOL) isReachable;
+ (instancetype)instance;
- (void) reachabilityChanged:(NSNotification *)note;
- (void)registerReachabilityNotification;
- (void)unRegisterReachabilityNotification;
- (NSDictionary *)reachabilityStatusDisplay:(Reachability *)reachability;

@end
