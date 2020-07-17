// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSurveyType.m instead.

#import "_CDSurveyType.h"

const struct CDSurveyTypeAttributes CDSurveyTypeAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.level = @"level",
	.modifiedDate = @"modifiedDate",
	.parentId = @"parentId",
	.surveyTypeId = @"surveyTypeId",
	.surveyTypeName = @"surveyTypeName",
};

@implementation CDSurveyTypeID
@end

@implementation _CDSurveyType

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDSurveyType" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDSurveyType";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDSurveyType" inManagedObjectContext:moc_];
}

- (CDSurveyTypeID*)objectID {
	return (CDSurveyTypeID*)[super objectID];
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

@dynamic surveyTypeId;

@dynamic surveyTypeName;

@end

