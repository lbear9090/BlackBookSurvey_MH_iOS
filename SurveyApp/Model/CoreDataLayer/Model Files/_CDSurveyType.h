// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDSurveyType.h instead.

#import <CoreData/CoreData.h>

extern const struct CDSurveyTypeAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *level;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *parentId;
	 __unsafe_unretained NSString *surveyTypeId;
	 __unsafe_unretained NSString *surveyTypeName;
} CDSurveyTypeAttributes;

@interface CDSurveyTypeID : NSManagedObjectID {}
@end

@interface _CDSurveyType : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDSurveyTypeID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;


@property (nonatomic, retain) NSString* deleted;

@property (nonatomic, retain) NSString* level;

//- (BOOL)validateLevel:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* parentId;

//- (BOOL)validateParentId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyTypeId;

//- (BOOL)validateSurveyTypeId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* surveyTypeName;

//- (BOOL)validateSurveyTypeName:(id*)value_ error:(NSError**)error_;

@end

@interface _CDSurveyType (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveLevel;
- (void)setPrimitiveLevel:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveParentId;
- (void)setPrimitiveParentId:(NSString*)value;

- (NSString*)primitiveSurveyTypeId;
- (void)setPrimitiveSurveyTypeId:(NSString*)value;

- (NSString*)primitiveSurveyTypeName;
- (void)setPrimitiveSurveyTypeName:(NSString*)value;

@end
