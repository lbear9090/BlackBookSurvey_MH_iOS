//
//  ScoreMatrix.m
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ScoreMatrix.h"


NSString *const kScoreMatrixCreatedDate = @"created_date";
NSString *const kScoreMatrixId = @"id";
NSString *const kScoreMatrixMatrixTitle = @"matrix_title";
NSString *const kScoreMatrixStartRange = @"start_range";
NSString *const kScoreMatrixModifiedDate = @"modified_date";
NSString *const kScoreMatrixIsDeleted = @"is_deleted";
NSString *const kScoreMatrixMatrixDescription = @"matrix_description";
NSString *const kScoreMatrixEndRange = @"end_range";


@interface ScoreMatrix ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ScoreMatrix

@synthesize createdDate = _createdDate;
@synthesize scoreMatrixId = _scoreMatrixId;
@synthesize matrixTitle = _matrixTitle;
@synthesize startRange = _startRange;
@synthesize modifiedDate = _modifiedDate;
@synthesize isDeleted = _isDeleted;
@synthesize matrixDescription = _matrixDescription;
@synthesize endRange = _endRange;


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
            self.createdDate = [self objectOrNilForKey:kScoreMatrixCreatedDate fromDictionary:dict];
            self.scoreMatrixId = [self objectOrNilForKey:kScoreMatrixId fromDictionary:dict];
            self.matrixTitle = [self objectOrNilForKey:kScoreMatrixMatrixTitle fromDictionary:dict];
            self.startRange = [self objectOrNilForKey:kScoreMatrixStartRange fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kScoreMatrixModifiedDate fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kScoreMatrixIsDeleted fromDictionary:dict];
            self.matrixDescription = [self objectOrNilForKey:kScoreMatrixMatrixDescription fromDictionary:dict];
            self.endRange = [self objectOrNilForKey:kScoreMatrixEndRange fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kScoreMatrixCreatedDate];
    [mutableDict setValue:self.scoreMatrixId forKey:kScoreMatrixId];
    [mutableDict setValue:self.matrixTitle forKey:kScoreMatrixMatrixTitle];
    [mutableDict setValue:self.startRange forKey:kScoreMatrixStartRange];
    [mutableDict setValue:self.modifiedDate forKey:kScoreMatrixModifiedDate];
    [mutableDict setValue:self.isDeleted forKey:kScoreMatrixIsDeleted];
    [mutableDict setValue:self.matrixDescription forKey:kScoreMatrixMatrixDescription];
    [mutableDict setValue:self.endRange forKey:kScoreMatrixEndRange];

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

    self.createdDate = [aDecoder decodeObjectForKey:kScoreMatrixCreatedDate];
    self.scoreMatrixId = [aDecoder decodeObjectForKey:kScoreMatrixId];
    self.matrixTitle = [aDecoder decodeObjectForKey:kScoreMatrixMatrixTitle];
    self.startRange = [aDecoder decodeObjectForKey:kScoreMatrixStartRange];
    self.modifiedDate = [aDecoder decodeObjectForKey:kScoreMatrixModifiedDate];
    self.isDeleted = [aDecoder decodeObjectForKey:kScoreMatrixIsDeleted];
    self.matrixDescription = [aDecoder decodeObjectForKey:kScoreMatrixMatrixDescription];
    self.endRange = [aDecoder decodeObjectForKey:kScoreMatrixEndRange];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kScoreMatrixCreatedDate];
    [aCoder encodeObject:_scoreMatrixId forKey:kScoreMatrixId];
    [aCoder encodeObject:_matrixTitle forKey:kScoreMatrixMatrixTitle];
    [aCoder encodeObject:_startRange forKey:kScoreMatrixStartRange];
    [aCoder encodeObject:_modifiedDate forKey:kScoreMatrixModifiedDate];
    [aCoder encodeObject:_isDeleted forKey:kScoreMatrixIsDeleted];
    [aCoder encodeObject:_matrixDescription forKey:kScoreMatrixMatrixDescription];
    [aCoder encodeObject:_endRange forKey:kScoreMatrixEndRange];
}

- (id)copyWithZone:(NSZone *)zone
{
    ScoreMatrix *copy = [[ScoreMatrix alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.scoreMatrixId = [self.scoreMatrixId copyWithZone:zone];
        copy.matrixTitle = [self.matrixTitle copyWithZone:zone];
        copy.startRange = [self.startRange copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
        copy.matrixDescription = [self.matrixDescription copyWithZone:zone];
        copy.endRange = [self.endRange copyWithZone:zone];
    }
    
    return copy;
}


@end
