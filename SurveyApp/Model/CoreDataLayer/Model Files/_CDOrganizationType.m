// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDOrganizationType.m instead.

#import "_CDOrganizationType.h"

const struct CDOrganizationTypeAttributes CDOrganizationTypeAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.isOptional = @"isOptional",
	.level = @"level",
	.modifiedDate = @"modifiedDate",
	.organizationTypeId = @"organizationTypeId",
	.organizationTypeName = @"organizationTypeName",
	.parentId = @"parentId",
};

@implementation CDOrganizationTypeID
@end

@implementation _CDOrganizationType

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDOrganizationType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDOrganizationType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDOrganizationType" inManagedObjectContext:moc_];
}

- (CDOrganizationTypeID*)objectID {
	return (CDOrganizationTypeID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic isOptional;

@dynamic level;

@dynamic modifiedDate;

@dynamic organizationTypeId;

@dynamic organizationTypeName;

@dynamic parentId;

@end

