//
//  Common.m
//  SQLExample
//
//
//  Created by Prerna on 5/13/15.
//  Copyright (c) 2015 Prerna. All rights reserved.

#import "Function.h"

@implementation Function

#pragma mark - Dictionary Functions
#pragma mark -

+ (NSString *)getStringFromObject:(NSString *)key fromDictionary:(NSDictionary *)values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  [values objectForKey:key];
    else
        return @"";
}

+ (NSString *)getStringForKey:(NSString *)key fromDictionary:(NSDictionary *)values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  [values objectForKey:key];
    else
        return @"";
}

+ (int)getIntegerForKey:(NSString *)key fromDictionary:(NSDictionary *)values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  [[values objectForKey:key]integerValue];
    else
        return 0;
}

+ (double)getDoubleForKey:(NSString *)key fromDictionary:(NSDictionary *)values
{
    if (![[values objectForKey:key] isKindOfClass:[NSNull class]])
        return  [[values objectForKey:key]doubleValue];
    else
        return 0;
}

#pragma mark - String Functions
#pragma mark -

+ (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string
{
    NSUInteger location = 0;
    NSUInteger length = [string length];
    unichar charBuffer[length];
    [string getCharacters:charBuffer];
    
    for (location = 0; location < length; location++)
    {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    
    return [string substringWithRange:NSMakeRange(location, length - location)];
}

+ (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string
{
    NSUInteger location = 0;
    NSUInteger length = [string length];
    unichar charBuffer[length];
    [string getCharacters:charBuffer];
    
    for (length=0; length > 0; length--)
    {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [string substringWithRange:NSMakeRange(location, length - location)];
}

+ (BOOL)stringIsEmpty:(NSString *)aString
{
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - Date Formats
#pragma mark -

+ (NSDateFormatter *)getDateFormatForApp
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:DateFormatter];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:TimeZone]];
    return formatter;
}

#pragma mark - UserDefaults
#pragma mark -
#pragma mark - Defaults String Values

+ (void)setStringValueToUserDefaults:(NSString *)strValue ForKey:(NSString *)strKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", strValue] forKey:strKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (NSString *)getStringValueFromUserDefaults_ForKey:(NSString *)strKey
{
    NSString *s = nil;
    if ([NSUserDefaults standardUserDefaults]) {
        s =[[NSUserDefaults standardUserDefaults] valueForKey:strKey];
    }
    return s;
}

#pragma mark - Defaults Integer Values

+ (void)setIntegerValueToUserDefaults:(int)intValue ForKey:(NSString *)intKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setInteger:intValue forKey:intKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (int)getIntegerValueFromUserDefaults_ForKey:(NSString *)intKey
{
    int i = 0;
    if ([NSUserDefaults standardUserDefaults]) {
        i = (int) [[NSUserDefaults standardUserDefaults] integerForKey:intKey];
    }
    return i;
}

#pragma mark - Defaults Boolean Values

+ (void)setBooleanValueToUserDefaults:(bool)booleanValue ForKey:(NSString *)booleanKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setBool:booleanValue forKey:booleanKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (bool)getBooleanValueFromUserDefaults_ForKey:(NSString *)booleanKey
{
    bool b = false;
    if ([NSUserDefaults standardUserDefaults]) {
        b = [[NSUserDefaults standardUserDefaults] boolForKey:booleanKey];
    }
    return b;
}

#pragma mark - Defaults Object Values

+ (void)setObjectValueToUserDefaults:(id)idValue ForKey:(NSString *)strKey
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] setObject:idValue forKey:strKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)getObjectValueFromUserDefaults_ForKey:(NSString *)strKey
{
    id obj = nil;
    if ([NSUserDefaults standardUserDefaults]) {
        obj =[[NSUserDefaults standardUserDefaults] objectForKey:strKey];
    }
    
    return obj;
}

#pragma mark - Remove Default Values

+ (void)removeUserDefaultsForKey:(NSString *)key
{
    if ([NSUserDefaults standardUserDefaults]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

@end