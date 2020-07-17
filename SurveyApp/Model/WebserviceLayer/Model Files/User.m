//
//  User.m
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "User.h"


NSString *const kUserId = @"id";
NSString *const kUserOrganizationTypeId = @"organization_type_id";
NSString *const kUserEmailId = @"email_id";
NSString *const kUserModifiedDate = @"modified_date";
NSString *const kUserPhoneNumber = @"phone_number";
NSString *const kUserLastname = @"lastname";
NSString *const kUserCreatedDate = @"created_date";
NSString *const kUserFirstname = @"firstname";
NSString *const kUserDeviceType = @"device_type";
NSString *const kUserPassword = @"password";
NSString *const kUserDeviceToken = @"device_token";
NSString *const kUserUsername = @"username";
NSString *const kUserIsDeleted = @"is_deleted";
NSString *const kUserRoleId = @"role_id";


@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize userId = _userId;
@synthesize organizationTypeId = _organizationTypeId;
@synthesize emailId = _emailId;
@synthesize modifiedDate = _modifiedDate;
@synthesize phoneNumber = _phoneNumber;
@synthesize lastname = _lastname;
@synthesize createdDate = _createdDate;
@synthesize firstname = _firstname;
@synthesize deviceType = _deviceType;
@synthesize password = _password;
@synthesize deviceToken = _deviceToken;
@synthesize username = _username;
@synthesize isDeleted = _isDeleted;
@synthesize roleId = _roleId;


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
            self.userId = [self objectOrNilForKey:kUserId fromDictionary:dict];
            self.organizationTypeId = [self objectOrNilForKey:kUserOrganizationTypeId fromDictionary:dict];
            self.emailId = [self objectOrNilForKey:kUserEmailId fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kUserModifiedDate fromDictionary:dict];
            self.phoneNumber = [self objectOrNilForKey:kUserPhoneNumber fromDictionary:dict];
            self.lastname = [self objectOrNilForKey:kUserLastname fromDictionary:dict];
            self.createdDate = [self objectOrNilForKey:kUserCreatedDate fromDictionary:dict];
            self.firstname = [self objectOrNilForKey:kUserFirstname fromDictionary:dict];
            self.deviceType = [self objectOrNilForKey:kUserDeviceType fromDictionary:dict];
            self.password = [self objectOrNilForKey:kUserPassword fromDictionary:dict];
            self.deviceToken = [self objectOrNilForKey:kUserDeviceToken fromDictionary:dict];
            self.username = [self objectOrNilForKey:kUserUsername fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kUserIsDeleted fromDictionary:dict];
            self.roleId = [self objectOrNilForKey:kUserRoleId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kUserId];
    [mutableDict setValue:self.organizationTypeId forKey:kUserOrganizationTypeId];
    [mutableDict setValue:self.emailId forKey:kUserEmailId];
    [mutableDict setValue:self.modifiedDate forKey:kUserModifiedDate];
    [mutableDict setValue:self.phoneNumber forKey:kUserPhoneNumber];
    [mutableDict setValue:self.lastname forKey:kUserLastname];
    [mutableDict setValue:self.createdDate forKey:kUserCreatedDate];
    [mutableDict setValue:self.firstname forKey:kUserFirstname];
    [mutableDict setValue:self.deviceType forKey:kUserDeviceType];
    [mutableDict setValue:self.password forKey:kUserPassword];
    [mutableDict setValue:self.deviceToken forKey:kUserDeviceToken];
    [mutableDict setValue:self.username forKey:kUserUsername];
    [mutableDict setValue:self.isDeleted forKey:kUserIsDeleted];
    [mutableDict setValue:self.roleId forKey:kUserRoleId];

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

    self.userId = [aDecoder decodeObjectForKey:kUserId];
    self.organizationTypeId = [aDecoder decodeObjectForKey:kUserOrganizationTypeId];
    self.emailId = [aDecoder decodeObjectForKey:kUserEmailId];
    self.modifiedDate = [aDecoder decodeObjectForKey:kUserModifiedDate];
    self.phoneNumber = [aDecoder decodeObjectForKey:kUserPhoneNumber];
    self.lastname = [aDecoder decodeObjectForKey:kUserLastname];
    self.createdDate = [aDecoder decodeObjectForKey:kUserCreatedDate];
    self.firstname = [aDecoder decodeObjectForKey:kUserFirstname];
    self.deviceType = [aDecoder decodeObjectForKey:kUserDeviceType];
    self.password = [aDecoder decodeObjectForKey:kUserPassword];
    self.deviceToken = [aDecoder decodeObjectForKey:kUserDeviceToken];
    self.username = [aDecoder decodeObjectForKey:kUserUsername];
    self.isDeleted = [aDecoder decodeObjectForKey:kUserIsDeleted];
    self.roleId = [aDecoder decodeObjectForKey:kUserRoleId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kUserId];
    [aCoder encodeObject:_organizationTypeId forKey:kUserOrganizationTypeId];
    [aCoder encodeObject:_emailId forKey:kUserEmailId];
    [aCoder encodeObject:_modifiedDate forKey:kUserModifiedDate];
    [aCoder encodeObject:_phoneNumber forKey:kUserPhoneNumber];
    [aCoder encodeObject:_lastname forKey:kUserLastname];
    [aCoder encodeObject:_createdDate forKey:kUserCreatedDate];
    [aCoder encodeObject:_firstname forKey:kUserFirstname];
    [aCoder encodeObject:_deviceType forKey:kUserDeviceType];
    [aCoder encodeObject:_password forKey:kUserPassword];
    [aCoder encodeObject:_deviceToken forKey:kUserDeviceToken];
    [aCoder encodeObject:_username forKey:kUserUsername];
    [aCoder encodeObject:_isDeleted forKey:kUserIsDeleted];
    [aCoder encodeObject:_roleId forKey:kUserRoleId];
}

- (id)copyWithZone:(NSZone *)zone
{
    User *copy = [[User alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.organizationTypeId = [self.organizationTypeId copyWithZone:zone];
        copy.emailId = [self.emailId copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.phoneNumber = [self.phoneNumber copyWithZone:zone];
        copy.lastname = [self.lastname copyWithZone:zone];
        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.firstname = [self.firstname copyWithZone:zone];
        copy.deviceType = [self.deviceType copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
        copy.deviceToken = [self.deviceToken copyWithZone:zone];
        copy.username = [self.username copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
        copy.roleId = [self.roleId copyWithZone:zone];
    }
    
    return copy;
}


@end
