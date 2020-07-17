//
//  TraceOperations.h
//  NIPLiOSFramework
//
//  Created by Prerna on 5/28/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TraceOperations : NSObject

#define TraceError(strErr) \
[TraceOperations writeErrorLogsToFile:[NSString stringWithFormat:@"====================\nTrace: %@ \nMETHOD: %s \nLine Number:%d \nClass: %@ \nError Description: %@", [NSDate date],  __func__, __LINE__,NSStringFromClass([self class]),strErr]];

#define TraceWS(requestURL,ParamsDictionary,serviceType) \
[TraceOperations writeWSLogsToFile:[NSString stringWithFormat:@"====================\nTrace: %@ \nService URL:%@ \nService Type: %@ \nParameters: %@", [NSDate date],requestURL,serviceType,ParamsDictionary]];

#define TraceFlow()\
[TraceOperations writeFlowLogsToFile:[NSString stringWithFormat:@"====================\nTrace: %@ \nMETHOD: %s \nClass: %@", [NSDate date],  __func__,NSStringFromClass([self class])]];

#pragma mark - Log Trace

+ (void)writeToFile:(NSString*)strErr withFileName:(NSString *)filename;
+ (NSString*)readFile:(NSString *)filename;

#pragma mark - Trace Errors

+ (void)writeErrorLogsToFile:(NSString*)strErr;
+ (NSString*)readErrorFile;

#pragma mark - Trace Webservice Flow

+ (void)writeWSLogsToFile:(NSString*)strErr;
+ (NSString*)readWSLogFile;

#pragma mark - Trace App Flow

+ (void)writeFlowLogsToFile:(NSString*)strErr;
+ (NSString*)readFlowLogFile;

@end