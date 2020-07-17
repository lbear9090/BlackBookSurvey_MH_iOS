//
//  CoreDataWrapper.h
//  NIPLiOSFramework
//
//  Created by Prerna on 5/21/15.
//  Copyright (c) 2015 Prerna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataAdaptor : NSObject

+ (void)SaveDataInCoreDB:(NSDictionary *)dict forEntity:(NSString *)entityname;
+ (void)deleteDataInCoreDB:(NSString *)entityname;

#pragma mark - SurveyType

+ (void)saveSurveyTypeInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchSurveyTypeFromCoreData:(NSString *)condition;

#pragma mark - Vendors

+ (void)saveVendorsInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchVendorsFromCoreData:(NSString *)condition;

#pragma mark - OrganizationType

+ (void)saveOrganizationTypeInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchOrganizationTypeFromCoreData:(NSString *)condition;

#pragma mark - Roles

+ (void)saveRolesInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchRolesFromCoreData:(NSString *)condition;

#pragma mark - Rating

+ (void)saveRatingInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchRatingFromCoreData:(NSString *)condition;


#pragma mark - ScoreMatrix

+ (void)saveScoreMatrixInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchScoreMatrixFromCoreData:(NSString *)condition;

#pragma mark - Preferences

+ (void)savePreferencesInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchPreferencesFromCoreData:(NSString *)condition;

#pragma mark - Questions

+ (void)saveQuestionsInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchQuestionsFromCoreData:(NSString *)condition;

#pragma mark - Surveys

+ (void)saveSurveysInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchSurveysFromCoreData:(NSString *)condition;

#pragma mark - SurveyResponse

+ (void)saveSurveyResponseInCoreData:(NSDictionary *)dictionary;
+ (NSArray *)fetchSurveyResponseFromCoreData:(NSString *)condition;

@end
