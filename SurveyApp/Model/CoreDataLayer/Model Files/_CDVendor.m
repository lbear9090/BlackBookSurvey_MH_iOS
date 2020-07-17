// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDVendor.m instead.

#import "_CDVendor.h"

const struct CDVendorAttributes CDVendorAttributes = {
	.categoryID = @"categoryID",
	.categoryName = @"categoryName",
	.parentCategory = @"parentCategory",
};

@implementation CDVendorID
@end

@implementation _CDVendor

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDVendor" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDVendor";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDVendor" inManagedObjectContext:moc_];
}

- (CDVendorID*)objectID {
	return (CDVendorID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic categoryID;

@dynamic categoryName;

@dynamic parentCategory;

@end

