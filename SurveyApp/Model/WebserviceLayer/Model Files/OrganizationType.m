//
//  OrganizationType.m
//
//  Created by C111  on 22/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OrganizationType.h"


NSString *const kOrganizationTypeCreatedDate = @"created_date";
NSString *const kOrganizationTypeIsOptional = @"is_optional";
NSString *const kOrganizationTypeId = @"id";
NSString *const kOrganizationTypeModifiedDate = @"modified_date";
NSString *const kOrganizationTypeLevel = @"level";
NSString *const kOrganizationTypeParentId = @"parent_id";
NSString *const kOrganizationTypeOrganizationTypeName = @"organization_type_name";
NSString *const kOrganizationTypeIsDeleted = @"is_deleted";


@interface OrganizationType ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrganizationType

@synthesize createdDate = _createdDate;
@synthesize isOptional = _isOptional;
@synthesize organizationTypeId = _organizationTypeId;
@synthesize modifiedDate = _modifiedDate;
@synthesize level = _level;
@synthesize parentId = _parentId;
@synthesize organizationTypeName = _organizationTypeName;
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
            self.createdDate = [self objectOrNilForKey:kOrganizationTypeCreatedDate fromDictionary:dict];
            self.isOptional = [self objectOrNilForKey:kOrganizationTypeIsOptional fromDictionary:dict];
            self.organizationTypeId = [self objectOrNilForKey:kOrganizationTypeId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kOrganizationTypeModifiedDate fromDictionary:dict];
            self.level = [self objectOrNilForKey:kOrganizationTypeLevel fromDictionary:dict];
            self.parentId = [self objectOrNilForKey:kOrganizationTypeParentId fromDictionary:dict];
            self.organizationTypeName = [self objectOrNilForKey:kOrganizationTypeOrganizationTypeName fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kOrganizationTypeIsDeleted fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kOrganizationTypeCreatedDate];
    [mutableDict setValue:self.isOptional forKey:kOrganizationTypeIsOptional];
    [mutableDict setValue:self.organizationTypeId forKey:kOrganizationTypeId];
    [mutableDict setValue:self.modifiedDate forKey:kOrganizationTypeModifiedDate];
    [mutableDict setValue:self.level forKey:kOrganizationTypeLevel];
    [mutableDict setValue:self.parentId forKey:kOrganizationTypeParentId];
    [mutableDict setValue:self.organizationTypeName forKey:kOrganizationTypeOrganizationTypeName];
    [mutableDict setValue:self.isDeleted forKey:kOrganizationTypeIsDeleted];

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

    self.createdDate = [aDecoder decodeObjectForKey:kOrganizationTypeCreatedDate];
    self.isOptional = [aDecoder decodeObjectForKey:kOrganizationTypeIsOptional];
    self.organizationTypeId = [aDecoder decodeObjectForKey:kOrganizationTypeId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kOrganizationTypeModifiedDate];
    self.level = [aDecoder decodeObjectForKey:kOrganizationTypeLevel];
    self.parentId = [aDecoder decodeObjectForKey:kOrganizationTypeParentId];
    self.organizationTypeName = [aDecoder decodeObjectForKey:kOrganizationTypeOrganizationTypeName];
    self.isDeleted = [aDecoder decodeObjectForKey:kOrganizationTypeIsDeleted];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kOrganizationTypeCreatedDate];
    [aCoder encodeObject:_isOptional forKey:kOrganizationTypeIsOptional];
    [aCoder encodeObject:_organizationTypeId forKey:kOrganizationTypeId];
    [aCoder encodeObject:_modifiedDate forKey:kOrganizationTypeModifiedDate];
    [aCoder encodeObject:_level forKey:kOrganizationTypeLevel];
    [aCoder encodeObject:_parentId forKey:kOrganizationTypeParentId];
    [aCoder encodeObject:_organizationTypeName forKey:kOrganizationTypeOrganizationTypeName];
    [aCoder encodeObject:_isDeleted forKey:kOrganizationTypeIsDeleted];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrganizationType *copy = [[OrganizationType alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.isOptional = [self.isOptional copyWithZone:zone];
        copy.organizationTypeId = [self.organizationTypeId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.level = [self.level copyWithZone:zone];
        copy.parentId = [self.parentId copyWithZone:zone];
        copy.organizationTypeName = [self.organizationTypeName copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
    }
    
    return copy;
}


@end
