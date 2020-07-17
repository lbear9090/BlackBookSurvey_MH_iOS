//
//  CSVParser.m
//  SurveyApp
//
//  Created by C111 on 11/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "CSVParser.h"

@implementation CSVParser

#pragma mark - CSV Parsing Methods

+ (void)parseCSVFileForType:(NSString *)type
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    
    NSString *filePath = [mainBundle pathForResource:type ofType:@"csv"];
    NSString *fileType = type;
    
    NSFileManager *filemanager = [NSFileManager defaultManager];
    if (![filemanager fileExistsAtPath:filePath])
        return;
    
    /* Fetching data from file and converting it to NSString */
    NSString *lines = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* Removing empty spaces and lines */
    lines = [lines stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    /* Converting single lined data into multiple lined data */
    NSArray *allLinedStrings = [[lines componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"length > 0"]];
    
    /* Parsing the data */
    if ([allLinedStrings count] == 0) /* Checks if the CSV File is empty */
    {
        [SVProgressHUD showErrorWithStatus:@"Imported CSV File is Empty"];
        return;
    }
    else if ([allLinedStrings count] == 1) /* Checks if CSV File has only 1 line of data */
    {
        NSString *strLine = [allLinedStrings objectAtIndex:0];
        
        if ([self parseCSVCheckIfLineIsTemplate:strLine forType:fileType]) /* Checks if the line is Template */
        {
            [SVProgressHUD showInfoWithStatus:@"Imported CSV File has no Data"];
            return;
        }
        else
        {
            [self parseCSV:strLine forType:fileType];
        }
    }
    else if ([allLinedStrings count] == 2) /* Checks if CSV File has only 2 lines of data */
    {
        NSString *strLineOne = [allLinedStrings objectAtIndex:0];
        NSString *strLineTwo = [allLinedStrings objectAtIndex:1];
        
        if ([self parseCSVCheckIfLineIsTemplate:strLineOne forType:fileType]) /* Checks if 1st line is Template */
        {
            if ([self parseCSVCheckIfLineIsTemplate:strLineTwo forType:fileType]) /* Checks if 2nd line is Template */
            {
                [SVProgressHUD showInfoWithStatus:@"Imported CSV File has no Data"
                 ];
                return;
            }
            else
            {
                [self parseCSV:strLineTwo forType:fileType];
            }
        }
        else
        {
            [self parseCSV:strLineOne forType:fileType];
        }
    }
    else if ([allLinedStrings count] > 2) /* Checks if CSV File has more than 2 lines of data */
    {
        NSString *strLineOne = [allLinedStrings objectAtIndex:0];
        NSString *strLineTwo = [allLinedStrings objectAtIndex:1];
        
        if ([self parseCSVCheckIfLineIsTemplate:strLineOne forType:fileType]) /* Checks if 1st line is Template */
        {
            if ([self parseCSVCheckIfLineIsTemplate:strLineTwo forType:fileType]) /* Checks if 2nd line is Template */
            {
                [SVProgressHUD showInfoWithStatus:@"Imported CSV File has no Data"];
                return;
            }
            else
            {
                [self parseCSV:strLineTwo forType:fileType];
                
                for (int i = 2; i < [allLinedStrings count]; i++)
                {
                    NSString *stringToAdd = [allLinedStrings objectAtIndex:i];
                    
                    [self parseCSV:stringToAdd forType:fileType];
                }
            }
        }
        else
        {
            [self parseCSV:strLineOne forType:fileType];
            
            for (int i = 1; i < [allLinedStrings count]; i++)
            {
                NSString *stringToAdd = [allLinedStrings objectAtIndex:i];
                
                [self parseCSV:stringToAdd forType:fileType];
            }
        }
    }
}

