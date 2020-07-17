// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDRating.m instead.

#import "_CDRating.h"

const struct CDRatingAttributes CDRatingAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.level = @"level",
	.modifiedDate = @"modifiedDate",
	.parentId = @"parentId",
	.ratingId = @"ratingId",
	.ratingName = @"ratingName",
};

@implementation CDRatingID
@end

@implementation _CDRating

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDRating" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDRating";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDRating" inManagedObjectContext:moc_];
}

- (CDRatingID*)objectID {
	return (CDRatingID*)[super objectID];
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

@dynamic ratingId;

@dynamic ratingName;

@end

