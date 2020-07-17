//
//  CoreDataWrapper.m
//  NIPLiOSFramework
//
//  Created by Prerna on 5/21/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import "CoreDataAdaptor.h"

#import "CoreDataHelper.h"

NSFetchedResultsController *fetchedResultController;

@implementation CoreDataAdaptor

#pragma mark - Helper Methods

+ (void)SaveDataInCoreDB:(NSDictionary *)dict forEntity:(NSString *)entityname
{
    [[[NSClassFromString(entityname) create] insert:dict]save];
}

+ (void)deleteDataInCoreDB:(NSString *)entityname
{
    //  [NSClassFromString(entityname) clear:[NSPredicate predicateWithFormat:@"landmark = 'Iscon Mall'"]];
}

#pragma mark - SurveyType

+ (void)saveSurveyTypeInCoreData:(NSDictionary *)dictionary
{
    [[[CDSurveyType create] insert:dictionary] save];
}

+ (NSArray *)fetchSurveyTypeFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDSurveyType query] where:condition] all];
    return array;
}

#pragma mark - Vendors

+ (void)saveVendorsInCoreData:(NSDictionary *)dictionary
{
    [[[CDVendors create] insert:dictionary] save];
}

+ (NSArray *)fetchVendorsFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDVendors query] where:condition] all];
    return array;
}

#pragma mark - OrganizationType

+ (void)saveOrganizationTypeInCoreData:(NSDictionary *)dictionary
{
    [[[CDOrganizationType create] insert:dictionary] save];
}

+ (NSArray *)fetchOrganizationTypeFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDOrganizationType query] where:condition] all];
    return array;
}

#pragma mark - Roles

+ (void)saveRolesInCoreData:(NSDictionary *)dictionary
{
    [[[CDRoles create] insert:dictionary] save];
}

+ (NSArray *)fetchRolesFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDRoles query] where:condition] all];
    return array;
}
#pragma mark - Rating

+ (void)saveRatingInCoreData:(NSDictionary *)dictionary
{
    [[[CDRating create] insert:dictionary] save];
}

+ (NSArray *)fetchRatingFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDRating query] where:condition] all];
    return array;
}

#pragma mark - ScoreMatrix

+ (void)saveScoreMatrixInCoreData:(NSDictionary *)dictionary
{
    [[[CDScoreMatrix create] insert:dictionary] save];
}

+ (NSArray *)fetchScoreMatrixFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDScoreMatrix query] where:condition] all];
    return array;
}

#pragma mark - Preferences

+ (void)savePreferencesInCoreData:(NSDictionary *)dictionary
{
    [[[CDPreferences create] insert:dictionary] save];
}

+ (NSArray *)fetchPreferencesFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDPreferences query] where:condition] all];
    return array;
}

#pragma mark - Questions

+ (void)saveQuestionsInCoreData:(NSDictionary *)dictionary
{
    [[[CDQuestions create] insert:dictionary] save];
}

+ (NSArray *)fetchQuestionsFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDQuestions query] where:condition] all];
    return array;
}

#pragma mark - Surveys

+ (void)saveSurveysInCoreData:(NSDictionary *)dictionary
{
    [[[CDSurveys create] insert:dictionary] save];
}

+ (NSArray *)fetchSurveysFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDSurveys query] where:condition] all];
    return array;
}

#pragma mark - SurveyResponse

+ (void)saveSurveyResponseInCoreData:(NSDictionary *)dictionary
{
    [[[CDSurveyResponse create] insert:dictionary] save];
}

+ (NSArray *)fetchSurveyResponseFromCoreData:(NSString *)condition
{
    NSArray *array = [[[CDSurveyResponse query] where:condition] all];
    return array;
}

@end
