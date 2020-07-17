//
//  SurveyType.m
//
//  Created by C111  on 22/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SurveyType.h"


NSString *const kSurveyTypeCreatedDate = @"created_date";
NSString *const kSurveyTypeId = @"id";
NSString *const kSurveyTypeModifiedDate = @"modified_date";
NSString *const kSurveyTypeLevel = @"level";
NSString *const kSurveyTypeSurveyTypeName = @"survey_type_name";
NSString *const kSurveyTypeParentId = @"parent_id";
NSString *const kSurveyTypeIsDeleted = @"is_deleted";


@interface SurveyType ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SurveyType

@synthesize createdDate = _createdDate;
@synthesize surveyTypeId = _surveyTypeId;
@synthesize modifiedDate = _modifiedDate;
@synthesize level = _level;
@synthesize surveyTypeName = _surveyTypeName;
@synthesize parentId = _parentId;
@synthesize isDeleted = _isDeleted;


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
            self.createdDate = [self objectOrNilForKey:kSurveyTypeCreatedDate fromDictionary:dict];
            self.surveyTypeId = [self objectOrNilForKey:kSurveyTypeId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kSurveyTypeModifiedDate fromDictionary:dict];
            self.level = [self objectOrNilForKey:kSurveyTypeLevel fromDictionary:dict];
            self.surveyTypeName = [self objectOrNilForKey:kSurveyTypeSurveyTypeName fromDictionary:dict];
            self.parentId = [self objectOrNilForKey:kSurveyTypeParentId fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kSurveyTypeIsDeleted fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kSurveyTypeCreatedDate];
    [mutableDict setValue:self.surveyTypeId forKey:kSurveyTypeId];
    [mutableDict setValue:self.modifiedDate forKey:kSurveyTypeModifiedDate];
    [mutableDict setValue:self.level forKey:kSurveyTypeLevel];
    [mutableDict setValue:self.surveyTypeName forKey:kSurveyTypeSurveyTypeName];
    [mutableDict setValue:self.parentId forKey:kSurveyTypeParentId];
    [mutableDict setValue:self.isDeleted forKey:kSurveyTypeIsDeleted];

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

    self.createdDate = [aDecoder decodeObjectForKey:kSurveyTypeCreatedDate];
    self.surveyTypeId = [aDecoder decodeObjectForKey:kSurveyTypeId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kSurveyTypeModifiedDate];
    self.level = [aDecoder decodeObjectForKey:kSurveyTypeLevel];
    self.surveyTypeName = [aDecoder decodeObjectForKey:kSurveyTypeSurveyTypeName];
    self.parentId = [aDecoder decodeObjectForKey:kSurveyTypeParentId];
    self.isDeleted = [aDecoder decodeObjectForKey:kSurveyTypeIsDeleted];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kSurveyTypeCreatedDate];
    [aCoder encodeObject:_surveyTypeId forKey:kSurveyTypeId];
    [aCoder encodeObject:_modifiedDate forKey:kSurveyTypeModifiedDate];
    [aCoder encodeObject:_level forKey:kSurveyTypeLevel];
    [aCoder encodeObject:_surveyTypeName forKey:kSurveyTypeSurveyTypeName];
    [aCoder encodeObject:_parentId forKey:kSurveyTypeParentId];
    [aCoder encodeObject:_isDeleted forKey:kSurveyTypeIsDeleted];
}

- (id)copyWithZone:(NSZone *)zone
{
    SurveyType *copy = [[SurveyType alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.surveyTypeId = [self.surveyTypeId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.level = [self.level copyWithZone:zone];
        copy.surveyTypeName = [self.surveyTypeName copyWithZone:zone];
        copy.parentId = [self.parentId copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
    }
    
    return copy;
}


@end
