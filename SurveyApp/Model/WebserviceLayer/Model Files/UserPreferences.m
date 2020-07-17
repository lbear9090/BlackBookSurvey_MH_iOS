//
//  UserPreferences.m
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserPreferences.h"


NSString *const kUserPreferencesCreatedDate = @"created_date";
NSString *const kUserPreferencesId = @"id";
NSString *const kUserPreferencesModifiedDate = @"modified_date";
NSString *const kUserPreferencesIsDeleted = @"is_deleted";
NSString *const kUserPreferencesUserId = @"user_id";
NSString *const kUserPreferencesPreferenceId = @"preference_id";
NSString *const kUserPreferencesPreference = @"preference";


@interface UserPreferences ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserPreferences

@synthesize createdDate = _createdDate;
@synthesize userPreferenceId = _userPreferenceId;
@synthesize modifiedDate = _modifiedDate;
@synthesize isDeleted = _isDeleted;
@synthesize userId = _userId;
@synthesize preferenceId = _preferenceId;
@synthesize preference = _preference;


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
            self.createdDate = [self objectOrNilForKey:kUserPreferencesCreatedDate fromDictionary:dict];
            self.userPreferenceId = [self objectOrNilForKey:kUserPreferencesId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kUserPreferencesModifiedDate fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kUserPreferencesIsDeleted fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserPreferencesUserId fromDictionary:dict];
            self.preferenceId = [self objectOrNilForKey:kUserPreferencesPreferenceId fromDictionary:dict];
            self.preference = [self objectOrNilForKey:kUserPreferencesPreference fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kUserPreferencesCreatedDate];
    [mutableDict setValue:self.userPreferenceId forKey:kUserPreferencesId];
    [mutableDict setValue:self.modifiedDate forKey:kUserPreferencesModifiedDate];
    [mutableDict setValue:self.isDeleted forKey:kUserPreferencesIsDeleted];
    [mutableDict setValue:self.userId forKey:kUserPreferencesUserId];
    [mutableDict setValue:self.preferenceId forKey:kUserPreferencesPreferenceId];
    [mutableDict setValue:self.preference forKey:kUserPreferencesPreference];

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

    self.createdDate = [aDecoder decodeObjectForKey:kUserPreferencesCreatedDate];
    self.userPreferenceId = [aDecoder decodeObjectForKey:kUserPreferencesId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kUserPreferencesModifiedDate];
    self.isDeleted = [aDecoder decodeObjectForKey:kUserPreferencesIsDeleted];
    self.userId = [aDecoder decodeObjectForKey:kUserPreferencesUserId];
    self.preferenceId = [aDecoder decodeObjectForKey:kUserPreferencesPreferenceId];
    self.preference = [aDecoder decodeObjectForKey:kUserPreferencesPreference];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kUserPreferencesCreatedDate];
    [aCoder encodeObject:_userPreferenceId forKey:kUserPreferencesId];
    [aCoder encodeObject:_modifiedDate forKey:kUserPreferencesModifiedDate];
    [aCoder encodeObject:_isDeleted forKey:kUserPreferencesIsDeleted];
    [aCoder encodeObject:_userId forKey:kUserPreferencesUserId];
    [aCoder encodeObject:_preferenceId forKey:kUserPreferencesPreferenceId];
    [aCoder encodeObject:_preference forKey:kUserPreferencesPreference];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserPreferences *copy = [[UserPreferences alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.userPreferenceId = [self.userPreferenceId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.preferenceId = [self.preferenceId copyWithZone:zone];
        copy.preference = [self.preference copyWithZone:zone];
    }
    
    return copy;
}


@end
