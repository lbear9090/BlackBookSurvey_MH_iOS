//
//  Surveys.m
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Surveys.h"


NSString *const kSurveysId = @"id";
NSString *const kSurveysOrganizationTypeId = @"organization_type_id";
NSString *const kSurveysVendorId = @"vendor_id";
NSString *const kSurveysModifiedDate = @"modified_date";
NSString *const kSurveysScoreMatrixId = @"score_matrix_id";
NSString *const kSurveysSyncStatus = @"sync_status";
NSString *const kSurveysSurveyStatus = @"survey_status";
NSString *const kSurveysUserId = @"user_id";
NSString *const kSurveysCreatedDate = @"created_date";
NSString *const kSurveysSurveyTypeId = @"survey_type_id";
NSString *const kSurveysSurveyName = @"survey_name";
NSString *const kSurveysIsDeleted = @"is_deleted";
NSString *const kSurveysSurveyFeedback = @"survey_feedback";
NSString *const kSurveysRoleId = @"role_id";
NSString *const kSurveysSurveyScoreObtained = @"survey_score_obtained";


@interface Surveys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Surveys

@synthesize surveyId = _surveyId;
@synthesize organizationTypeId = _organizationTypeId;
@synthesize vendorId = _vendorId;
@synthesize modifiedDate = _modifiedDate;
@synthesize scoreMatrixId = _scoreMatrixId;
@synthesize syncStatus = _syncStatus;
@synthesize surveyStatus = _surveyStatus;
@synthesize userId = _userId;
@synthesize createdDate = _createdDate;
@synthesize surveyTypeId = _surveyTypeId;
@synthesize surveyName = _surveyName;
@synthesize isDeleted = _isDeleted;
@synthesize surveyFeedback = _surveyFeedback;
@synthesize roleId = _roleId;
@synthesize surveyScoreObtained = _surveyScoreObtained;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.surveyId = [self objectOrNilForKey:kSurveysId fromDictionary:dict];
            self.organizationTypeId = [self objectOrNilForKey:kSurveysOrganizationTypeId fromDictionary:dict];
            self.vendorId = [self objectOrNilForKey:kSurveysVendorId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kSurveysModifiedDate fromDictionary:dict];
            self.scoreMatrixId = [self objectOrNilForKey:kSurveysScoreMatrixId fromDictionary:dict];
            self.syncStatus = [self objectOrNilForKey:kSurveysSyncStatus fromDictionary:dict];
            self.surveyStatus = [self objectOrNilForKey:kSurveysSurveyStatus fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kSurveysUserId fromDictionary:dict];
            self.createdDate = [self objectOrNilForKey:kSurveysCreatedDate fromDictionary:dict];
            self.surveyTypeId = [self objectOrNilForKey:kSurveysSurveyTypeId fromDictionary:dict];
            self.surveyName = [self objectOrNilForKey:kSurveysSurveyName fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kSurveysIsDeleted fromDictionary:dict];
            self.surveyFeedback = [self objectOrNilForKey:kSurveysSurveyFeedback fromDictionary:dict];
            self.roleId = [self objectOrNilForKey:kSurveysRoleId fromDictionary:dict];
            self.surveyScoreObtained = [self objectOrNilForKey:kSurveysSurveyScoreObtained fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.surveyId forKey:kSurveysId];
    [mutableDict setValue:self.organizationTypeId forKey:kSurveysOrganizationTypeId];
    [mutableDict setValue:self.vendorId forKey:kSurveysVendorId];
    [mutableDict setValue:self.modifiedDate forKey:kSurveysModifiedDate];
    [mutableDict setValue:self.scoreMatrixId forKey:kSurveysScoreMatrixId];
    [mutableDict setValue:self.syncStatus forKey:kSurveysSyncStatus];
    [mutableDict setValue:self.surveyStatus forKey:kSurveysSurveyStatus];
    [mutableDict setValue:self.userId forKey:kSurveysUserId];
    [mutableDict setValue:self.createdDate forKey:kSurveysCreatedDate];
    [mutableDict setValue:self.surveyTypeId forKey:kSurveysSurveyTypeId];
    [mutableDict setValue:self.surveyName forKey:kSurveysSurveyName];
    [mutableDict setValue:self.isDeleted forKey:kSurveysIsDeleted];
    [mutableDict setValue:self.surveyFeedback forKey:kSurveysSurveyFeedback];
    [mutableDict setValue:self.roleId forKey:kSurveysRoleId];
    [mutableDict setValue:self.surveyScoreObtained forKey:kSurveysSurveyScoreObtained];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.surveyId = [aDecoder decodeObjectForKey:kSurveysId];
    self.organizationTypeId = [aDecoder decodeObjectForKey:kSurveysOrganizationTypeId];
    self.vendorId = [aDecoder decodeObjectForKey:kSurveysVendorId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kSurveysModifiedDate];
    self.scoreMatrixId = [aDecoder decodeObjectForKey:kSurveysScoreMatrixId];
    self.syncStatus = [aDecoder decodeObjectForKey:kSurveysSyncStatus];
    self.surveyStatus = [aDecoder decodeObjectForKey:kSurveysSurveyStatus];
    self.userId = [aDecoder decodeObjectForKey:kSurveysUserId];
    self.createdDate = [aDecoder decodeObjectForKey:kSurveysCreatedDate];
    self.surveyTypeId = [aDecoder decodeObjectForKey:kSurveysSurveyTypeId];
    self.surveyName = [aDecoder decodeObjectForKey:kSurveysSurveyName];
    self.isDeleted = [aDecoder decodeObjectForKey:kSurveysIsDeleted];
    self.surveyFeedback = [aDecoder decodeObjectForKey:kSurveysSurveyFeedback];
    self.roleId = [aDecoder decodeObjectForKey:kSurveysRoleId];
    self.surveyScoreObtained = [aDecoder decodeObjectForKey:kSurveysSurveyScoreObtained];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_surveyId forKey:kSurveysId];
    [aCoder encodeObject:_organizationTypeId forKey:kSurveysOrganizationTypeId];
    [aCoder encodeObject:_vendorId forKey:kSurveysVendorId];
    [aCoder encodeObject:_modifiedDate forKey:kSurveysModifiedDate];
    [aCoder encodeObject:_scoreMatrixId forKey:kSurveysScoreMatrixId];
    [aCoder encodeObject:_syncStatus forKey:kSurveysSyncStatus];
    [aCoder encodeObject:_surveyStatus forKey:kSurveysSurveyStatus];
    [aCoder encodeObject:_userId forKey:kSurveysUserId];
    [aCoder encodeObject:_createdDate forKey:kSurveysCreatedDate];
    [aCoder encodeObject:_surveyTypeId forKey:kSurveysSurveyTypeId];
    [aCoder encodeObject:_surveyName forKey:kSurveysSurveyName];
    [aCoder encodeObject:_isDeleted forKey:kSurveysIsDeleted];
    [aCoder encodeObject:_surveyFeedback forKey:kSurveysSurveyFeedback];
    [aCoder encodeObject:_roleId forKey:kSurveysRoleId];
    [aCoder encodeObject:_surveyScoreObtained forKey:kSurveysSurveyScoreObtained];
}

- (id)copyWithZone:(NSZone *)zone
{
    Surveys *copy = [[Surveys alloc] init];
    
    if (copy) {

        copy.surveyId = [self.surveyId copyWithZone:zone];
        copy.organizationTypeId = [self.organizationTypeId copyWithZone:zone];
        copy.vendorId = [self.vendorId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.scoreMatrixId = [self.scoreMatrixId copyWithZone:zone];
        copy.syncStatus = [self.syncStatus copyWithZone:zone];
        copy.surveyStatus = [self.surveyStatus copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.surveyTypeId = [self.surveyTypeId copyWithZone:zone];
        copy.surveyName = [self.surveyName copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
        copy.surveyFeedback = [self.surveyFeedback copyWithZone:zone];
        copy.roleId = [self.roleId copyWithZone:zone];
        copy.surveyScoreObtained = [self.surveyScoreObtained copyWithZone:zone];
    }
    
    return copy;
}


@end
