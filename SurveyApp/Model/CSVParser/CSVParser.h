//
//  CSVParser.h
//  SurveyApp
//
//  Created by C111 on 11/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVParser : NSObject

+ (void)parseCSVFileForType:(NSString *)type;

+ (BOOL)parseCSVCheckIfLineIsTemplate:(NSString *)line forType:(NSString *)type;

+ (void)parseCSV:(NSString *)string forType:(NSString *)type;

@end