// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSurveyResponse.m instead.

#import "_CDSurveyResponse.h"

const struct CDSurveyResponseAttributes CDSurveyResponseAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.modifiedDate = @"modifiedDate",
	.questionId = @"questionId",
	.responseText = @"responseText",
	.surveyId = @"surveyId",
	.surveyResponseId = @"surveyResponseId",
};

@implementation CDSurveyResponseID
@end

@implementation _CDSurveyResponse

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDSurveyResponse" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDSurveyResponse";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDSurveyResponse" inManagedObjectContext:moc_];
}

- (CDSurveyResponseID*)objectID {
	return (CDSurveyResponseID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic modifiedDate;

@dynamic questionId;

@dynamic responseText;

@dynamic surveyId;

@dynamic surveyResponseId;

@end

