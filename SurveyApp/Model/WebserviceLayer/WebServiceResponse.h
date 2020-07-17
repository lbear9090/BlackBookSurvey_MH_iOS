//
//  WebServiceParser
//
//  Created by Parth on 8/20/12.
//  Copyright (c) NarolaInfotech. All rights reserved.
//

/*
 * Queued server to manage concurrency and priority of NSURLRequests.
 */

#import <Foundation/Foundation.h>

#import "Constants.h"
#import "Reachability.h"
#import "WebServiceDataAdaptor.h"

typedef void (^ResponseBlock)     (NSError *error, id objects, NSString *responseString);

@interface WebServiceResponse : NSObject
{
    Reachability *reachability;
}

@property (strong) NSOperationQueue *operationQueue;

+ (id)sharedMediaServer;

- (void)initWithWebRequests:(NSMutableURLRequest *)URLRequest inBlock:(ResponseBlock)resBlock;

@end