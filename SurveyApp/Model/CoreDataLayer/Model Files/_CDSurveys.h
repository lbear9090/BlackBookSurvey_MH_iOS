// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSurveys.h instead.

#import <CoreData/CoreData.h>

extern const struct CDSurveysAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *organizationTypeId;
	 __unsafe_unretained NSString *roleId;
	 __unsafe_unretained NSString *scoreMatrixId;
	 __unsafe_unretained NSString *surveyId;
	 __unsafe_unretained NSString *surveyName;
	 __unsafe_unretained NSString *surveyScoreObtained;
	 __unsafe_unretained NSString *surveyStatus;
	 __unsafe_unretained NSString *surveyTypeId;
	 __unsafe_unretained NSString *userId;
	 __unsafe_unretained NSString *vendorId;
} CDSurveysAttributes;

@interface CDSurveysID : NSManagedObjectID {}
@end

@interface _CDSurveys : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDSurveysID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* organizationTypeId;

//- (BOOL)validateOrganizationTypeId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* roleId;

//- (BOOL)validateRoleId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* scoreMatrixId;

//- (BOOL)validateScoreMatrixId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyId;

//- (BOOL)validateSurveyId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyName;

//- (BOOL)validateSurveyName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyScoreObtained;

//- (BOOL)validateSurveyScoreObtained:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyStatus;

//- (BOOL)validateSurveyStatus:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyTypeId;

//- (BOOL)validateSurveyTypeId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* userId;

//- (BOOL)validateUserId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* vendorId;

//- (BOOL)validateVendorId:(id*)value_ error:(NSError**)error_;

@end

@interface _CDSurveys (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveOrganizationTypeId;
- (void)setPrimitiveOrganizationTypeId:(NSString*)value;

- (NSString*)primitiveRoleId;
- (void)setPrimitiveRoleId:(NSString*)value;

- (NSString*)primitiveScoreMatrixId;
- (void)setPrimitiveScoreMatrixId:(NSString*)value;

- (NSString*)primitiveSurveyId;
- (void)setPrimitiveSurveyId:(NSString*)value;

- (NSString*)primitiveSurveyName;
- (void)setPrimitiveSurveyName:(NSString*)value;

- (NSString*)primitiveSurveyScoreObtained;
- (void)setPrimitiveSurveyScoreObtained:(NSString*)value;

- (NSString*)primitiveSurveyStatus;
- (void)setPrimitiveSurveyStatus:(NSString*)value;

- (NSString*)primitiveSurveyTypeId;
- (void)setPrimitiveSurveyTypeId:(NSString*)value;

- (NSString*)primitiveUserId;
- (void)setPrimitiveUserId:(NSString*)value;

- (NSString*)primitiveVendorId;
- (void)setPrimitiveVendorId:(NSString*)value;

@end
