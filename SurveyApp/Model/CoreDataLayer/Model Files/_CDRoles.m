// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDRoles.m instead.

#import "_CDRoles.h"

const struct CDRolesAttributes CDRolesAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.level = @"level",
	.modifiedDate = @"modifiedDate",
	.parentId = @"parentId",
	.roleId = @"roleId",
	.roleName = @"roleName",
};

@implementation CDRolesID
@end

@implementation _CDRoles

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDRoles" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDRoles";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDRoles" inManagedObjectContext:moc_];
}

- (CDRolesID*)objectID {
	return (CDRolesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic level;

@dynamic modifiedDate;

@dynamic parentId;

@dynamic roleId;

@dynamic roleName;

@end

