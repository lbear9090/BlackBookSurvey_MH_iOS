//
//  WebServiceParser
//
//  Created by Parth on 8/20/12.
//  Copyright (c) Narola Infotech. All rights reserved.
//

#import "WebServiceResponse.h"

#import "objc/runtime.h"

#define DEFAULT_TIMEOUT 30.0f

@implementation WebServiceResponse

#pragma mark - Properties

@synthesize operationQueue = _operationQueue;

#pragma mark - Init NSObject

- (id)init;
{
    if ((self = [super init]))
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
        reachability = [Reachability reachabilityWithHostName:SERVER_URL];
        [reachability startNotifier];
    }
    
    return self;
}

#pragma mark - API

+ (id)sharedMediaServer;
{
    static dispatch_once_t onceToken;
    static id sharedMediaServer = nil;
    dispatch_once( &onceToken, ^{
        sharedMediaServer = [[[self class] alloc] init];
    });
    
    return sharedMediaServer;
}

#pragma mark - User Request Service

- (void)initWithWebRequests:(NSMutableURLRequest *)URLRequest inBlock:(ResponseBlock)resBlock
{
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            __block id responseObjects = nil;
            
            NSLog(@"URL Request:%@",URLRequest);
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:URLRequest
                                                    completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                              NSString *responseString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                                              if (data.length > 0)
                                              {
                                                  id allValues = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                                  if([(NSDictionary *)allValues count] <= 0)
                                                      responseString = @"Not Available";
                                                  responseObjects = allValues;
                                              }
                                              else if(error != nil)
                                              {
                                                  responseString = @"Fail";
                                              }
                                              else if(data.length == 0)
                                              {
                                                  responseString = @"Not Available";
                                              }
                                              dispatch_sync(dispatch_get_main_queue(), ^{
                                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                      if (error) {
                                                          resBlock(error, responseObjects, responseString);
                                                      }
                                                      else {
                                                          resBlock(error, responseObjects, responseString);
                                                      }
                                                  }];
                                              });
                                          }];
            
            [task resume];
            
        });
    }];
    
    [operation setQueuePriority:NSOperationQueuePriorityNormal];
    [self.operationQueue addOperation:operation];
}
@end