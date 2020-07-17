// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDScoreMatrix.m instead.

#import "_CDScoreMatrix.h"

const struct CDScoreMatrixAttributes CDScoreMatrixAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.endRange = @"endRange",
	.matrixDescription = @"matrixDescription",
	.matrixTitle = @"matrixTitle",
	.modifiedDate = @"modifiedDate",
	.scoreMatrixId = @"scoreMatrixId",
	.startRange = @"startRange",
};

@implementation CDScoreMatrixID
@end

@implementation _CDScoreMatrix

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDScoreMatrix" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDScoreMatrix";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDScoreMatrix" inManagedObjectContext:moc_];
}

- (CDScoreMatrixID*)objectID {
	return (CDScoreMatrixID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic endRange;

@dynamic matrixDescription;

@dynamic matrixTitle;

@dynamic modifiedDate;

@dynamic scoreMatrixId;

@dynamic startRange;

@end

