//
//  Vendors.m
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Vendors.h"


NSString *const kVendorsCreatedDate = @"created_date";
NSString *const kVendorsId = @"id";
NSString *const kVendorsVendorName = @"vendor_name";
NSString *const kVendorsModifiedDate = @"modified_date";
NSString *const kVendorsIsDeleted = @"is_deleted";


@interface Vendors ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Vendors

@synthesize createdDate = _createdDate;
@synthesize vendorId = _vendorId;
@synthesize vendorName = _vendorName;
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
            self.createdDate = [self objectOrNilForKey:kVendorsCreatedDate fromDictionary:dict];
            self.vendorId = [self objectOrNilForKey:kVendorsId fromDictionary:dict];
            self.vendorName = [self objectOrNilForKey:kVendorsVendorName fromDictionary:dict];
            self.modifiedDate = [self objectOrNilForKey:kVendorsModifiedDate fromDictionary:dict];
            self.isDeleted = [self objectOrNilForKey:kVendorsIsDeleted fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdDate forKey:kVendorsCreatedDate];
    [mutableDict setValue:self.vendorId forKey:kVendorsId];
    [mutableDict setValue:self.vendorName forKey:kVendorsVendorName];
    [mutableDict setValue:self.modifiedDate forKey:kVendorsModifiedDate];
    [mutableDict setValue:self.isDeleted forKey:kVendorsIsDeleted];

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

    self.createdDate = [aDecoder decodeObjectForKey:kVendorsCreatedDate];
    self.vendorId = [aDecoder decodeObjectForKey:kVendorsId];
    self.vendorName = [aDecoder decodeObjectForKey:kVendorsVendorName];
    self.modifiedDate = [aDecoder decodeObjectForKey:kVendorsModifiedDate];
    self.isDeleted = [aDecoder decodeObjectForKey:kVendorsIsDeleted];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdDate forKey:kVendorsCreatedDate];
    [aCoder encodeObject:_vendorId forKey:kVendorsId];
    [aCoder encodeObject:_vendorName forKey:kVendorsVendorName];
    [aCoder encodeObject:_modifiedDate forKey:kVendorsModifiedDate];
    [aCoder encodeObject:_isDeleted forKey:kVendorsIsDeleted];
}

- (id)copyWithZone:(NSZone *)zone
{
    Vendors *copy = [[Vendors alloc] init];
    
    if (copy) {

        copy.createdDate = [self.createdDate copyWithZone:zone];
        copy.vendorId = [self.vendorId copyWithZone:zone];
        copy.vendorName = [self.vendorName copyWithZone:zone];
        copy.modifiedDate = [self.modifiedDate copyWithZone:zone];
        copy.isDeleted = [self.isDeleted copyWithZone:zone];
    }
    
    return copy;
}


@end
