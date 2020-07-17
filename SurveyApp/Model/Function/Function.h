//
//  Common.h
//  SQLExample
//
//  Created by Prerna on 5/13/15.
//  Copyright (c) 2015 Prerna. All rights reserved.


#import <Foundation/Foundation.h>

@interface Function : NSObject
{

}

#pragma mark - Dictionary Functions

+ (NSString *)getStringFromObject:(NSString *)key fromDictionary:(NSDictionary *)values;
+ (NSString *)getStringForKey:(NSString *)key fromDictionary:(NSDictionary *)values;

+ (int)getIntegerForKey:(NSString *)key fromDictionary:(NSDictionary *)values;
+ (double)getDoubleForKey:(NSString *)key fromDictionary:(NSDictionary *)values;

#pragma mark - String Functions

+ (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string;
+ (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet forString:(NSString *)string;
+ (BOOL) stringIsEmpty:(NSString *) aString;

#pragma mark - Date Formats

+ (NSDateFormatter *)getDateFormatForApp;

#pragma mark - User Defaults

+ (void)setStringValueToUserDefaults:(NSString *)strValue ForKey:(NSString *)strKey;
+ (NSString *)getStringValueFromUserDefaults_ForKey:(NSString *)strKey;

+ (void)setIntegerValueToUserDefaults:(int)intValue ForKey:(NSString *)intKey;
+ (int)getIntegerValueFromUserDefaults_ForKey:(NSString *)intKey;

+ (void)setBooleanValueToUserDefaults:(bool)booleanValue ForKey:(NSString *)booleanKey;
+ (bool)getBooleanValueFromUserDefaults_ForKey:(NSString *)booleanKey;

+ (void)setObjectValueToUserDefaults:(id)idValue ForKey:(NSString *)strKey;
+ (id)getObjectValueFromUserDefaults_ForKey:(NSString *)strKey;

+ (void)removeUserDefaultsForKey:(NSString *)key;

@end