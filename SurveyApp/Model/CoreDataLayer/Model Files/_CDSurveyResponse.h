// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSurveyResponse.h instead.

#import <CoreData/CoreData.h>

extern const struct CDSurveyResponseAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *questionId;
	 __unsafe_unretained NSString *responseText;
	 __unsafe_unretained NSString *surveyId;
	 __unsafe_unretained NSString *surveyResponseId;
} CDSurveyResponseAttributes;

@interface CDSurveyResponseID : NSManagedObjectID {}
@end

@interface _CDSurveyResponse : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDSurveyResponseID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* questionId;

//- (BOOL)validateQuestionId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* responseText;

//- (BOOL)validateResponseText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyId;

//- (BOOL)validateSurveyId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyResponseId;

//- (BOOL)validateSurveyResponseId:(id*)value_ error:(NSError**)error_;

@end

@interface _CDSurveyResponse (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveQuestionId;
- (void)setPrimitiveQuestionId:(NSString*)value;

- (NSString*)primitiveResponseText;
- (void)setPrimitiveResponseText:(NSString*)value;

- (NSString*)primitiveSurveyId;
- (void)setPrimitiveSurveyId:(NSString*)value;

- (NSString*)primitiveSurveyResponseId;
- (void)setPrimitiveSurveyResponseId:(NSString*)value;

@end