+ (BOOL)parseCSVCheckIfLineIsTemplate:(NSString *)line forType:(NSString *)type
{
    if (IOS_OLDER_THAN_(8.0))
    {
        if ([type isEqualToString:kVendors])
        {
            if ([line rangeOfString:@"vendorId"].location != NSNotFound && [line rangeOfString:@"vendorName"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kOrganizations])
        {
            if ([line rangeOfString:@"organizationTypeId"].location != NSNotFound && [line rangeOfString:@"organizationTypeName"].location != NSNotFound && [line rangeOfString:@"parentId"].location != NSNotFound && [line rangeOfString:@"level"].location != NSNotFound && [line rangeOfString:@"isOptional"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kRoles])
        {
            if ([line rangeOfString:@"roleId"].location != NSNotFound && [line rangeOfString:@"roleName"].location != NSNotFound && [line rangeOfString:@"parentId"].location != NSNotFound && [line rangeOfString:@"level"].location != NSNotFound && [line rangeOfString:@"isOptional"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kRating])
        {
            if ([line rangeOfString:@"ratingId"].location != NSNotFound && [line rangeOfString:@"ratingName"].location != NSNotFound && [line rangeOfString:@"parentId"].location != NSNotFound && [line rangeOfString:@"level"].location != NSNotFound && [line rangeOfString:@"isOptional"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kServices])
        {
            if ([line rangeOfString:@"surveyTypeId"].location != NSNotFound && [line rangeOfString:@"surveyTypeName"].location != NSNotFound && [line rangeOfString:@"parentId"].location != NSNotFound && [line rangeOfString:@"level"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kPreferences])
        {
            if ([line rangeOfString:@"preferenceId"].location != NSNotFound && [line rangeOfString:@"preferenceText"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kQuestions])
        {
            if ([line rangeOfString:@"questionId"].location != NSNotFound && [line rangeOfString:@"questionTitle"].location != NSNotFound && [line rangeOfString:@"questionDescription"].location != NSNotFound && [line rangeOfString:@"questionType"].location != NSNotFound && [line rangeOfString:@"questionFormat"].location != NSNotFound && [line rangeOfString:@"optionCount"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kScoreMatrix])
        {
            if ([line rangeOfString:@"scoreMatrixId"].location != NSNotFound && [line rangeOfString:@"matrixTitle"].location != NSNotFound && [line rangeOfString:@"matrixDescription"].location != NSNotFound && [line rangeOfString:@"startRange"].location != NSNotFound && [line rangeOfString:@"endRange"].location != NSNotFound && [line rangeOfString:@"deleted"].location != NSNotFound)
                return YES;
            else
                return NO;
        }
    }
    else
    {
        if ([type isEqualToString:kVendors])
        {
            if ([line containsString:@"vendorId"] && [line containsString:@"vendorName"] && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kOrganizations])
        {
            if ([line containsString:@"organizationTypeId"] && [line containsString:@"organizationTypeName"]  && [line containsString:@"parentId"] && [line containsString:@"level"] && [line containsString:@"isOptional"] && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kRoles])
        {
            if ([line containsString:@"roleId"] && [line containsString:@"roleName"]  && [line containsString:@"parentId"] && [line containsString:@"level"] && [line containsString:@"isOptional"] && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kRating])
        {
            if ([line containsString:@"ratingId"] && [line containsString:@"ratingName"]  && [line containsString:@"parentId"] && [line containsString:@"level"] && [line containsString:@"isOptional"] && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kServices])
        {
            if ([line containsString:@"surveyTypeId"] && [line containsString:@"surveyTypeName"]  && [line containsString:@"parentId"]  && [line containsString:@"level"]  && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kPreferences])
        {
            if ([line containsString:@"preferenceId"] && [line containsString:@"preferenceText"]  && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kQuestions])
        {
            if ([line containsString:@"questionId"] && [line containsString:@"questionTitle"]  && [line containsString:@"questionDescription"] && [line containsString:@"questionType"] && [line containsString:@"questionFormat"]  && [line containsString:@"optionCount"] && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
        else if ([type isEqualToString:kScoreMatrix])
        {
            if ([line containsString:@"scoreMatrixId"] && [line containsString:@"matrixTitle"]  && [line containsString:@"matrixDescription"] && [line containsString:@"startRange"] && [line containsString:@"endRange"]  && [line containsString:@"deleted"])
                return YES;
            else
                return NO;
        }
    }
    
    return NO;
}

+ (void)parseCSV:(NSString *)string forType:(NSString *)type
{
    NSArray *arrContents = [string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@";"]];
    
    if ([type isEqualToString:kVendors])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"vendorId"];
        [dictionary setObject:strTwo forKey:@"vendorName"];
        [dictionary setObject:strThree forKey:@"deleted"];
        
        [CoreDataAdaptor saveVendorsInCoreData:dictionary];
    }
    else if ([type isEqualToString:kOrganizations])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFour = [arrContents objectAtIndex:3];
        strFour = [strFour stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFive = [arrContents objectAtIndex:4];
        strFive = [strFive stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strSix = [arrContents objectAtIndex:5];
        strSix = [strSix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"organizationTypeId"];
        [dictionary setObject:strTwo forKey:@"organizationTypeName"];
        [dictionary setObject:strThree forKey:@"parentId"];
        [dictionary setObject:strFour forKey:@"level"];
        [dictionary setObject:strFive forKey:@"isOptional"];
        [dictionary setObject:strSix forKey:@"deleted"];
        
        [CoreDataAdaptor saveOrganizationTypeInCoreData:dictionary];
    }
    else if ([type isEqualToString:kRoles])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFour = [arrContents objectAtIndex:3];
        strFour = [strFour stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFive = [arrContents objectAtIndex:4];
        strFive = [strFive stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strSix = [arrContents objectAtIndex:5];
        strSix = [strSix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"roleId"];
        [dictionary setObject:strTwo forKey:@"roleName"];
        [dictionary setObject:strThree forKey:@"parentId"];
        [dictionary setObject:strFour forKey:@"level"];
        [dictionary setObject:strFive forKey:@"isOptional"];
        [dictionary setObject:strSix forKey:@"deleted"];
        
        [CoreDataAdaptor saveRolesInCoreData:dictionary];
    }
    else if ([type isEqualToString:kRating])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFour = [arrContents objectAtIndex:3];
        strFour = [strFour stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFive = [arrContents objectAtIndex:4];
        strFive = [strFive stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strSix = [arrContents objectAtIndex:5];
        strSix = [strSix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"ratingId"];
        [dictionary setObject:strTwo forKey:@"ratingName"];
        [dictionary setObject:strThree forKey:@"parentId"];
        [dictionary setObject:strFour forKey:@"level"];
        [dictionary setObject:strFive forKey:@"isOptional"];
        [dictionary setObject:strSix forKey:@"deleted"];
        
        [CoreDataAdaptor saveRatingInCoreData:dictionary];
    }
    else if ([type isEqualToString:kServices])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFour = [arrContents objectAtIndex:3];
        strFour = [strFour stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFive = [arrContents objectAtIndex:4];
        strFive = [strFive stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"surveyTypeId"];
        [dictionary setObject:strTwo forKey:@"surveyTypeName"];
        [dictionary setObject:strThree forKey:@"level"];
        [dictionary setObject:strFour forKey:@"parentId"];
        [dictionary setObject:strFive forKey:@"deleted"];
        
        [CoreDataAdaptor saveSurveyTypeInCoreData:dictionary];
    }
    else if ([type isEqualToString:kPreferences])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"preferenceId"];
        [dictionary setObject:strTwo forKey:@"preferenceText"];
        [dictionary setObject:strThree forKey:@"deleted"];
        
        [CoreDataAdaptor savePreferencesInCoreData:dictionary];
    }
    else if ([type isEqualToString:kQuestions])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFour = [arrContents objectAtIndex:3];
        strFour = [strFour stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFive = [arrContents objectAtIndex:4];
        strFive = [strFive stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strSix = [arrContents objectAtIndex:5];
        strSix = [strSix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strSeven = [arrContents objectAtIndex:6];
        strSeven = [strSeven stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"questionId"];
        [dictionary setObject:strTwo forKey:@"questionTitle"];
        [dictionary setObject:strThree forKey:@"questionDescription"];
        [dictionary setObject:strFour forKey:@"questionType"];
        [dictionary setObject:strFive forKey:@"questionFormat"];
        [dictionary setObject:strSix forKey:@"optionCount"];
        [dictionary setObject:strSeven forKey:@"deleted"];
        
        [CoreDataAdaptor saveQuestionsInCoreData:dictionary];
    }
    else if ([type isEqualToString:kScoreMatrix])
    {
        NSString *strOne = [arrContents objectAtIndex:0];
        strOne = [strOne stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strTwo = [arrContents objectAtIndex:1];
        strTwo = [strTwo stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strThree = [arrContents objectAtIndex:2];
        strThree = [strThree stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFour = [arrContents objectAtIndex:3];
        strFour = [strFour stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strFive = [arrContents objectAtIndex:4];
        strFive = [strFive stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSString *strSix = [arrContents objectAtIndex:5];
        strSix = [strSix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *dictionary = [NSMutableDictionary new];
        [dictionary setObject:strOne forKey:@"scoreMatrixId"];
        [dictionary setObject:strTwo forKey:@"matrixTitle"];
        [dictionary setObject:strThree forKey:@"matrixDescription"];
        [dictionary setObject:strFour forKey:@"startRange"];
        [dictionary setObject:strFive forKey:@"endRange"];
        [dictionary setObject:strSix forKey:@"deleted"];
        
        [CoreDataAdaptor saveScoreMatrixInCoreData:dictionary];
    }
}

@end
