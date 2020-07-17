//
//  WebHelper.m
//  SQLExample
//
//  Created by iMac on 17/03/14.
//  Copyright (c) 2014 Narola. All rights reserved.
//
//[[FamousFoodWS alloc]initWithDictionary:allvalues];
//[[classname alloc]initWithDictionary:allvalues];
//[[[NSClassFromString(classname) alloc] init] initWithDictionary:allvalues]

#import "WebServiceDataAdaptor.h"

#import "CoreDataAdaptor.h"
#import <objc/runtime.h>
#import "NSString+Extensions.h"

@implementation WebServiceDataAdaptor

@synthesize arrParsedData;

- (NSArray *)autoParse:(NSDictionary *)allValues forServiceName:(NSString *)requestURL
{
    arrParsedData = [NSArray new];
    
    if (isService(WSGetPredefinedData))
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^
        {
            arrParsedData = [self processJSONData:allValues forClass:SurveyTypeClass forEntity:SurveyTypeEntity withJSONKey:SurveyTypeKey];
            
            arrParsedData = [self processJSONData:allValues forClass:VendorsClass forEntity:VendorsEntity withJSONKey:VendorsKey];
            
            arrParsedData = [self processJSONData:allValues forClass:OrganizationTypeClass forEntity:OrganizationTypeEntity withJSONKey:OrganizationTypeKey];
            
            arrParsedData = [self processJSONData:allValues forClass:RolesClass forEntity:RolesEntity withJSONKey:RolesKey];
         
            arrParsedData = [self processJSONData:allValues forClass:RatingClass forEntity:RatingEntity withJSONKey:RatingKey];

            arrParsedData = [self processJSONData:allValues forClass:ScoreMatrixClass forEntity:ScoreMatrixEntity withJSONKey:ScoreMatrixKey];
            
            arrParsedData = [self processJSONData:allValues forClass:PreferencesClass forEntity:PreferencesEntity withJSONKey:PreferencesKey];
            
            arrParsedData = [self processJSONData:allValues forClass:QuestionsClass forEntity:QuestionsEntity withJSONKey:QuestionsKey];
        });
    }
    else if (isService(WSGetSurveyType))
    {
        arrParsedData = [self processJSONData:allValues forClass:SurveyTypeClass forEntity:SurveyTypeEntity withJSONKey:SurveyTypeKey];
    }
    else if (isService(WSGetVendors))
    {
        arrParsedData = [self processJSONData:allValues forClass:VendorsClass forEntity:VendorsEntity withJSONKey:VendorsKey];
    }
    else if (isService(WSGetOrganizationType))
    {
        arrParsedData = [self processJSONData:allValues forClass:OrganizationTypeClass forEntity:OrganizationTypeEntity withJSONKey:OrganizationTypeKey];
    }
    else if (isService(WSGetRoles))
    {
        arrParsedData = [self processJSONData:allValues forClass:RolesClass forEntity:RolesEntity withJSONKey:RolesKey];
    }
    else if (isService(WSGetRating))
    {
        arrParsedData = [self processJSONData:allValues forClass:RatingClass forEntity:RatingEntity withJSONKey:RatingKey];
    }
    else if (isService(WSGetScoreMatrix))
    {
        arrParsedData = [self processJSONData:allValues forClass:ScoreMatrixClass forEntity:ScoreMatrixEntity withJSONKey:ScoreMatrixKey];
    }
    else if (isService(WSGetPreferences))
    {
        arrParsedData = [self processJSONData:allValues forClass:PreferencesClass forEntity:PreferencesEntity withJSONKey:PreferencesKey];
    }
    else if (isService(WSGetKeyQuestions) || isService(WSGetLoyaltyQuestions))
    {
        arrParsedData = [self processJSONData:allValues forClass:QuestionsClass forEntity:QuestionsEntity withJSONKey:QuestionsKey];
    }
    
    return arrParsedData;
}

#pragma mark - Helper Method

- (void)processJSONToUserDefaults:(NSDictionary *)dict withJSONKeys:(NSMutableArray *)json_Keys
{
    /** this method will save the value of single key to user default. Modify this method to get multiple inner values of dict key or to return string from function **/
    for(int i =0;i<[json_Keys count];i++)
    {
        [Function setStringValueToUserDefaults:[Function getStringForKey:[json_Keys objectAtIndex:i] fromDictionary:dict] ForKey:[json_Keys objectAtIndex:i]];
    }
}

