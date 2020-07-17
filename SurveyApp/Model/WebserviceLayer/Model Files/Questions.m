//
//  Questions.m
//
//  Created by C111  on 17/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Questions.h"


NSString *const kQuestionsCreatedDate = @"created_date";
NSString *const kQuestionsQuestionTitle = @"question_title";
NSString *const kQuestionsQuestionFormat = @"question_format";
NSString *const kQuestionsId = @"id";
NSString *const kQuestionsModifiedDate = @"modified_date";
NSString *const kQuestionsQuestionDescription = @"question_description";
NSString *const kQuestionsIsDeleted = @"is_deleted";
NSString *const kQuestionsQuestionType = @"question_type";
NSString *const kQuestionsOptionCount = @"option_count";


@interface Questions ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Questions

@synthesize createdDate = _createdDate;
@synthesize questionTitle = _questionTitle;
@synthesize questionFormat = _questionFormat;
@synthesize questionId = _questionId;
@synthesize modifiedDate = _modifiedDate;
@synthesize questionDescription = _questionDescription;
@synthesize isDeleted = _isDeleted;
@synthesize questionType = _questionType;
@synthesize optionCount = _optionCount;
@synthesize userAnswer = _userAnswer;


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
            self.createdDate = [self objectOrNilForKey:kQuestionsCreatedDate fromDictionary:dict];
            self.questionTitle = [self objectOrNilForKey:kQuestionsQuestionTitle fromDictionary:dict];
            self.questionFormat = [self objectOrNilForKey:kQuestionsQuestionFormat fromDictionary:dict];
            self.questionId = [self objectOrNilForKey:kQuestionsId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kQuestionsModifiedDate fromDictionary:dict];
            self.questionDescription = [self objectOrNilForKey:kQuestionsQuestionDescription fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kQuestionsIsDeleted fromDictionary:dict];
            self.questionType = [self objectOrNilForKey:kQuestionsQuestionType fromDictionary:dict];
            self.optionCount = [self objectOrNilForKey:kQuestionsOptionCount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kQuestionsCreatedDate];
    [mutableDict setValue:self.questionTitle forKey:kQuestionsQuestionTitle];
    [mutableDict setValue:self.questionFormat forKey:kQuestionsQuestionFormat];
    [mutableDict setValue:self.questionId forKey:kQuestionsId];
    [mutableDict setValue:self.modifiedDate forKey:kQuestionsModifiedDate];
    [mutableDict setValue:self.questionDescription forKey:kQuestionsQuestionDescription];
    [mutableDict setValue:self.isDeleted forKey:kQuestionsIsDeleted];
    [mutableDict setValue:self.questionType forKey:kQuestionsQuestionType];
    [mutableDict setValue:self.optionCount forKey:kQuestionsOptionCount];

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

    self.createdDate = [aDecoder decodeObjectForKey:kQuestionsCreatedDate];
    self.questionTitle = [aDecoder decodeObjectForKey:kQuestionsQuestionTitle];
    self.questionFormat = [aDecoder decodeObjectForKey:kQuestionsQuestionFormat];
    self.questionId = [aDecoder decodeObjectForKey:kQuestionsId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kQuestionsModifiedDate];
    self.questionDescription = [aDecoder decodeObjectForKey:kQuestionsQuestionDescription];
    self.isDeleted = [aDecoder decodeObjectForKey:kQuestionsIsDeleted];
    self.questionType = [aDecoder decodeObjectForKey:kQuestionsQuestionType];
    self.optionCount = [aDecoder decodeObjectForKey:kQuestionsOptionCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kQuestionsCreatedDate];
    [aCoder encodeObject:_questionTitle forKey:kQuestionsQuestionTitle];
    [aCoder encodeObject:_questionFormat forKey:kQuestionsQuestionFormat];
    [aCoder encodeObject:_questionId forKey:kQuestionsId];
    [aCoder encodeObject:_modifiedDate forKey:kQuestionsModifiedDate];
    [aCoder encodeObject:_questionDescription forKey:kQuestionsQuestionDescription];
    [aCoder encodeObject:_isDeleted forKey:kQuestionsIsDeleted];
    [aCoder encodeObject:_questionType forKey:kQuestionsQuestionType];
    [aCoder encodeObject:_optionCount forKey:kQuestionsOptionCount];
}

- (id)copyWithZone:(NSZone *)zone
{
    Questions *copy = [[Questions alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.questionTitle = [self.questionTitle copyWithZone:zone];
        copy.questionFormat = [self.questionFormat copyWithZone:zone];
        copy.questionId = [self.questionId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.questionDescription = [self.questionDescription copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
        copy.questionType = [self.questionType copyWithZone:zone];
        copy.optionCount = [self.optionCount copyWithZone:zone];
    }
    
    return copy;
}


@end
