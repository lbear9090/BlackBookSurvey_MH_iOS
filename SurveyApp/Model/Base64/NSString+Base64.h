//
//  NSString+Base64.h
//  whyou
//
//  Created by c28 on 18/02/14.
//  Copyright (c) 2014 c28. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Base64.h"
@interface NSString (Base64)
- (NSString *)base64ecodingString;
- (NSString *)base64DecodeString;
+ (NSString *)base64Encode:(NSString *)plainText;
+ (NSString *)base64Decode:(NSString *)base64String;
@end
