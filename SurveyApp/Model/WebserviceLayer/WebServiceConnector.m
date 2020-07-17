//
//  WebConnector.m
//  SQLExample
//
//  Created by Prerna on 5/15/15.
//  Copyright (c) 2015 Narola. All rights reserved.
//

#import "WebServiceConnector.h"

#import "WebServiceResponse.h"
#import "WebServiceDataAdaptor.h"
#import "NetworkAvailability.h"
#import "TraceOperations.h"
#import "SVProgressHUD.h"

#define DEFAULT_TIMEOUT 3000.0f

@implementation WebServiceConnector

@synthesize responseArray, responseError, responseDict, responseCode, URLRequest;

- (BOOL)checkNetConnection
{
    return [[NetworkAvailability instance] isReachable];
}

- (void)init:(NSString *)WebService withParameters:(NSDictionary *)ParamsDictionary withObject:(id)object withSelector:(SEL)selector forServiceType:(NSString *)serviceType showDisplayMsg:(NSString *)message
{
    /* serviceType: {GET, POST, JSON} */
    WebServiceResponse *server = [WebServiceResponse sharedMediaServer];
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        ShowNetworkIndicator(YES);
        
    });
    
    responseCode = 100;
    responseError = [[NSString alloc]init];
    responseArray = [[NSArray alloc]init];
    
    if ([serviceType isEqualToString:@"GET"])
    {
        URLRequest = [self getMutableRequestFromGetWS:WebService withParams:ParamsDictionary];
    }
    else if ([serviceType isEqualToString:@"POST"])
    {
        URLRequest = [self getMutableRequestForPostWS:WebService withObjects:ParamsDictionary isJsonBody:NO];
    }
    else if ([serviceType isEqualToString:@"JSON"])
    {
        URLRequest = [self getMutableRequestForPostWS:WebService withObjects:ParamsDictionary isJsonBody:YES];
    }
    
    if (![self checkNetConnection])
    {
        responseCode = 104;
        self.responseError = @"The network connection was lost.";
        
        //  [SVProgressHUD showErrorWithStatus:@"The network connection was lost." withViewController:[Function topMostController]];
        
        [SVProgressHUD showErrorWithStatus:@"The network connection was lost."];
        [object performSelectorOnMainThread:selector withObject:self waitUntilDone:false];
        return;
    }
    
    //  [SVProgressHUD showWithStatus:@"Please wait.."];
    
    [server initWithWebRequests:URLRequest inBlock:^(NSError *error, id objects, NSString *responseString)
     {
         if (error)
         {
             responseCode = 101;
             self.responseError = error.localizedDescription;
             //
             ShowNetworkIndicator(NO);
         }
         else
         {
             if ([responseString isEqualToString:@"Fail"])
             {
                 responseCode = 102;
                 self.responseError = @"Response Issue From Server";
             }
             else if ([responseString isEqualToString:@"Not Available"])
             {
                 responseCode = 103;
                 self.responseError = @"No Data Available";
                 ShowNetworkIndicator(NO);
             }
             else
             {
                 responseCode = 100;
                 responseDict = (NSDictionary *) objects;
                 responseArray = [[WebServiceDataAdaptor alloc]autoParse:responseDict forServiceName:WebService];
                 
                 ShowNetworkIndicator(NO);
             }
         }
         
         [SVProgressHUD dismiss];
         [object performSelectorOnMainThread:selector withObject:self waitUntilDone:false];
     }];
}

#pragma mark - generate URL Methods
///*** this method can be used when there is cake php webservice ***/
//- (NSString *) getNetURLFromService:(NSString *) WebService withParams: (NSArray *) ParamsArray
//{
//    NSString *Query = WebService;
//    if (ParamsArray == nil)
//        return nil;
//
//    for(int i = 0;i<[ParamsArray count];i++)
//    {
//        NSString *appendString = [NSString stringWithFormat:@"/%@",[ParamsArray objectAtIndex:i]];
//        Query = [Query stringByAppendingString:appendString];
//    }
//    return Query;
//}

/*** this method can be used when parameters are to be sent as query string ***/
- (NSMutableURLRequest *) getMutableRequestFromGetWS:(NSString *)WebService withParams:(NSDictionary *)ParamsDictionary
{
    TraceWS(WebService,ParamsDictionary,@"GET")
    NSString *Query;
    
    if (ParamsDictionary == nil)
    {
        Query = WebService;
    }
    else
    {
        int i = 0;
        Query = WebService;
        
        for(id key in ParamsDictionary)
        {
            NSString *appendString = @"";
            
            if (i != ParamsDictionary.count - 1)
                appendString = [appendString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[ParamsDictionary objectForKey:key]]];
            else
                appendString = [appendString stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[ParamsDictionary objectForKey:key]]];
            
            Query = [Query stringByAppendingString:appendString];
            i++;
        }
    }
    
    Query = [Query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:Query] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:DEFAULT_TIMEOUT];
    
    return request;
}

- (NSMutableURLRequest *)getMutableRequestForPostWS:(NSString *)url withObjects:(NSDictionary *)dict isJsonBody:(bool)JSONBody
{
    NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:DEFAULT_TIMEOUT];
    NSData *objData;
    
    if (JSONBody)
    {
        TraceWS(url,dict,@"JSON")
        objData = [self dictionaryToJSONData:dict];
        NSDictionary *headers = @{@"content-type": @"application/json",
                                  @"accept": @"application/json"};
        [request setAllHTTPHeaderFields:headers];
    }
    else
    {
        TraceWS(url,dict,@"POST")
        objData = [self dictionaryToPostData:dict];
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    [request addValue:[NSString stringWithFormat:@"%lu", (unsigned long)[objData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:objData];
    
    return request;
}

#pragma mark - helper methods

- (NSData *)dictionaryToJSONData:(NSDictionary *)dict
{
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[NSDictionary dictionaryWithDictionary:dict] options:0 error:&jsonError];
    
    if (jsonError!=nil)
    {
        return nil;
    }
    
    return jsonData;
}

- (NSData *) dictionaryToPostData:(NSDictionary *)ParamsDictionary
{
    int i = 0;
    NSString *postDataString = @"";
    
    for(id key in ParamsDictionary)
    {
        if (i != ParamsDictionary.count - 1)
            postDataString = [postDataString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[ParamsDictionary objectForKey:key]]];
        else
            postDataString = [postDataString stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,[ParamsDictionary objectForKey:key]]];
        
        i++;
    }
    
    return [postDataString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
