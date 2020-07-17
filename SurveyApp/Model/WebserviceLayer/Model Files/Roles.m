//
//  Roles.m
//
//  Created by C111  on 22/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Roles.h"


NSString *const kRolesCreatedDate = @"created_date";
NSString *const kRolesId = @"id";
NSString *const kRolesModifiedDate = @"modified_date";
NSString *const kRolesLevel = @"level";
NSString *const kRolesRoleName = @"role_name";
NSString *const kRolesParentId = @"parent_id";
NSString *const kRolesIsDeleted = @"is_deleted";


@interface Roles ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Roles

@synthesize createdDate = _createdDate;
@synthesize roleId = _roleId;
@synthesize modifiedDate = _modifiedDate;
@synthesize level = _level;
@synthesize roleName = _roleName;
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
            self.createdDate = [self objectOrNilForKey:kRolesCreatedDate fromDictionary:dict];
            self.roleId = [self objectOrNilForKey:kRolesId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kRolesModifiedDate fromDictionary:dict];
            self.level = [self objectOrNilForKey:kRolesLevel fromDictionary:dict];
            self.roleName = [self objectOrNilForKey:kRolesRoleName fromDictionary:dict];
            self.parentId = [self objectOrNilForKey:kRolesParentId fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kRolesIsDeleted fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kRolesCreatedDate];
    [mutableDict setValue:self.roleId forKey:kRolesId];
    [mutableDict setValue:self.modifiedDate forKey:kRolesModifiedDate];
    [mutableDict setValue:self.level forKey:kRolesLevel];
    [mutableDict setValue:self.roleName forKey:kRolesRoleName];
    [mutableDict setValue:self.parentId forKey:kRolesParentId];
    [mutableDict setValue:self.isDeleted forKey:kRolesIsDeleted];

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

    self.createdDate = [aDecoder decodeObjectForKey:kRolesCreatedDate];
    self.roleId = [aDecoder decodeObjectForKey:kRolesId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kRolesModifiedDate];
    self.level = [aDecoder decodeObjectForKey:kRolesLevel];
    self.roleName = [aDecoder decodeObjectForKey:kRolesRoleName];
    self.parentId = [aDecoder decodeObjectForKey:kRolesParentId];
    self.isDeleted = [aDecoder decodeObjectForKey:kRolesIsDeleted];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kRolesCreatedDate];
    [aCoder encodeObject:_roleId forKey:kRolesId];
    [aCoder encodeObject:_modifiedDate forKey:kRolesModifiedDate];
    [aCoder encodeObject:_level forKey:kRolesLevel];
    [aCoder encodeObject:_roleName forKey:kRolesRoleName];
    [aCoder encodeObject:_parentId forKey:kRolesParentId];
    [aCoder encodeObject:_isDeleted forKey:kRolesIsDeleted];
}

- (id)copyWithZone:(NSZone *)zone
{
    Roles *copy = [[Roles alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.roleId = [self.roleId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.level = [self.level copyWithZone:zone];
        copy.roleName = [self.roleName copyWithZone:zone];
        copy.parentId = [self.parentId copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
    }
    
    return copy;
}


@end
