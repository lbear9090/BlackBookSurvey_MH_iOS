// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDQuestions.m instead.

#import "_CDQuestions.h"

const struct CDQuestionsAttributes CDQuestionsAttributes = {
	.createdDate = @"createdDate",
	.deleted = @"deleted",
	.modifiedDate = @"modifiedDate",
	.optionCount = @"optionCount",
	.questionDescription = @"questionDescription",
	.questionFormat = @"questionFormat",
	.questionId = @"questionId",
	.questionTitle = @"questionTitle",
	.questionType = @"questionType",
	.userResponse = @"userResponse",
};

@implementation CDQuestionsID
@end

@implementation _CDQuestions

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"CDQuestions" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"CDQuestions";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"CDQuestions" inManagedObjectContext:moc_];
}

- (CDQuestionsID*)objectID {
	return (CDQuestionsID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createdDate;

@dynamic deleted;

@dynamic modifiedDate;

@dynamic optionCount;

@dynamic questionDescription;

@dynamic questionFormat;

@dynamic questionId;

@dynamic questionTitle;

@dynamic questionType;

@dynamic userResponse;

@end

