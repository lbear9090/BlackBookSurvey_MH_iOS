//
//  SurveyResponse.m
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "SurveyResponse.h"


NSString *const kSurveyResponseCreatedDate = @"created_date";
NSString *const kSurveyResponseId = @"id";
NSString *const kSurveyResponseModifiedDate = @"modified_date";
NSString *const kSurveyResponseResponseText = @"response_text";
NSString *const kSurveyResponseQuestionId = @"question_id";
NSString *const kSurveyResponseIsDeleted = @"is_deleted";
NSString *const kSurveyResponseSurveyId = @"survey_id";


@interface SurveyResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SurveyResponse

@synthesize createdDate = _createdDate;
@synthesize surveyResponseId = _surveyResponseId;
@synthesize modifiedDate = _modifiedDate;
@synthesize responseText = _responseText;
@synthesize questionId = _questionId;
@synthesize isDeleted = _isDeleted;
@synthesize surveyId = _surveyId;


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
            self.createdDate = [self objectOrNilForKey:kSurveyResponseCreatedDate fromDictionary:dict];
            self.surveyResponseId = [self objectOrNilForKey:kSurveyResponseId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kSurveyResponseModifiedDate fromDictionary:dict];
            self.responseText = [self objectOrNilForKey:kSurveyResponseResponseText fromDictionary:dict];
            self.questionId = [self objectOrNilForKey:kSurveyResponseQuestionId fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kSurveyResponseIsDeleted fromDictionary:dict];
            self.surveyId = [self objectOrNilForKey:kSurveyResponseSurveyId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kSurveyResponseCreatedDate];
    [mutableDict setValue:self.surveyResponseId forKey:kSurveyResponseId];
    [mutableDict setValue:self.modifiedDate forKey:kSurveyResponseModifiedDate];
    [mutableDict setValue:self.responseText forKey:kSurveyResponseResponseText];
    [mutableDict setValue:self.questionId forKey:kSurveyResponseQuestionId];
    [mutableDict setValue:self.isDeleted forKey:kSurveyResponseIsDeleted];
    [mutableDict setValue:self.surveyId forKey:kSurveyResponseSurveyId];

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

    self.createdDate = [aDecoder decodeObjectForKey:kSurveyResponseCreatedDate];
    self.surveyResponseId = [aDecoder decodeObjectForKey:kSurveyResponseId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kSurveyResponseModifiedDate];
    self.responseText = [aDecoder decodeObjectForKey:kSurveyResponseResponseText];
    self.questionId = [aDecoder decodeObjectForKey:kSurveyResponseQuestionId];
    self.isDeleted = [aDecoder decodeObjectForKey:kSurveyResponseIsDeleted];
    self.surveyId = [aDecoder decodeObjectForKey:kSurveyResponseSurveyId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kSurveyResponseCreatedDate];
    [aCoder encodeObject:_surveyResponseId forKey:kSurveyResponseId];
    [aCoder encodeObject:_modifiedDate forKey:kSurveyResponseModifiedDate];
    [aCoder encodeObject:_responseText forKey:kSurveyResponseResponseText];
    [aCoder encodeObject:_questionId forKey:kSurveyResponseQuestionId];
    [aCoder encodeObject:_isDeleted forKey:kSurveyResponseIsDeleted];
    [aCoder encodeObject:_surveyId forKey:kSurveyResponseSurveyId];
}

- (id)copyWithZone:(NSZone *)zone
{
    SurveyResponse *copy = [[SurveyResponse alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.surveyResponseId = [self.surveyResponseId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.responseText = [self.responseText copyWithZone:zone];
        copy.questionId = [self.questionId copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
        copy.surveyId = [self.surveyId copyWithZone:zone];
    }
    
    return copy;
}


@end
