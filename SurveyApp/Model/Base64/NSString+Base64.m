//
//  NSString+Base64.m
//  whyou
//
//  Created by c28 on 18/02/14.
//  Copyright (c) 2014 c28. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)


- (NSString *)base64ecodingString
{
    NSData *plainTextData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    return base64String;
}

- (NSString *)base64DecodeString
{
    NSData *plainTextData = [NSData dataFromBase64String:self];
    NSString *plainText = [[NSString alloc] initWithData:plainTextData encoding:NSUTF8StringEncoding];
    return plainText;
}


+ (NSString *)base64Encode:(NSString *)plainText
{
    NSData *plainTextData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainTextData base64EncodedString];
    return base64String;
}

+ (NSString *)base64Decode:(NSString *)base64String
{
    NSData *plainTextData = [NSData dataFromBase64String:base64String];
    NSString *plainText = [[NSString alloc] initWithData:plainTextData encoding:NSUTF8StringEncoding];
    return plainText;
}

@end
