//
//  Rating.m
//
//  Created by C111  on 22/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Rating.h"


NSString *const kRatingCreatedDate = @"created_date";
NSString *const kRatingId = @"id";
NSString *const kRatingModifiedDate = @"modified_date";
NSString *const kRatingLevel = @"level";
NSString *const kRatingName = @"rate_name";
NSString *const kRatingParentId = @"parent_id";
NSString *const kRatingIsDeleted = @"is_deleted";


@interface Rating ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Rating

@synthesize createdDate = _createdDate;
@synthesize ratingId = _ratingId;
@synthesize modifiedDate = _modifiedDate;
@synthesize level = _level;
@synthesize ratingName = _ratingName;
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
            self.createdDate = [self objectOrNilForKey:kRatingCreatedDate fromDictionary:dict];
            self.ratingId = [self objectOrNilForKey:kRatingId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kRatingModifiedDate fromDictionary:dict];
            self.level = [self objectOrNilForKey:kRatingLevel fromDictionary:dict];
            self.ratingName = [self objectOrNilForKey:kRatingName fromDictionary:dict];
            self.parentId = [self objectOrNilForKey:kRatingParentId fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kRatingIsDeleted fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kRatingCreatedDate];
    [mutableDict setValue:self.ratingId forKey:kRatingId];
    [mutableDict setValue:self.modifiedDate forKey:kRatingModifiedDate];
    [mutableDict setValue:self.level forKey:kRatingLevel];
    [mutableDict setValue:self.ratingName forKey:kRatingName];
    [mutableDict setValue:self.parentId forKey:kRatingParentId];
    [mutableDict setValue:self.isDeleted forKey:kRatingIsDeleted];

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

    self.createdDate = [aDecoder decodeObjectForKey:kRatingCreatedDate];
    self.ratingId = [aDecoder decodeObjectForKey:kRatingId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kRatingModifiedDate];
    self.level = [aDecoder decodeObjectForKey:kRatingLevel];
    self.ratingName = [aDecoder decodeObjectForKey:kRatingName];
    self.parentId = [aDecoder decodeObjectForKey:kRatingParentId];
    self.isDeleted = [aDecoder decodeObjectForKey:kRatingIsDeleted];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kRatingCreatedDate];
    [aCoder encodeObject:_ratingId forKey:kRatingId];
    [aCoder encodeObject:_modifiedDate forKey:kRatingModifiedDate];
    [aCoder encodeObject:_level forKey:kRatingLevel];
    [aCoder encodeObject:_ratingName forKey:kRatingName];
    [aCoder encodeObject:_parentId forKey:kRatingParentId];
    [aCoder encodeObject:_isDeleted forKey:kRatingIsDeleted];
}

- (id)copyWithZone:(NSZone *)zone
{
    Rating *copy = [[Rating alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.ratingId = [self.ratingId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.level = [self.level copyWithZone:zone];
        copy.ratingName = [self.ratingName copyWithZone:zone];
        copy.parentId = [self.parentId copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
    }
    
    return copy;
}


@end
