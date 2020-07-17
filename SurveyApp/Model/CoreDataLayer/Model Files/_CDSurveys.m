// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSurveys.m instead.

#import "_CDSurveys.h"

const struct CDSurveysAttributes CDSurveysAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.modifiedDate = @"modifiedDate",
	.organizationTypeId = @"organizationTypeId",
	.roleId = @"roleId",
	.scoreMatrixId = @"scoreMatrixId",
	.surveyId = @"surveyId",
	.surveyName = @"surveyName",
	.surveyScoreObtained = @"surveyScoreObtained",
	.surveyStatus = @"surveyStatus",
	.surveyTypeId = @"surveyTypeId",
	.userId = @"userId",
	.vendorId = @"vendorId",
};

@implementation CDSurveysID
@end

@implementation _CDSurveys

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDSurveys" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDSurveys";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDSurveys" inManagedObjectContext:moc_];
}

- (CDSurveysID*)objectID {
	return (CDSurveysID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic modifiedDate;

@dynamic organizationTypeId;

@dynamic roleId;

@dynamic scoreMatrixId;

@dynamic surveyId;

@dynamic surveyName;

@dynamic surveyScoreObtained;

@dynamic surveyStatus;

@dynamic surveyTypeId;

@dynamic userId;

@dynamic vendorId;

@end

