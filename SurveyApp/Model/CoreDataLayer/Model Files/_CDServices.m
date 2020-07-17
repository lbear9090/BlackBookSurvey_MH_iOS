// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDServices.m instead.

#import "_CDServices.h"

const struct CDServicesAttributes CDServicesAttributes = {
	.categoryID = @"categoryID",
	.categoryName = @"categoryName",
	.parentCategory = @"parentCategory",
};

@implementation CDServicesID
@end

@implementation _CDServices

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDServices" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDServices";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDServices" inManagedObjectContext:moc_];
}

- (CDServicesID*)objectID {
	return (CDServicesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic categoryID;

@dynamic categoryName;

@dynamic parentCategory;

@end

