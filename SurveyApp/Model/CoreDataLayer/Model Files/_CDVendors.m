// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDVendors.m instead.

#import "_CDVendors.h"

const struct CDVendorsAttributes CDVendorsAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.modifiedDate = @"modifiedDate",
	.vendorId = @"vendorId",
	.vendorName = @"vendorName",
};

@implementation CDVendorsID
@end

@implementation _CDVendors

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDVendors" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDVendors";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDVendors" inManagedObjectContext:moc_];
}

- (CDVendorsID*)objectID {
	return (CDVendorsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic modifiedDate;

@dynamic vendorId;

@dynamic vendorName;

@end

