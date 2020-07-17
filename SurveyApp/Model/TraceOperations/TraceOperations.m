//
//  TraceOperations.m
//  NIPLiOSFramework
//
//  Created by Prerna on 5/28/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import "TraceOperations.h"

static NSString *errorLogFile = @"ErrorLogs.txt";
static NSString *webserviceLogFile = @"WSLogs.txt";
static NSString *navigationFlowLogFile = @"NavFlowLogs.txt";

@implementation TraceOperations

#pragma mark - Log Trace

+ (void)writeToFile:(NSString *)strErr withFileName:(NSString *)filename
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileAtPath = [filePath stringByAppendingPathComponent:filename];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath])
    {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    NSString *strLog;
    NSString *strFileData = [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
    
    if (strFileData.length > 0)
    {
        strLog = [NSString stringWithFormat:@"\n%@", strErr];
    }
    else
    {
        strLog = strErr;
    }
    
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:fileAtPath];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[strLog dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)readFile:(NSString *)filename
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *fileAtPath = [filePath stringByAppendingPathComponent:filename];
    
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

#pragma mark - Trace Errors

+ (void)writeErrorLogsToFile:(NSString *)strErr
{
    [self writeToFile:strErr withFileName:errorLogFile];
}

+ (NSString *)readErrorFile
{
    return [self readFile:errorLogFile];
}

#pragma mark - Trace Webservice Flow

+ (void)writeWSLogsToFile:(NSString *)strErr
{
    [self writeToFile:strErr withFileName:webserviceLogFile];
}

+ (NSString *)readWSLogFile
{
    return [self readFile:webserviceLogFile];
}

#pragma mark - Trace App Flow

+ (void)writeFlowLogsToFile:(NSString *)strErr
{
    [self writeToFile:strErr withFileName:navigationFlowLogFile];
}

+ (NSString *)readFlowLogFile
{
    return [self readFile:navigationFlowLogFile];
}

@end