- (NSArray *)processJSONData:(NSDictionary *)dict forClass:(NSString *)classname forEntity:(NSString *)entityname withJSONKey:(NSString *)json_Key
{
    NSMutableArray *arrProcessedData = [NSMutableArray array];
    //[CoreDataAdaptor deleteDataInCoreDB:entityname];
    
    NSDictionary *dictionary = [dict objectForKey:@"Result"];
    
    for (int i =0;i<[[dictionary objectForKey:json_Key] count];i++)
    {
        NSDictionary *allvalues = [[dictionary objectForKey:json_Key] objectAtIndex:i];
        id objClass = [[[NSClassFromString(classname) alloc] init] initWithDictionary:allvalues];
        [arrProcessedData addObject:objClass];
        
        //    [CoreDataAdaptor SaveDataInCoreDB:[self processObjectForCoreData:objClass] forEntity:entityname];
        if (![Function stringIsEmpty:entityname])
        {
            if ([entityname isEqualToString:SurveyTypeEntity])
            {
                if ([[CoreDataAdaptor fetchSurveyTypeFromCoreData:[NSString stringWithFormat:@"surveyTypeId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor saveSurveyTypeInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    SurveyType *objWSSurveyType = objClass;
                    
                    CDSurveyType *objCDSurveyType = [[CoreDataAdaptor fetchSurveyTypeFromCoreData:[NSString stringWithFormat:@"surveyTypeId = %@", objWSSurveyType.surveyTypeId]] firstObject];
                    
                    objCDSurveyType.surveyTypeId = objWSSurveyType.surveyTypeId;
                    objCDSurveyType.surveyTypeName = objWSSurveyType.surveyTypeName;
                    objCDSurveyType.parentId = objWSSurveyType.parentId;
                    objCDSurveyType.createdDate = objWSSurveyType.createdDate;
                    objCDSurveyType.modifiedDate = objWSSurveyType.modifiedDate;
                    objCDSurveyType.deleted = [NSString stringWithFormat:@"%d", [objWSSurveyType.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }
            else if ([entityname isEqualToString:VendorsEntity])
            {
                if ([[CoreDataAdaptor fetchVendorsFromCoreData:[NSString stringWithFormat:@"vendorId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor saveVendorsInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    Vendors *objWSVendors = objClass;
                    
                    CDVendors *objCDVendors = [[CoreDataAdaptor fetchVendorsFromCoreData:[NSString stringWithFormat:@"vendorId = %@", objWSVendors.vendorId]] firstObject];
                    
                    objCDVendors.vendorId = objWSVendors.vendorId;
                    objCDVendors.vendorName = objWSVendors.vendorName;
                    objCDVendors.createdDate = objWSVendors.createdDate;
                    objCDVendors.modifiedDate = objWSVendors.modifiedDate;
                    objCDVendors.deleted = [NSString stringWithFormat:@"%d", [objWSVendors.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }
            else if ([entityname isEqualToString:OrganizationTypeEntity])
            {
                if ([[CoreDataAdaptor fetchOrganizationTypeFromCoreData:[NSString stringWithFormat:@"organizationTypeId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor saveOrganizationTypeInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    OrganizationType *objWSOrganizationType = objClass;
                    
                    CDOrganizationType *objCDOrganizationType = [[CoreDataAdaptor fetchOrganizationTypeFromCoreData:[NSString stringWithFormat:@"organizationTypeId = %@", objWSOrganizationType.organizationTypeId]] firstObject];
                    
                    objCDOrganizationType.organizationTypeId = objWSOrganizationType.organizationTypeId;
                    objCDOrganizationType.organizationTypeName = objWSOrganizationType.organizationTypeName;
                    objCDOrganizationType.level = objWSOrganizationType.level;
                    objCDOrganizationType.parentId = objWSOrganizationType.parentId;
                    objCDOrganizationType.isOptional = objWSOrganizationType.isOptional;
                    objCDOrganizationType.createdDate = objWSOrganizationType.createdDate;
                    objCDOrganizationType.modifiedDate = objWSOrganizationType.modifiedDate;
                    objCDOrganizationType.deleted = [NSString stringWithFormat:@"%d", [objWSOrganizationType.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }
            else if ([entityname isEqualToString:RolesEntity])
            {
                if ([[CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"roleId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor saveRolesInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    Roles *objWSRoles = objClass;
                    
                    CDRoles *objCDRoles = [[CoreDataAdaptor fetchRolesFromCoreData:[NSString stringWithFormat:@"roleId = %@", objWSRoles.roleId]] firstObject];
                    
                    objCDRoles.roleId = objWSRoles.roleId;
                    objCDRoles.roleName = objWSRoles.roleName;
                    objCDRoles.level = objWSRoles.level;
                    objCDRoles.parentId = objWSRoles.parentId;
                    objCDRoles.createdDate = objWSRoles.createdDate;
                    objCDRoles.modifiedDate = objWSRoles.modifiedDate;
                    objCDRoles.deleted = [NSString stringWithFormat:@"%d", [objWSRoles.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }else if ([entityname isEqualToString:RatingEntity])
            {
                if ([[CoreDataAdaptor fetchRatingFromCoreData:[NSString stringWithFormat:@"ratingId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor saveRatingInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    Rating *objWSRating = objClass;
                    
                    CDRating *objCDRating = [[CoreDataAdaptor fetchRatingFromCoreData:[NSString stringWithFormat:@"ratingId = %@", objWSRating.ratingId]] firstObject];
                    
                    objCDRating.ratingId = objWSRating.ratingId;
                    objCDRating.ratingName = objWSRating.ratingName;
                    objCDRating.level = objWSRating.level;
                    objCDRating.parentId = objWSRating.parentId;
                    objCDRating.createdDate = objWSRating.createdDate;
                    objCDRating.modifiedDate = objWSRating.modifiedDate;
                    objCDRating.deleted = [NSString stringWithFormat:@"%d", [objWSRating.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }
            else if ([entityname isEqualToString:ScoreMatrixEntity])
            {
                if ([[CoreDataAdaptor fetchScoreMatrixFromCoreData:[NSString stringWithFormat:@"scoreMatrixId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor saveScoreMatrixInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    ScoreMatrix *objWSScoreMatrix = objClass;
                    
                    CDScoreMatrix *objCDScoreMatrix = [[CoreDataAdaptor fetchScoreMatrixFromCoreData:[NSString stringWithFormat:@"scoreMatrixId = %@", objWSScoreMatrix.scoreMatrixId]] firstObject];

                    objCDScoreMatrix.scoreMatrixId = objWSScoreMatrix.scoreMatrixId;
                    objCDScoreMatrix.matrixTitle = objWSScoreMatrix.matrixTitle;
                    objCDScoreMatrix.matrixDescription = objWSScoreMatrix.matrixDescription;
                    objCDScoreMatrix.startRange = objWSScoreMatrix.startRange;
                    objCDScoreMatrix.endRange = objWSScoreMatrix.endRange;
                    objCDScoreMatrix.createdDate = objWSScoreMatrix.createdDate;
                    objCDScoreMatrix.modifiedDate = objWSScoreMatrix.modifiedDate;
                    objCDScoreMatrix.deleted = [NSString stringWithFormat:@"%d", [objWSScoreMatrix.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }
            else if ([entityname isEqualToString:PreferencesEntity])
            {
                if ([[CoreDataAdaptor fetchPreferencesFromCoreData:[NSString stringWithFormat:@"preferenceId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor savePreferencesInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    Preferences *objWSPreferences = objClass;
                    
                    CDPreferences *objCDPreferences = [[CoreDataAdaptor fetchPreferencesFromCoreData:[NSString stringWithFormat:@"preferenceId = %@", objWSPreferences.preferenceId]] firstObject];
                    
                    objCDPreferences.preferenceId = objWSPreferences.preferenceId;
                    objCDPreferences.preferenceText = objWSPreferences.preferenceText;
                    objCDPreferences.createdDate = objWSPreferences.createdDate;
                    objCDPreferences.modifiedDate = objWSPreferences.modifiedDate;
                    objCDPreferences.deleted = [NSString stringWithFormat:@"%d", [objWSPreferences.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }
            else if ([entityname isEqualToString:QuestionsEntity])
            {
                if ([[CoreDataAdaptor fetchQuestionsFromCoreData:[NSString stringWithFormat:@"questionId = %@", [allvalues valueForKey:@"id"]]] count] == 0)
                {
                    [CoreDataAdaptor saveQuestionsInCoreData:[self processObjectForCoreData:objClass]];
                }
                else
                {
                    Questions *objWSQuestions = objClass;
                    
                    CDQuestions *objCDQuestions = [[CoreDataAdaptor fetchQuestionsFromCoreData:[NSString stringWithFormat:@"questionId = %@", objWSQuestions.questionId]] firstObject];
                    
                    objCDQuestions.questionId = objWSQuestions.questionId;
                    objCDQuestions.questionTitle = objWSQuestions.questionTitle;
                    objCDQuestions.questionDescription = objWSQuestions.questionDescription;
                    objCDQuestions.questionFormat = objWSQuestions.questionFormat;
                    objCDQuestions.questionType = objWSQuestions.questionType;
                    objCDQuestions.optionCount = objWSQuestions.optionCount;
                    objCDQuestions.createdDate = objWSQuestions.createdDate;
                    objCDQuestions.modifiedDate = objWSQuestions.modifiedDate;
                    objCDQuestions.deleted = [NSString stringWithFormat:@"%d", [objWSQuestions.isDeleted intValue]];
                    
                    [CoreDataHelper save];
                }
            }
        }
    }
    
    return arrProcessedData;
}

- (NSDictionary *)processObjectForCoreData:(id)obj
{
    NSArray *aVoidArray =@[@"NSDate"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    for (int i = 0; i < count; i++)
    {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        if (![aVoidArray containsObject: key] )
        {
            if ([obj valueForKey:key]!=nil)
            {
                [dict setObject:[obj valueForKey:key] forKey:key];
            }
        }
    }
    
    [dict setObject:[obj valueForKey:@"isDeleted"] forKey:@"deleted"];
    
    return dict;
}

@end
