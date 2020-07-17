// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDPreferences.m instead.

#import "_CDPreferences.h"

const struct CDPreferencesAttributes CDPreferencesAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.modifiedDate = @"modifiedDate",
	.preferenceId = @"preferenceId",
	.preferenceText = @"preferenceText",
};

@implementation CDPreferencesID
@end

@implementation _CDPreferences

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDPreferences" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDPreferences";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDPreferences" inManagedObjectContext:moc_];
}

- (CDPreferencesID*)objectID {
	return (CDPreferencesID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic modifiedDate;

@dynamic preferenceId;

@dynamic preferenceText;

@end

