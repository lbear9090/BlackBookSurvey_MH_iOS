//
//  Preferences.m
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Preferences.h"


NSString *const kPreferencesCreatedDate = @"created_date";
NSString *const kPreferencesId = @"id";
NSString *const kPreferencesPreferenceText = @"preference_text";
NSString *const kPreferencesModifiedDate = @"modified_date";
NSString *const kPreferencesIsDeleted = @"is_deleted";


@interface Preferences ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Preferences

@synthesize createdDate = _createdDate;
@synthesize preferenceId = _preferenceId;
@synthesize preferenceText = _preferenceText;
@synthesize modifiedDate = _modifiedDate;
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
            self.createdDate = [self objectOrNilForKey:kPreferencesCreatedDate fromDictionary:dict];
            self.preferenceId = [self objectOrNilForKey:kPreferencesId fromDictionary:dict];
            self.preferenceText = [self objectOrNilForKey:kPreferencesPreferenceText fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kPreferencesModifiedDate fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kPreferencesIsDeleted fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kPreferencesCreatedDate];
    [mutableDict setValue:self.preferenceId forKey:kPreferencesId];
    [mutableDict setValue:self.preferenceText forKey:kPreferencesPreferenceText];
    [mutableDict setValue:self.modifiedDate forKey:kPreferencesModifiedDate];
    [mutableDict setValue:self.isDeleted forKey:kPreferencesIsDeleted];

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

    self.createdDate = [aDecoder decodeObjectForKey:kPreferencesCreatedDate];
    self.preferenceId = [aDecoder decodeObjectForKey:kPreferencesId];
    self.preferenceText = [aDecoder decodeObjectForKey:kPreferencesPreferenceText];
    self.modifiedDate = [aDecoder decodeObjectForKey:kPreferencesModifiedDate];
    self.isDeleted = [aDecoder decodeObjectForKey:kPreferencesIsDeleted];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kPreferencesCreatedDate];
    [aCoder encodeObject:_preferenceId forKey:kPreferencesId];
    [aCoder encodeObject:_preferenceText forKey:kPreferencesPreferenceText];
    [aCoder encodeObject:_modifiedDate forKey:kPreferencesModifiedDate];
    [aCoder encodeObject:_isDeleted forKey:kPreferencesIsDeleted];
}

- (id)copyWithZone:(NSZone *)zone
{
    Preferences *copy = [[Preferences alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.preferenceId = [self.preferenceId copyWithZone:zone];
        copy.preferenceText = [self.preferenceText copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
    }
    
    return copy;
}


@end
